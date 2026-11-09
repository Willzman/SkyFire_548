#!/usr/bin/env python3
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
"""Check that SQL update files are named and placed so the database updater
applies them exactly once.

The updater (DatabaseSetup.cpp) reads every *.sql file directly inside
sql/updates/<db>/, applies them in filename order, and records them by
filename only. So a file that is misnamed, nested in a subfolder, renamed or
deleted after merge is skipped or re-applied without any error.

Always checked (whole tree):
  * sql/updates/<db>/*.sql must be named YYYY_MM_DD_<db>_NN.sql (upstream) or
    YYYY_MM_DD_<db>_custom_NN.sql (this fork), with a real date and <db>
    matching the folder.
  * sql/updates/ may only contain the auth, characters and world folders, and
    those may not contain subfolders.
  * sql/pending_updates/ SQL must sit directly in auth/, characters/ or world/
    and end in lowercase .sql.
  * Update and pending SQL must not name a database: no USE, no
    CREATE/ALTER/DROP DATABASE, and no database-qualified table names such as
    `world`.`creature` or auth.account. Each realm applies the same files to
    its own databases (world_stable, world_dev, ...), so a hard-coded name
    would change the wrong database. information_schema is allowed; use
    DATABASE() for the current database.

With --base REF (changes since REF):
  * Merged files in sql/updates/ must not be deleted or renamed.
    Content changes are reported as warnings.
  * New files in sql/updates/ must use the _custom_ name. Local SQL belongs in
    sql/pending_updates/; promote-pending-sql.yml assigns the final name.
  --upstream-sync relaxes both for changes that come from upstream SkyFire
  (a pull request from main): deletes, renames and upstream-style names are
  then warnings.

Exit code 1 if any error was found.
"""

import argparse
import datetime
import os
import re
import subprocess
import sys

DATABASES = ("auth", "characters", "world")
UPDATES = "sql/updates"
PENDING = "sql/pending_updates"
NAME_RE = re.compile(
    r"^(?P<date>\d{4}_\d{2}_\d{2})_(?P<db>[a-z]+)_(?P<custom>custom_)?(?P<seq>\d{2})\.sql$")

# A table reference: an identifier after a keyword that introduces a table.
IDENT = r"(?:`[^`]+`|[A-Za-z_][A-Za-z0-9_$]*)"
TABLE_KEYWORDS = r"(?:FROM|JOIN|INTO|UPDATE|TABLE|EXISTS|REFERENCES)"
ALLOWED_SCHEMAS = ("information_schema", "performance_schema")
CONTENT_RULES = (
    (re.compile(r"(?:^|;)\s*USE\s+" + IDENT, re.I),
     "USE switches database; remove it. The updater already connects to this realm's database."),
    (re.compile(r"\b(?:CREATE|ALTER|DROP)\s+(?:DATABASE|SCHEMA)\b", re.I),
     "creates/changes a database by name; updates must only touch tables in the current database."),
    (re.compile(r"\b" + TABLE_KEYWORDS + r"\s+(?P<db>" + IDENT + r")\s*\.\s*" + IDENT, re.I),
     "database-qualified table name '{db}.…'; drop the '{db}.' prefix so it works in every realm's database."),
    (re.compile(r"(?<![\w`.])(?P<db>" + IDENT + r")\s*\.\s*" + IDENT + r"\s*\.\s*" + IDENT, re.I),
     "database-qualified column '{db}.table.column'; drop the '{db}.' prefix so it works in every realm's database."),
)

errors = []
warnings = []
github = os.environ.get("GITHUB_ACTIONS") == "true"


def error(path, message, line=None):
    errors.append((path, message, line))


def warn(path, message, line=None):
    warnings.append((path, message, line))


def strip_comments_and_strings(text):
    """Blank out comments and string literals, keeping newlines so line
    numbers still match. Backtick identifiers are kept."""
    out = []
    i, n = 0, len(text)
    while i < n:
        c = text[i]
        nxt = text[i + 1] if i + 1 < n else ""
        if c == "#" or (c == "-" and nxt == "-" and (i + 2 >= n or text[i + 2] in " \t\r\n")):
            end = text.find("\n", i)
            end = n if end == -1 else end
            out.append(" " * (end - i))
            i = end
        elif c == "/" and nxt == "*":
            end = text.find("*/", i + 2)
            end = n if end == -1 else end + 2
            out.append(re.sub(r"[^\n]", " ", text[i:end]))
            i = end
        elif c in "'\"":
            j = i + 1
            while j < n:
                if text[j] == "\\":
                    j += 2
                    continue
                if text[j] == c:
                    if j + 1 < n and text[j + 1] == c:  # doubled quote escape
                        j += 2
                        continue
                    break
                j += 1
            j = min(j + 1, n)
            out.append(re.sub(r"[^\n]", " ", text[i:j]))
            i = j
        elif c == "`":
            end = text.find("`", i + 1)
            end = n if end == -1 else end + 1
            out.append(text[i:end])
            i = end
        else:
            out.append(c)
            i += 1
    return "".join(out)


def check_content(root, rel):
    try:
        with open(os.path.join(root, rel), encoding="utf-8", errors="replace") as handle:
            code = strip_comments_and_strings(handle.read())
    except OSError as exc:
        error(rel, "cannot read file: %s" % exc)
        return
    for pattern, message in CONTENT_RULES:
        for match in pattern.finditer(code):
            db = match.groupdict().get("db")
            if db and db.strip("`").lower() in ALLOWED_SCHEMAS:
                continue
            line = code.count("\n", 0, match.start()) + 1
            # USE matches start at the preceding newline/semicolon.
            line += match.group(0)[:len(match.group(0)) - len(match.group(0).lstrip(";\r\n \t"))].count("\n")
            error(rel, message.format(db=(db or "").strip("`")), line)


