#!/usr/bin/env python3
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Feedback upload API: takes the screenshots, crash logs and Lua errors the
# launcher sends after (or during) a game session and files them under the
# player's account, next to the bug reports the world server saved. HTTPS
# only, with a self-signed certificate the launcher pins; every request but
# /v1/ping needs the account's upload token ("Authorization: Bearer <token>"),
# which the world server gave the Bug Report add-on. The GitHub worker
# (feedback_worker.py) posts what lands here.
#
#   GET  /v1/ping                     {"ok": true, "server_time": ...}
#   GET  /v1/reports?since=<unix>     this account's recent bug reports (id, time)
#   POST /v1/screenshot               an image; kept only if it matches one of the
#                                     account's reports by time, else 404
#   POST /v1/crash                    an Errors\*.txt crash log
#   POST /v1/crash-dump               the .dmp of an uploaded crash log
#   POST /v1/lua-errors               SavedVariables\!ErrorCatcher.lua
#
# Uploads are the raw file as the body, with headers:
#   X-File-Name    the file's name on the PC (no folders)
#   X-File-Time    its time on the PC (unix seconds)
#   X-Client-Time  the PC's clock now (unix seconds); the difference to the
#                  server's clock moves X-File-Time onto server time
#
# Run: python3 feedback_api.py [--config FILE]. See README.md.

import argparse
import hashlib
import json
import logging
import os
import re
import shutil
import ssl
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse

import feedback_common as common

log = logging.getLogger("feedback-api")

MB = 1024 * 1024


class Limits:
    def __init__(self, api):
        self.screenshot = api.getint("max_screenshot_mb", 10) * MB
        self.crash_log = api.getint("max_crash_log_mb", 2) * MB
        self.dump = api.getint("max_dump_mb", 64) * MB
        self.lua = api.getint("max_lua_mb", 4) * MB
        self.daily = api.getint("daily_quota_mb", 300) * MB
        self.min_free = api.getint("min_free_disk_mb", 2048) * MB
        self.before = api.getint("screenshot_window_before", 90)
        self.after = api.getint("screenshot_window_after", 30)
        self.per_report = api.getint("max_screenshots_per_report", 3)
        self.requests_per_minute = api.getint("requests_per_minute", 120)


class RateLimiter:
    """At most N requests a minute per account (or per address before auth)."""

    def __init__(self, per_minute):
        self.per_minute = per_minute
        self.lock = threading.Lock()
        self.seen = {}

    def allow(self, key):
        now = time.monotonic()
        with self.lock:
            stamps = [t for t in self.seen.get(key, []) if now - t < 60]
            if len(stamps) >= self.per_minute:
                self.seen[key] = stamps
                return False
            stamps.append(now)
            self.seen[key] = stamps
            if len(self.seen) > 10000:
                self.seen = {k: v for k, v in self.seen.items() if v and now - v[-1] < 60}
            return True


class ApiError(Exception):
    def __init__(self, status, message):
        super().__init__(message)
        self.status = status
        self.message = message


SAFE_NAME = re.compile(r"[^A-Za-z0-9 ._()\-]")


def safe_file_name(name):
    name = os.path.basename((name or "").replace("\\", "/")).strip()
    name = SAFE_NAME.sub("_", name)[:120]
    return name or "file"


