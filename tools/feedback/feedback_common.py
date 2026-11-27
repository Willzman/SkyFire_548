#!/usr/bin/env python3
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Shared by the feedback upload API (feedback_api.py) and the GitHub worker
# (feedback_worker.py): config, database, upload tokens, the text clean-up for
# GitHub, and the parsers for the launcher's uploads (WoW crash logs and the
# Error Catcher add-on's SavedVariables). See README.md.

import configparser
import hashlib
import os
import re

DEFAULT_CONFIG = "~/skyfire/feedback/feedback.conf"


def expand(path):
    return os.path.abspath(os.path.expanduser(path))


def load_config(path=None):
    path = expand(path or os.environ.get("FEEDBACK_CONFIG", DEFAULT_CONFIG))
    config = configparser.ConfigParser(interpolation=None, inline_comment_prefixes=(";",))
    if not config.read(path):
        raise SystemExit(f"config file not found: {path} (copy feedback.conf.dist)")
    return config


def connect(config, database=None):
    import pymysql
    import pymysql.cursors

    mysql = config["mysql"]
    return pymysql.connect(
        read_default_file=expand(mysql.get("defaults_file", "~/.my.cnf")),
        database=database or mysql.get("auth_db", "auth"),
        charset="utf8mb4",
        autocommit=True,
        cursorclass=pymysql.cursors.DictCursor,
    )


def realms(config):
    """{realm id: (name, world database)} from [realms]."""
    result = {}
    if config.has_section("realms"):
        for key, value in config["realms"].items():
            name, _, world = (part.strip() for part in value.partition(","))
            result[int(key)] = (name, world)
    return result


# ---------------------------------------------------------------------------
# Upload tokens
# ---------------------------------------------------------------------------

TOKEN_RE = re.compile(r"[0-9A-Fa-f]{64}")


def token_hash(token):
    # The core hands out 64 uppercase hex digits and keeps the uppercase hex
    # SHA-256 of exactly that text (BugReportHandler.cpp).
    return hashlib.sha256(token.upper().encode("ascii")).hexdigest().upper()


def account_for_token(db, token):
    """The account id the token belongs to, or None. Banned accounts get None."""
    if not token or not TOKEN_RE.fullmatch(token):
        return None
    digest = token_hash(token)
    with db.cursor() as cur:
        cur.execute("SELECT account_id FROM account_feedback_token WHERE token_hash = %s", (digest,))
        row = cur.fetchone()
        if not row:
            return None
        account = row["account_id"]
        cur.execute("SELECT 1 FROM account_banned WHERE id = %s AND active = 1 "
                    "AND (unbandate = bandate OR unbandate > UNIX_TIMESTAMP())", (account,))
        if cur.fetchone():
            return None
        cur.execute("UPDATE account_feedback_token SET last_used = UNIX_TIMESTAMP() WHERE token_hash = %s", (digest,))
    return account


# ---------------------------------------------------------------------------
# Text from players, made safe for a GitHub issue
# ---------------------------------------------------------------------------

_CONTROL = re.compile(r"[\x00-\x08\x0b-\x1f\x7f​-‏‪-‮⁦-⁩]")
_MARKDOWN = re.compile(r"([\\`*_{}\[\]()#+\-.!|~=:>])")
ZWSP = "​"


def clean(text, limit=None):
    """Drops control and direction characters; folds \r\n; cuts to `limit`."""
    text = str(text or "").replace("\r\n", "\n").replace("\r", "\n")
    text = _CONTROL.sub("", text)
    if limit and len(text) > limit:
        text = text[:limit].rstrip() + " [...]"
    return text


def markdown_text(text, limit=None, one_line=False):
    """Player text as plain text in GitHub markdown: every markdown character
    escaped, HTML escaped, @mentions, issue references and links broken so
    nobody is pinged and nothing links or embeds."""
    text = clean(text, limit)
    if one_line:
        text = " ".join(text.split())
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    text = _MARKDOWN.sub(r"\\\1", text)
    text = text.replace("@", "@" + ZWSP)          # @user, @org/team
    text = text.replace("\\#", "\\#" + ZWSP)       # #123
    text = re.sub(r"(?i)\b(gh)\\-", r"\1" + ZWSP + r"\\-", text)  # GH-123
    text = re.sub(r"(?i)(www)\\\.", r"\1" + ZWSP + r"\\.", text)  # www.example.com
    text = text.replace("://", ":" + ZWSP + "//")                 # http://, so nothing autolinks
    return text