def is_sql(name):
    # Same rule as the updater: case-insensitive .sql extension.
    return name.lower().endswith(".sql")


def check_update_name(path):
    """Return the parsed name match, or None after recording an error."""
    folder = path.split("/")[2]
    name = os.path.basename(path)
    match = NAME_RE.match(name)
    if not match:
        error(path, "name must be YYYY_MM_DD_%s_custom_NN.sql (or upstream's YYYY_MM_DD_%s_NN.sql)"
              % (folder, folder))
        return None
    if match.group("db") != folder:
        error(path, "name says '%s' but the file is in sql/updates/%s/" % (match.group("db"), folder))
        return None
    try:
        datetime.datetime.strptime(match.group("date"), "%Y_%m_%d")
    except ValueError:
        error(path, "'%s' is not a real date" % match.group("date"))
        return None
    return match


def check_tree(root):
    updates_root = os.path.join(root, UPDATES)
    if os.path.isdir(updates_root):
        for entry in sorted(os.listdir(updates_root)):
            full = os.path.join(updates_root, entry)
            rel = "%s/%s" % (UPDATES, entry)
            if not os.path.isdir(full):
                if is_sql(entry):
                    error(rel, "SQL must be inside sql/updates/<auth|characters|world>/")
                continue
            if entry not in DATABASES:
                error(rel, "unknown database folder; use auth, characters or world")
                continue
            for name in sorted(os.listdir(full)):
                child = "%s/%s" % (rel, name)
                if os.path.isdir(os.path.join(full, name)):
                    error(child, "subfolders are not scanned by the updater; move the files up")
                elif is_sql(name):
                    check_update_name(child)
                    check_content(root, child)

    pending_root = os.path.join(root, PENDING)
    if os.path.isdir(pending_root):
        for dirpath, dirnames, filenames in os.walk(pending_root):
            dirnames.sort()
            rel_dir = os.path.relpath(dirpath, root).replace(os.sep, "/")
            depth = rel_dir.count("/") - PENDING.count("/")
            for name in sorted(filenames):
                if not is_sql(name):
                    continue
                rel = "%s/%s" % (rel_dir, name)
                parent = rel_dir.split("/")[-1]
                if depth != 1 or parent not in DATABASES:
                    error(rel, "pending SQL must be directly in sql/pending_updates/<auth|characters|world>/")
                elif not name.endswith(".sql"):
                    error(rel, "use a lowercase .sql extension (the promotion workflow only picks up *.sql)")
                else:
                    check_content(root, rel)


def git_changes(root, base):
    out = subprocess.run(
        ["git", "-C", root, "diff", "--name-status", "-M", base, "HEAD", "--", UPDATES],
        check=True, capture_output=True, text=True).stdout
    for line in out.splitlines():
        parts = line.split("\t")
        yield parts[0], parts[1:]


def is_update_file(path):
    parts = path.split("/")
    return len(parts) == 4 and parts[2] in DATABASES and is_sql(parts[3])


def check_changes(root, base, upstream_sync):
    relaxed = warn if upstream_sync else error
    for status, paths in git_changes(root, base):
        kind = status[0]
        if kind == "R":
            old, new = paths
            if is_update_file(old):
                relaxed(new, "renamed from %s; the updater tracks files by name, so it would "
                        "run again under the new name. Keep merged update names unchanged." % old)
        elif kind == "D":
            if is_update_file(paths[0]):
                relaxed(paths[0], "deleted; merged updates must stay so every database "
                        "can be set up the same way. Add a new update that reverts it instead.")
        elif kind == "M":
            if is_update_file(paths[0]):
                warn(paths[0], "content changed after merge; databases that already applied it "
                     "will not re-run it. Prefer a new update file.")
        elif kind in ("A", "C"):
            path = paths[-1]
            if not is_update_file(path):
                continue
            match = NAME_RE.match(os.path.basename(path))
            if match and not match.group("custom"):
                relaxed(path, "new updates in this fork must be named YYYY_MM_DD_<db>_custom_NN.sql "
                        "so they never share a name with upstream's. Put the file in "
                        "sql/pending_updates/<db>/ and let promote-pending-sql.yml name it.")


def report():
    for level, items in (("warning", warnings), ("error", errors)):
        for path, message, line in sorted(items, key=lambda item: (item[0], item[2] or 0)):
            if github:
                where = "file=%s,line=%d" % (path, line) if line else "file=%s" % path
                print("::%s %s::%s" % (level, where, message))
            else:
                where = "%s:%d" % (path, line) if line else path
                print("%s: %s: %s" % (level.upper(), where, message))
    if errors:
        print("\n%d SQL update error(s). See tools/dev/check_sql_names.py for the rules." % len(errors))
    else:
        print("SQL update files OK (%d warning(s))." % len(warnings))


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--root", default=".", help="repository root (default: current directory)")
    parser.add_argument("--base", help="also check changes to sql/updates since this git ref")
    parser.add_argument("--upstream-sync", action="store_true",
                        help="changes come from upstream SkyFire; report upstream-style changes as warnings")
    args = parser.parse_args()

    check_tree(args.root)
    if args.base:
        check_changes(args.root, args.base, args.upstream_sync)
    report()
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