class Handler(BaseHTTPRequestHandler):
    server_version = "SkyFireFeedback/1"
    protocol_version = "HTTP/1.1"

    # Set by main().
    config = None
    limits = None
    storage = None
    limiter = None

    # --- plumbing -------------------------------------------------------

    def log_message(self, fmt, *args):
        log.info("%s %s", self.client_address[0], fmt % args)

    def reply(self, status, body):
        data = json.dumps(body).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def read_body(self, limit):
        length = self.headers.get("Content-Length")
        if length is None or not length.isdigit():
            raise ApiError(411, "Content-Length needed")
        length = int(length)
        if length > limit:
            raise ApiError(413, f"too large (at most {limit // MB} MB)")
        if length == 0:
            raise ApiError(400, "empty body")
        data = self.rfile.read(length)
        if len(data) != length:
            raise ApiError(400, "body cut short")
        return data

    def account(self, db):
        auth = self.headers.get("Authorization", "")
        token = auth[7:].strip() if auth.startswith("Bearer ") else ""
        account = common.account_for_token(db, token)
        if account is None:
            raise ApiError(401, "unknown upload token")
        if not self.limiter.allow(("account", account)):
            raise ApiError(429, "too many requests")
        return account

    def clock_offset(self):
        """Seconds to add to a time from the PC to get server time."""
        try:
            client = int(self.headers.get("X-Client-Time", ""))
        except ValueError:
            return 0
        offset = int(time.time()) - client
        # More than a day off: don't trust it.
        return offset if abs(offset) < 86400 else 0

    def file_time(self, offset):
        try:
            return int(self.headers.get("X-File-Time", "")) + offset
        except ValueError:
            return int(time.time())

    def check_quota(self, db, account, size):
        with db.cursor() as cur:
            cur.execute(
                "SELECT COALESCE((SELECT SUM(size) FROM bug_report_attachment WHERE account_id = %s AND uploaded_at > UNIX_TIMESTAMP() - 86400), 0) AS used",
                (account,))
            used = int(cur.fetchone()["used"])
        dumps = self.dump_bytes_today(account)
        if used + dumps + size > self.limits.daily:
            raise ApiError(429, "daily upload limit reached")
        if shutil.disk_usage(self.storage).free - size < self.limits.min_free:
            log.error("disk nearly full; refusing uploads")
            raise ApiError(507, "server storage full")

    def dump_bytes_today(self, account):
        folder = os.path.join(self.storage, "crashes", str(account))
        total = 0
        cutoff = time.time() - 86400
        if os.path.isdir(folder):
            for entry in os.scandir(folder):
                if entry.is_file() and entry.stat().st_mtime > cutoff:
                    total += entry.stat().st_size
        return total

    def store(self, kind, account, name, data):
        folder = os.path.join(self.storage, kind, str(account))
        os.makedirs(folder, mode=0o750, exist_ok=True)
        path = os.path.join(folder, name)
        temp = path + ".part"
        with open(temp, "wb") as f:
            f.write(data)
        os.replace(temp, path)
        return path

    # --- requests -------------------------------------------------------

    def do_GET(self):
        self.handle_request(self.route_get)

    def do_POST(self):
        self.handle_request(self.route_post)

    def handle_request(self, route):
        if not self.limiter.allow(("ip", self.client_address[0])):
            self.reply(429, {"error": "too many requests"})
            return
        db = None
        try:
            db = common.connect(self.config)
            status, body = route(db, urlparse(self.path))
            self.reply(status, body)
        except ApiError as e:
            self.close_connection = True
            self.reply(e.status, {"error": e.message})
        except Exception:
            log.exception("request failed: %s %s", self.command, self.path)
            self.close_connection = True
            self.reply(500, {"error": "server error"})
        finally:
            if db:
                db.close()

    def route_get(self, db, url):
        if url.path == "/v1/ping":
            return 200, {"ok": True, "server_time": int(time.time())}
        if url.path == "/v1/reports":
            account = self.account(db)
            query = parse_qs(url.query)
            try:
                since = int(query.get("since", ["0"])[0])
            except ValueError:
                since = 0
            since = max(since, int(time.time()) - 7 * 86400)
            with db.cursor() as cur:
                cur.execute("SELECT id, created_at FROM bug_reports WHERE account_id = %s AND created_at >= %s "
                            "ORDER BY id DESC LIMIT 200", (account, since))
                reports = [{"id": r["id"], "created_at": r["created_at"]} for r in cur.fetchall()]
            return 200, {"server_time": int(time.time()), "reports": reports,
                         "window_before": self.limits.before, "window_after": self.limits.after}
        raise ApiError(404, "not found")

    def route_post(self, db, url):
        routes = {
            "/v1/screenshot": self.post_screenshot,
            "/v1/crash": self.post_crash,
            "/v1/crash-dump": self.post_crash_dump,
            "/v1/lua-errors": self.post_lua_errors,
        }
        handler = routes.get(url.path)
        if not handler:
            raise ApiError(404, "not found")
        account = self.account(db)
        return handler(db, account)

    def post_screenshot(self, db, account):
        name = safe_file_name(self.headers.get("X-File-Name"))
        data = self.read_body(self.limits.screenshot)
        if data[:3] == b"\xff\xd8\xff":
            ext = "jpg"
        elif data[:8] == b"\x89PNG\r\n\x1a\n":
            ext = "png"
        elif name.lower().endswith(".tga"):
            ext = "tga"
        else:
            raise ApiError(415, "not a JPEG, PNG or TGA image")

        taken = self.file_time(self.clock_offset())
        with db.cursor() as cur:
            # The add-on takes the screenshot just before it sends the report,
            # so a report saved a moment after the picture is the one.
            cur.execute(
                "SELECT r.id, r.created_at, (SELECT COUNT(*) FROM bug_report_attachment a WHERE a.report_id = r.id) AS shots "
                "FROM bug_reports r WHERE r.account_id = %s AND r.created_at BETWEEN %s AND %s "
                "ORDER BY ABS(CAST(r.created_at AS SIGNED) - %s) LIMIT 5",
                (account, taken - self.limits.after, taken + self.limits.before, taken))
            match = next((r for r in cur.fetchall() if r["shots"] < self.limits.per_report), None)
        if not match:
            return 404, {"matched": False}

        digest = hashlib.sha256(data).hexdigest()
        with db.cursor() as cur:
            cur.execute("SELECT report_id FROM bug_report_attachment WHERE account_id = %s AND sha256 = %s", (account, digest))
            row = cur.fetchone()
            if row:
                return 200, {"matched": True, "report": f"BUG-{row['report_id']}", "duplicate": True}

        if ext == "tga":
            data, ext = tga_to_png(data)

        self.check_quota(db, account, len(data))
        path = self.store("screenshots", account, f"BUG-{match['id']}-{digest[:16]}.{ext}", data)
        with db.cursor() as cur:
            cur.execute(
                "INSERT IGNORE INTO bug_report_attachment (report_id, account_id, file_name, sha256, size, taken_at, uploaded_at, stored_path) "
                "VALUES (%s, %s, %s, %s, %s, %s, UNIX_TIMESTAMP(), %s)",
                (match["id"], account, name, digest, len(data), taken, path))
        log.info("screenshot %s for BUG-%s (account %s)", name, match["id"], account)
        return 201, {"matched": True, "report": f"BUG-{match['id']}"}

    def post_crash(self, db, account):
        name = safe_file_name(self.headers.get("X-File-Name"))
        if not name.lower().endswith(".txt"):
            raise ApiError(415, "a crash log is a .txt file")
        data = self.read_body(self.limits.crash_log)
        text = data.decode("latin-1")
        parsed = common.parse_crash_log(text)
        if not parsed:
            raise ApiError(415, "not a WoW crash log")
        signature, title, summary, build = parsed
        digest = hashlib.sha256(data).hexdigest()
        crashed = self.file_time(self.clock_offset())

        with db.cursor() as cur:
            cur.execute("SELECT id FROM feedback_crash WHERE account_id = %s AND sha256 = %s", (account, digest))
            if cur.fetchone():
                return 200, {"duplicate": True}

        self.check_quota(db, account, len(data))
        path = self.store("crashes", account, f"{digest[:16]}-{name}", data)
        with db.cursor() as cur:
            cur.execute(
                "INSERT INTO feedback_crash_group (signature, title, summary, build, first_seen, last_seen) "
                "VALUES (%s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE "
                "first_seen = LEAST(first_seen, VALUES(first_seen)), last_seen = GREATEST(last_seen, VALUES(last_seen))",
                (signature, title, summary, build, crashed, crashed))
            cur.execute("SELECT id FROM feedback_crash_group WHERE signature = %s", (signature,))
            group = cur.fetchone()["id"]
            cur.execute(
                "INSERT IGNORE INTO feedback_crash (group_id, account_id, file_name, sha256, crashed_at, uploaded_at, log_path) "
                "VALUES (%s, %s, %s, %s, %s, UNIX_TIMESTAMP(), %s)",
                (group, account, name, digest, crashed, path))
            cur.execute(
                "UPDATE feedback_crash_group g SET occurrences = (SELECT COUNT(*) FROM feedback_crash c WHERE c.group_id = g.id), "
                "accounts = (SELECT COUNT(DISTINCT account_id) FROM feedback_crash c WHERE c.group_id = g.id) WHERE g.id = %s",
                (group,))
        log.info("crash log %s (group %s, account %s)", name, group, account)
        return 201, {"group": group}

    def post_crash_dump(self, db, account):
        name = safe_file_name(self.headers.get("X-File-Name"))
        if not name.lower().endswith(".dmp"):
            raise ApiError(415, "a crash dump is a .dmp file")
        stem = name[:-4]
        with db.cursor() as cur:
            cur.execute("SELECT id, dump_path FROM feedback_crash WHERE account_id = %s AND file_name = %s "
                        "ORDER BY id DESC LIMIT 1", (account, stem + ".txt"))
            crash = cur.fetchone()
        if not crash:
            raise ApiError(409, "upload the crash log (.txt) first")
        if crash["dump_path"]:
            return 200, {"duplicate": True}
        data = self.read_body(self.limits.dump)
        if data[:4] != b"MDMP":
            raise ApiError(415, "not a minidump")
        self.check_quota(db, account, len(data))
        path = self.store("crashes", account, f"{crash['id']}-{name}", data)
        with db.cursor() as cur:
            cur.execute("UPDATE feedback_crash SET dump_path = %s WHERE id = %s", (path, crash["id"]))
        return 201, {"crash": crash["id"]}

    def post_lua_errors(self, db, account):
        data = self.read_body(self.limits.lua)
        try:
            saved = common.parse_saved_variables(data.decode("latin-1"))
        except common.LuaParseError as e:
            raise ApiError(415, f"not a SavedVariables file: {e}")
        errors = (saved.get("ErrorCatcherDB") or {}).get("errors") or {}
        if not isinstance(errors, dict):
            raise ApiError(415, "no ErrorCatcherDB.errors table")

        accepted = 0
        with db.cursor() as cur:
            for key, e in list(errors.items())[:500]:
                if not isinstance(key, str) or not isinstance(e, dict):
                    continue
                count = e.get("count")
                if not isinstance(count, int) or count < 1:
                    continue
                signature = hashlib.sha256(key.encode("utf-8")).hexdigest()
                first = e.get("first") if isinstance(e.get("first"), int) else int(time.time())
                last = e.get("last") if isinstance(e.get("last"), int) else first
                cur.execute(
                    "INSERT INTO feedback_lua_error_group (signature, kind, message, file, line, stack, build, first_seen, last_seen) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE "
                    "first_seen = LEAST(first_seen, VALUES(first_seen)), last_seen = GREATEST(last_seen, VALUES(last_seen))",
                    (signature, str(e.get("kind", "error"))[:16], str(e.get("message", key))[:4000],
                     str(e.get("file") or "")[:255], int(e.get("line") or 0) if isinstance(e.get("line"), (int, float)) else 0,
                     str(e.get("stack") or "")[:8000], str(e.get("build") or "")[:32], first, last))
                cur.execute("SELECT id FROM feedback_lua_error_group WHERE signature = %s", (signature,))
                group = cur.fetchone()["id"]
                # Times in the file are the PC's; good enough for "last seen".
                cur.execute(
                    "INSERT INTO feedback_lua_error_account (group_id, account_id, count, last_seen) VALUES (%s, %s, %s, %s) "
                    "ON DUPLICATE KEY UPDATE count = GREATEST(count, VALUES(count)), last_seen = GREATEST(last_seen, VALUES(last_seen))",
                    (group, account, min(count, 10**9), last))
                cur.execute(
                    "UPDATE feedback_lua_error_group g SET occurrences = (SELECT SUM(count) FROM feedback_lua_error_account a WHERE a.group_id = g.id), "
                    "accounts = (SELECT COUNT(*) FROM feedback_lua_error_account a WHERE a.group_id = g.id) WHERE g.id = %s",
                    (group,))
                accepted += 1
        log.info("lua errors: %d from account %s", accepted, account)
        return 201, {"accepted": accepted}