def blockquote(text, limit=None):
    lines = markdown_text(text, limit).split("\n")
    return "\n".join("> " + line if line else ">" for line in lines)


def code_block(text, language=""):
    """Text in a fenced block, with a fence longer than any backtick run in it."""
    text = clean(text)
    longest = max((len(run) for run in re.findall(r"`+", text)), default=0)
    fence = "`" * max(3, longest + 1)
    return f"{fence}{language}\n{text}\n{fence}"


def table_cell(text, limit=200):
    return markdown_text(text, limit, one_line=True) or " "


# ---------------------------------------------------------------------------
# SavedVariables (the subset WoW writes)
# ---------------------------------------------------------------------------

class LuaParseError(ValueError):
    pass


_TOKEN = re.compile(r"""
    (?P<space>\s+|--[^\n]*)
  | (?P<string>"(?:[^"\\\n]|\\.|\\\n)*")
  | (?P<number>-?(?:0[xX][0-9a-fA-F]+|(?:\d+\.?\d*|\.\d+)(?:[eE][-+]?\d+)?))
  | (?P<name>[A-Za-z_][A-Za-z0-9_]*)
  | (?P<symbol>[{}\[\]=,;])
""", re.VERBOSE | re.DOTALL)

_ESCAPES = {"n": "\n", "t": "\t", "r": "\r", "a": "\a", "b": "\b", "f": "\f", "v": "\v",
            "\\": "\\", '"': '"', "'": "'", "\n": "\n"}


def _lua_string(body):
    out = []
    i = 0
    while i < len(body):
        c = body[i]
        if c == "\\" and i + 1 < len(body):
            nxt = body[i + 1]
            if nxt.isdigit():
                digits = re.match(r"\d{1,3}", body[i + 1:]).group(0)
                out.append(chr(int(digits)))
                i += 1 + len(digits)
                continue
            out.append(_ESCAPES.get(nxt, nxt))
            i += 2
            continue
        out.append(c)
        i += 1
    # The file is read as Latin-1 (one character per byte); WoW writes UTF-8.
    return "".join(out).encode("latin-1", "replace").decode("utf-8", "replace")


def parse_saved_variables(text, max_depth=20):
    """{global name: value} from a SavedVariables file, decoded as Latin-1
    (one character per byte). Tables become dicts
    (keys as written; array items keyed 1, 2, ...)."""
    tokens = []
    pos = 0
    while pos < len(text):
        m = _TOKEN.match(text, pos)
        if not m:
            raise LuaParseError(f"unexpected character at {pos}")
        pos = m.end()
        kind = m.lastgroup
        if kind != "space":
            tokens.append((kind, m.group(kind)))

    index = 0

    def peek():
        return tokens[index] if index < len(tokens) else (None, None)

    def take(kind=None, value=None):
        nonlocal index
        tok = peek()
        if tok[0] is None or (kind and tok[0] != kind) or (value and tok[1] != value):
            raise LuaParseError(f"expected {value or kind}, got {tok[1]!r}")
        index += 1
        return tok

    def value(depth):
        kind, tok = peek()
        if kind == "string":
            take()
            return _lua_string(tok[1:-1])
        if kind == "number":
            take()
            return int(tok, 16) if tok.lower().startswith(("0x", "-0x")) else (float(tok) if any(c in tok for c in ".eE") else int(tok))
        if kind == "name" and tok in ("true", "false", "nil"):
            take()
            return {"true": True, "false": False, "nil": None}[tok]
        if tok == "{":
            if depth >= max_depth:
                raise LuaParseError("tables nested too deep")
            take()
            table = {}
            next_index = 1
            while peek()[1] != "}":
                if peek()[1] == "[":
                    take()
                    key = value(depth + 1)
                    take("symbol", "]")
                    take("symbol", "=")
                    table[key] = value(depth + 1)
                elif peek()[0] == "name" and index + 1 < len(tokens) and tokens[index + 1][1] == "=":
                    key = take()[1]
                    take()
                    table[key] = value(depth + 1)
                else:
                    table[next_index] = value(depth + 1)
                    next_index += 1
                if peek()[1] in (",", ";"):
                    take()
            take("symbol", "}")
            return table
        raise LuaParseError(f"unexpected {tok!r}")

    result = {}
    while index < len(tokens):
        name = take("name")[1]
        take("symbol", "=")
        result[name] = value(0)
    return result