def tga_to_png(data):
    """GitHub can't show TGA screenshots (the client's other format)."""
    import io
    from PIL import Image

    try:
        image = Image.open(io.BytesIO(data))
        out = io.BytesIO()
        image.convert("RGB").save(out, "PNG", optimize=True)
        return out.getvalue(), "png"
    except Exception:
        raise ApiError(415, "unreadable TGA image")


def main():
    parser = argparse.ArgumentParser(description="Feedback upload API (see README.md)")
    parser.add_argument("--config", help=f"config file (default {common.DEFAULT_CONFIG})")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s: %(message)s")
    config = common.load_config(args.config)
    api = config["api"]

    Handler.config = config
    Handler.limits = Limits(api)
    Handler.storage = common.expand(api.get("storage", "~/skyfire/feedback/files"))
    Handler.limiter = RateLimiter(Handler.limits.requests_per_minute)
    os.makedirs(Handler.storage, mode=0o750, exist_ok=True)

    context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    context.minimum_version = ssl.TLSVersion.TLSv1_2
    context.load_cert_chain(common.expand(api["cert"]), common.expand(api["key"]))

    address = (api.get("bind", "0.0.0.0"), api.getint("port", 8443))
    Handler.timeout = 60  # per connection, so a stalled client can't hold a thread
    server = ThreadingHTTPServer(address, Handler)
    # The TLS handshake happens on the first read, in the request's own
    # thread, not in accept(): a slow client can't hold up the others.
    server.socket = context.wrap_socket(server.socket, server_side=True, do_handshake_on_connect=False)
    server.daemon_threads = True
    log.info("listening on https://%s:%d", *address)
    server.serve_forever()


if __name__ == "__main__":
    main()