# ---------------------------------------------------------------------------
# WoW crash logs (Errors\*.txt)
# ---------------------------------------------------------------------------

_FRAME = re.compile(r'DBG-ADDR<([0-9A-Fa-f]+)>\("([^"]*)"\)')


def _header(text, label):
    m = re.search(r"^" + re.escape(label) + r"\s*(.+)$", text, re.MULTILINE)
    return m.group(1).strip() if m else ""


def parse_crash_log(text):
    """Returns (signature, title, summary, build), or None when this isn't a
    WoW crash log. The summary is the only part posted publicly: the error,
    the exception and the top frames as module+offset, the build and the
    session times. No user or computer names, paths, settings, registers or
    memory."""
    if "World of WarCraft" not in text[:400] or "ERROR #" not in text:
        return None

    error = _header(text, "ERROR #")
    error_line = "ERROR #" + error if error else ""
    exception = _header(text, "Exception:")
    instruction = re.search(r'^The instruction at "0x[0-9A-Fa-f]+" referenced memory at "0x([0-9A-Fa-f]+)"\.\s*\n'
                            r'The memory could not be "(\w+)"', text, re.MULTILINE)
    version = _header(text, "<Version>")
    platform = _header(text, "<Wow.Platform>")

    # The line after the error, for errors without an exception ("Invalid function pointer: ...").
    detail = ""
    m = re.search(r"^ERROR #.*\n\n(?:Program:.*\n)?(?:ProcessID:.*\n)?(?:Exception:.*\n)?\n?(.+)$", text, re.MULTILINE)
    if m and not m.group(1).startswith(("The instruction", "<")):
        detail = m.group(1).strip()

    # Top frames from the hash block (the same frames Blizzard used to group
    # crashes), else the assertion block. Addresses move with ASLR in 64 KB
    # steps, so only the low 16 bits are kept: module+offset.
    block = re.search(r"<Inspector.HashBlock:>(.*?)<:Inspector.HashBlock>", text, re.DOTALL) \
        or re.search(r"<Inspector.Assertion:>(.*?)<:Inspector.Assertion>", text, re.DOTALL)
    frames = []
    for address, module in _FRAME.findall(block.group(1) if block else ""):
        module = os.path.basename(module.replace("\\", "/")) or "?"
        frames.append(f"{module}+{int(address, 16) & 0xFFFF:04X}")
    frames = frames[:8]

    # Numbers in the detail (pointers, sizes) differ between crashes of the same bug.
    detail_key = re.sub(r"\b(0x)?[0-9A-Fa-f]{6,}\b", "#", detail)
    access = instruction.group(2) if instruction else ""
    null_access = bool(instruction) and int(instruction.group(1), 16) < 0x10000
    signature_text = "|".join([error_line, re.sub(r" at .*$", "", exception), access,
                               "null" if null_access else "", detail_key] + frames)
    signature = hashlib.sha256(signature_text.encode("utf-8")).hexdigest()

    short_exception = re.sub(r"^0x[0-9A-Fa-f]+ \((\w+)\).*$", r"\1", exception)
    title = " ".join(part for part in [
        error_line.split(" (")[0],
        short_exception,
        (f"{access} of {'null' if null_access else 'memory'}" if access else ""),
        (f"in {frames[0]}" if frames else detail_key[:60]),
    ] if part)[:180]

    lines = [error_line]
    if exception:
        lines.append("Exception: " + re.sub(r" at [0-9A-Fa-f:]+$", "", exception))
    if access:
        lines.append(f"Memory could not be {access} ({'null pointer' if null_access else 'non-null address'})")
    if detail:
        lines.append(detail_key)
    for label in ("App Up Time:", "Session Time(hh:mm:ss):", "Time in World(hh:mm:ss):"):
        found = _header(text, label)
        if found:
            lines.append(f"{label} {found}")
    lines.append("Top frames (module+offset):")
    lines.extend("  " + f for f in frames or ["(none in the log)"])
    build = " ".join(part for part in (version, platform) if part)
    return signature, title, "\n".join(lines), build

