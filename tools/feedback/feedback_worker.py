#!/usr/bin/env python3
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# GitHub worker for player feedback. Every poll_seconds it:
#
#   1. opens an issue for each new bug report (auth.bug_reports), with a
#      context table, the player's text made safe, and its screenshots;
#   2. publishes screenshots that arrive later, as a comment on the issue;
#   3. opens one issue per crash signature and per Lua error signature, and
#      after that only updates the counts in it (plus a comment when one
#      comes back after its issue was closed);
#   4. reads issues closed or reopened since last time and marks their
#      reports fixed / closed, so the world server tells the player at their
#      next login (BugReport::NotifyFixed).
#
# Screenshots go into a separate public images repository: GitHub's API can't
# attach images to issues, and a ZeroTier-only server can't be loaded by
# GitHub's image proxy. Two fine-grained tokens, so neither can do more than
# its job: issues_token (Issues read/write on the issues repository only) and
# images_token (Contents read/write on the images repository only). Both live
# in the config file on the server, never in the launcher or the add-ons.
#
# With dry_run = true (the default) or --dry-run it only writes what it would
# post to dryrun_dir, changes nothing in the database and stops after one pass.
#
# Run: python3 feedback_worker.py [--config FILE] [--once] [--dry-run]

import argparse
import base64
import datetime
import fnmatch
import json
import logging
import os
import re
import time
import urllib.error
import urllib.request

import feedback_common as common
from feedback_common import blockquote, code_block, markdown_text, table_cell

log = logging.getLogger("feedback-worker")

CLASSES = {1: "Warrior", 2: "Paladin", 3: "Hunter", 4: "Rogue", 5: "Priest", 6: "Death Knight",
           7: "Shaman", 8: "Mage", 9: "Warlock", 10: "Monk", 11: "Druid"}
RACES = {1: "Human", 2: "Orc", 3: "Dwarf", 4: "Night Elf", 5: "Undead", 6: "Tauren", 7: "Gnome",
         8: "Troll", 9: "Goblin", 10: "Blood Elf", 11: "Draenei", 22: "Worgen",
         24: "Pandaren", 25: "Pandaren", 26: "Pandaren"}
CATEGORIES = {"quest": "Quest", "creature": "Creature / NPC", "spell": "Spell / Ability",
              "item": "Item", "zone": "Zone / Map", "other": "Other"}
WOWHEAD = "https://www.wowhead.com/mop-classic"


def utc(timestamp):
    return datetime.datetime.fromtimestamp(int(timestamp), datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")


class RateLimited(Exception):
    def __init__(self, wait):
        super().__init__(f"rate limited for {wait} s")
        self.wait = wait


class GitHub:
    API = "https://api.github.com"

    def __init__(self, repo, token):
        self.repo = repo
        self.token = token

    def call(self, method, path, body=None):
        data = json.dumps(body).encode("utf-8") if body is not None else None
        request = urllib.request.Request(self.API + path, data=data, method=method, headers={
            "Authorization": f"Bearer {self.token}",
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
            "User-Agent": "skyfire-feedback-worker",
            "Content-Type": "application/json",
        })
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                raw = response.read()
                return response.status, json.loads(raw) if raw else None
        except urllib.error.HTTPError as e:
            raw = e.read()
            if e.code in (403, 429) and (e.headers.get("Retry-After") or e.headers.get("X-RateLimit-Remaining") == "0"):
                reset = e.headers.get("X-RateLimit-Reset")
                wait = int(e.headers.get("Retry-After") or (int(reset) - time.time() if reset else 60))
                raise RateLimited(max(wait, 30))
            try:
                return e.code, json.loads(raw)
            except ValueError:
                return e.code, {"message": raw[:200].decode("utf-8", "replace")}

    def expect(self, method, path, body=None, ok=(200, 201)):
        status, result = self.call(method, path, body)
        if status not in ok:
            raise RuntimeError(f"GitHub {method} {path}: {status} {result and result.get('message')}")
        return result

    def create_issue(self, title, body, labels):
        return self.expect("POST", f"/repos/{self.repo}/issues", {"title": title, "body": body, "labels": labels})["number"]

    def update_issue(self, number, **fields):
        return self.expect("PATCH", f"/repos/{self.repo}/issues/{number}", fields)

    def get_issue(self, number):
        return self.expect("GET", f"/repos/{self.repo}/issues/{number}")

    def comment(self, number, body):
        self.expect("POST", f"/repos/{self.repo}/issues/{number}/comments", {"body": body})

    def issues_since(self, since, label):
        page = 1
        while True:
            query = f"state=all&labels={label}&sort=updated&direction=asc&per_page=100&page={page}"
            if since:
                query += f"&since={since}"
            items = self.expect("GET", f"/repos/{self.repo}/issues?{query}")
            for item in items:
                if "pull_request" not in item:
                    yield item
            if len(items) < 100:
                return
            page += 1

    def put_file(self, path, data, message, branch):
        """Commits a file; returns True when it was already there."""
        status, result = self.call("PUT", f"/repos/{self.repo}/contents/{path}", {
            "message": message, "content": base64.b64encode(data).decode("ascii"), "branch": branch})
        if status in (200, 201):
            return False
        if status == 422:  # already there (same path); the name holds the hash, so it's the same file
            return True
        raise RuntimeError(f"GitHub PUT contents {path}: {status} {result and result.get('message')}")


class DryRun:
    """Stands in for GitHub: writes what would be posted to a folder."""

    def __init__(self, folder):
        self.folder = folder
        self.next = 1
        os.makedirs(folder, exist_ok=True)

    def write(self, name, text):
        path = os.path.join(self.folder, name)
        with open(path, "w", encoding="utf-8") as f:
            f.write(text)
        log.info("dry run: wrote %s", path)

    def create_issue(self, title, body, labels):
        number = self.next
        self.next += 1
        self.write(f"issue-{number:03d}.md", f"# {title}\n\nLabels: {', '.join(labels)}\n\n{body}\n")
        return number

    def update_issue(self, number, **fields):
        self.write(f"issue-{number:03d}-update.md", json.dumps(fields, indent=2))

    def get_issue(self, number):
        return {"state": "open", "closed_at": None}

    def comment(self, number, body):
        self.write(f"issue-{number:03d}-comment-{int(time.time() * 1000)}.md", body)

    def issues_since(self, since, label):
        return iter(())

    def put_file(self, path, data, message, branch):
        log.info("dry run: would commit %s (%d bytes)", path, len(data))
        return False


class Worker:
    def __init__(self, config, dry_run):
        self.config = config
        gh = config["github"]
        self.dry_run = dry_run
        self.report_delay = gh.getint("report_delay_seconds", 120)
        self.images_repo = gh.get("images_repo", "").strip()
        self.images_branch = gh.get("images_branch", "main").strip() or "main"
        self.lua_sources = [p.strip() for p in gh.get("lua_error_sources", "FrameXML, Blizzard_*, BugReport, !ErrorCatcher, SoloQueue").split(",") if p.strip()]
        self.lua_min = gh.getint("lua_error_min_occurrences", 1)
        self.realms = common.realms(config)
        if dry_run:
            folder = common.expand(gh.get("dryrun_dir", "~/skyfire/feedback/dryrun"))
            self.issues = DryRun(folder)
            self.images = self.issues
        else:
            repo, token = gh.get("repo", "").strip(), gh.get("issues_token", "").strip()
            if not repo or not token:
                raise SystemExit("[github] repo and issues_token are needed (or set dry_run = true)")
            self.issues = GitHub(repo, token)
            images_token = gh.get("images_token", "").strip()
            self.images = GitHub(self.images_repo, images_token) if self.images_repo and images_token else None
            if not self.images:
                log.warning("no images_repo / images_token: screenshots stay on the server, unposted")
        self.db = common.connect(config)
        self.world = {}

    # --- database -------------------------------------------------------

    def query(self, sql, args=()):
        with self.db.cursor() as cur:
            cur.execute(sql, args)
            return cur.fetchall()

    def execute(self, sql, args=()):
        if self.dry_run:
            return
        with self.db.cursor() as cur:
            cur.execute(sql, args)

    def state(self, name, default=""):
        rows = self.query("SELECT value FROM feedback_state WHERE name = %s", (name,))
        return rows[0]["value"] if rows else default

    def set_state(self, name, value):
        self.execute("REPLACE INTO feedback_state (name, value) VALUES (%s, %s)", (name, str(value)))

    def world_db(self, realm_id):
        if realm_id not in self.world:
            world = self.realms.get(realm_id, (None, None))[1]
            try:
                self.world[realm_id] = common.connect(self.config, world) if world else None
            except Exception as e:
                log.warning("world database %s for realm %s: %s", world, realm_id, e)
                self.world[realm_id] = None
        return self.world[realm_id]

    def world_query(self, realm_id, sql, args):
        db = self.world_db(realm_id)
        if not db:
            return []
        try:
            with db.cursor() as cur:
                cur.execute(sql, args)
                return cur.fetchall()
        except Exception as e:
            log.warning("world lookup failed: %s", e)
            return []

    # --- bug reports ----------------------------------------------------

    def publish_image(self, attachment):
        """Commits a screenshot to the images repository; returns its URL or None."""
        if attachment["image_url"]:
            return attachment["image_url"]
        if not self.images:
            return None
        try:
            with open(attachment["stored_path"], "rb") as f:
                data = f.read()
        except OSError as e:
            log.error("screenshot %s missing: %s", attachment["stored_path"], e)
            return None
        ext = os.path.splitext(attachment["stored_path"])[1].lower() or ".jpg"
        path = f"reports/BUG-{attachment['report_id']}/{attachment['sha256'][:16]}{ext}"
        self.images.put_file(path, data, f"BUG-{attachment['report_id']} screenshot", self.images_branch)
        url = f"https://raw.githubusercontent.com/{self.images_repo}/{self.images_branch}/{path}"
        self.execute("UPDATE bug_report_attachment SET image_url = %s WHERE id = %s", (url, attachment["id"]))
        return url

    def screenshot_markdown(self, report_id, url, n):
        return f"![BUG-{report_id} screenshot {n}]({url})"

    def context_rows(self, r):
        context = {}
        for line in (r["client_context"] or "").split("\n"):
            key, sep, value = line.partition("=")
            if sep:
                context[key.strip()] = value.strip()

        realm = self.realms.get(r["realm_id"], (f"realm {r['realm_id']}", None))[0]
        cls = CLASSES.get(r["class"], f"class {r['class']}")
        race = RACES.get(r["race"], f"race {r['race']}")
        spec = context.get("spec")
        character = f"{r['character_name']}, level {r['level']} {race} {cls}" + (f" ({spec})" if spec else "")

        where = " / ".join(v for v in (context.get("zone"), context.get("subzone")) if v)
        where_ids = f"map {r['map_id']}, zone {r['zone_id']}, area {r['area_id']}" + (f", instance {r['instance_id']}" if r["instance_id"] else "")

        rows = [
            ("Report", f"BUG-{r['id']}"),
            ("Category", CATEGORIES.get(r["category"], r["category"])),
            ("Realm", realm),
            ("Character", character),
            ("Where", f"{where} ({where_ids})" if where else where_ids),
            ("Position", f"X {r['position_x']:.2f}, Y {r['position_y']:.2f}, Z {r['position_z']:.2f}, facing {r['orientation']:.2f}"),
        ]
        if context.get("coords"):
            rows.append(("Map coordinates", context["coords"]))

        target = context.get("target")
        if r["target_entry"]:
            high = (r["target_guid"] >> 52) & 0xFFF
            if high == 0xF11:
                names = self.world_query(r["realm_id"], "SELECT name FROM gameobject_template WHERE entry = %s", (r["target_entry"],))
                kind, link = "object", f"{WOWHEAD}/object={r['target_entry']}"
            else:
                names = self.world_query(r["realm_id"], "SELECT name FROM creature_template WHERE entry = %s", (r["target_entry"],))
                kind, link = "NPC", f"{WOWHEAD}/npc={r['target_entry']}"
            name = names[0]["name"] if names else target or "?"
            rows.append(("Target", ("link", f"{table_cell(name)} ({kind} [{r['target_entry']}]({link}))")))
        elif target:
            rows.append(("Target", f"{target} (player or no entry)"))

        quests = [q for q in (context.get("quests") or "").split(",") if q]
        if quests:
            ids = [int(re.match(r"\d+", q).group(0)) for q in quests if re.match(r"\d+", q)][:40]
            titles = {}
            if ids:
                placeholders = ",".join(["%s"] * len(ids))
                for row in self.world_query(r["realm_id"], f"SELECT Id, Title FROM quest_template WHERE Id IN ({placeholders})", ids):
                    titles[row["Id"]] = row["Title"]
            parts = []
            for q in quests[:40]:
                m = re.match(r"(\d+)([cf]?)", q)
                if not m:
                    continue
                qid, state = int(m.group(1)), {"c": " (complete)", "f": " (failed)"}.get(m.group(2), "")
                parts.append(f"[{qid}]({WOWHEAD}/quest={qid}) {table_cell(titles.get(qid, ''), 80)}{state}")
            rows.append(("Quests", ("link", "<br>".join(parts))))

        client = context.get("build", "")
        if context.get("addon"):
            client += f", Bug Report {context['addon']}"
        rows.append(("Client", client or "?"))
        rows.append(("Server", r["core_revision"]))
        rows.append(("Reported", utc(r["created_at"])))
        return rows

    def render_report(self, r, image_urls):
        desc = r["description"] or ""
        # Titles show as plain text; only @ (just in case) is broken up.
        first_line = " ".join(common.clean(desc).split())[:70].replace("@", "@" + common.ZWSP) or "(no description)"
        title = f"[BUG-{r['id']}] {CATEGORIES.get(r['category'], r['category'])}: {first_line}"

        lines = [f"**Player bug report BUG-{r['id']}**, sent from the game by {table_cell(r['character_name'])}.", "",
                 blockquote(desc, 4000), "", "| | |", "|---|---|"]
        for label, value in self.context_rows(r):
            # Values marked "link" are built here from numbers and escaped names; the rest is escaped now.
            cell = value[1] if isinstance(value, tuple) else table_cell(value)
            lines.append(f"| {label} | {cell} |")
        lines += ["", "<details><summary>Teleport there (GM)</summary>", "",
                  f"```\n.go xyz {r['position_x']:.2f} {r['position_y']:.2f} {r['position_z']:.2f} {r['map_id']} {r['orientation']:.2f}\n```",
                  "", "</details>"]
        if image_urls:
            lines += ["", "### Screenshot" + ("s" if len(image_urls) > 1 else "")]
            lines += [self.screenshot_markdown(r["id"], url, i + 1) for i, url in enumerate(image_urls)]
        lines += ["", "<sub>Opened by the feedback worker from the in-game Bug Report add-on. "
                      "Closing this issue as completed tells the player it was fixed.</sub>"]
        labels = ["player-report", r["category"] if r["category"] in CATEGORIES else "other"]
        return title[:250], "\n".join(lines), labels

    def post_reports(self):
        reports = self.query("SELECT * FROM bug_reports WHERE status = 'new' AND github_issue IS NULL "
                             "AND created_at <= UNIX_TIMESTAMP() - %s ORDER BY id LIMIT 20", (self.report_delay,))
        for r in reports:
            urls, published = [], []
            for a in self.query("SELECT * FROM bug_report_attachment WHERE report_id = %s ORDER BY taken_at", (r["id"],)):
                url = self.publish_image(a)
                if url:
                    urls.append(url)
                    published.append(a["id"])
            title, body, labels = self.render_report(r, urls)
            number = self.issues.create_issue(title, body, labels)
            self.execute("UPDATE bug_reports SET status = 'issued', github_issue = %s WHERE id = %s", (number, r["id"]))
            for attachment_id in published:
                self.execute("UPDATE bug_report_attachment SET posted = 1 WHERE id = %s", (attachment_id,))
            log.info("BUG-%s -> issue #%s", r["id"], number)
            time.sleep(1)

    def post_late_screenshots(self):
        if not self.images:
            return
        rows = self.query("SELECT a.*, r.github_issue FROM bug_report_attachment a JOIN bug_reports r ON r.id = a.report_id "
                          "WHERE a.posted = 0 AND r.github_issue IS NOT NULL ORDER BY a.id LIMIT 20")
        for a in rows:
            url = self.publish_image(a)
            if not url:
                continue
            self.issues.comment(a["github_issue"], f"Screenshot for BUG-{a['report_id']}:\n\n{self.screenshot_markdown(a['report_id'], url, 1)}")
            self.execute("UPDATE bug_report_attachment SET posted = 1 WHERE id = %s", (a["id"],))
            time.sleep(1)

    # --- crashes and Lua errors -----------------------------------------

    def counts_table(self, g, what):
        return "\n".join([
            "| | |", "|---|---|",
            f"| Times seen | {g['occurrences']} |",
            f"| Accounts | {g['accounts']} |",
            f"| First seen | {utc(g['first_seen'])} |",
            f"| Last seen | {utc(g['last_seen'])} |",
            f"| Build | {table_cell(g['build'] or '?')} |",
            "",
            f"<sub>Opened by the feedback worker from {what} the launcher uploads. "
            "Later occurrences update the counts above instead of opening new issues.</sub>",
        ])

    def render_crash(self, g):
        title = f"[Crash] {common.clean(g['title'], 180)}"
        body = "\n".join([
            "**Client crash** reported by the launcher. Grouped by error, exception and top frames; "
            "the full logs and any .dmp files are kept on the server (`auth.feedback_crash`), not posted.", "",
            code_block(g["summary"]), "", self.counts_table(g, "crash logs")])
        return title[:250], body, ["crash"]

    def lua_source(self, g):
        path = (g["file"] or "").replace("/", "\\")
        m = re.match(r"(?i)interface\\addons\\([^\\]+)\\", path)
        if m:
            return m.group(1)
        if path.lower().startswith("interface\\framexml\\"):
            return "FrameXML"
        m = re.match(r"(\S+) tried to call", g["message"] or "")
        return m.group(1) if m else ""

    def lua_wanted(self, g):
        source = self.lua_source(g)
        return "*" in self.lua_sources or any(fnmatch.fnmatch(source.lower(), p.lower()) for p in self.lua_sources)

    def render_lua(self, g):
        message = common.clean(g["message"]).split("\n")[0]
        title = f"[Lua error] {message[:180]}"
        body = "\n".join([
            f"**Lua {table_cell(g['kind'])}** caught by the Error Catcher add-on (source: {table_cell(self.lua_source(g) or '?')}).", "",
            code_block(common.clean(g["message"], 4000)), "",
            "<details><summary>Stack</summary>", "", code_block(common.clean(g["stack"], 6000) or "(none)"), "", "</details>", "",
            self.counts_table(g, "Lua errors")])
        return title[:250], body, ["lua-error"]

    def post_groups(self, table, render, wanted=lambda g: True, minimum=1):
        # github_issue 0 marks a group left unposted on purpose (a Lua error from
        # an add-on not in lua_error_sources); set it back to NULL to post it.
        groups = self.query(f"SELECT * FROM {table} WHERE (github_issue IS NULL AND occurrences >= %s) "
                            f"OR (github_issue > 0 AND occurrences <> posted_occurrences) ORDER BY id LIMIT 30", (minimum,))
        for g in groups:
            if g["github_issue"] is None and not wanted(g):
                self.execute(f"UPDATE {table} SET github_issue = 0, posted_occurrences = occurrences WHERE id = %s", (g["id"],))
                continue
            title, body, labels = render(g)
            if g["github_issue"] is None:
                number = self.issues.create_issue(title, body, labels)
                self.execute(f"UPDATE {table} SET github_issue = %s, posted_occurrences = %s WHERE id = %s",
                             (number, g["occurrences"], g["id"]))
                log.info("%s %s -> issue #%s", table, g["id"], number)
            else:
                issue = self.issues.get_issue(g["github_issue"])
                self.issues.update_issue(g["github_issue"], body=body)
                if issue.get("state") == "closed":
                    more = g["occurrences"] - g["posted_occurrences"]
                    self.issues.comment(g["github_issue"],
                                        f"Seen again after this was closed: {more} more time{'s' if more != 1 else ''} "
                                        f"(last {utc(g['last_seen'])}, build {table_cell(g['build'] or '?')}).")
                self.execute(f"UPDATE {table} SET posted_occurrences = %s WHERE id = %s", (g["occurrences"], g["id"]))
            time.sleep(1)

    # --- closed issues -> reports fixed ----------------------------------

    def sync_closed(self):
        since = self.state("issues_since")
        newest = since
        for issue in self.issues.issues_since(since, "player-report"):
            number = issue["number"]
            if issue["state"] == "closed":
                status = "fixed" if issue.get("state_reason") == "completed" else "closed"
                self.execute("UPDATE bug_reports SET status = %s WHERE github_issue = %s AND status IN ('issued', 'fixed', 'closed')",
                             (status, number))
            else:
                self.execute("UPDATE bug_reports SET status = 'issued' WHERE github_issue = %s AND status IN ('fixed', 'closed')", (number,))
            newest = max(newest, issue["updated_at"]) if newest else issue["updated_at"]
        if newest and newest != since:
            self.set_state("issues_since", newest)

    # --- loop -----------------------------------------------------------

    def run_once(self):
        for step in (self.post_reports, self.post_late_screenshots,
                     lambda: self.post_groups("feedback_crash_group", self.render_crash),
                     lambda: self.post_groups("feedback_lua_error_group", self.render_lua, self.lua_wanted, self.lua_min),
                     self.sync_closed):
            try:
                step()
            except RateLimited:
                raise
            except Exception:
                log.exception("worker step failed")
                self.db.ping(reconnect=True)


def main():
    parser = argparse.ArgumentParser(description="Posts player feedback to GitHub (see README.md)")
    parser.add_argument("--config", help=f"config file (default {common.DEFAULT_CONFIG})")
    parser.add_argument("--once", action="store_true", help="one pass, then stop")
    parser.add_argument("--dry-run", action="store_true", help="write what would be posted to dryrun_dir; change nothing")
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s: %(message)s")
    config = common.load_config(args.config)
    dry_run = args.dry_run or config["github"].getboolean("dry_run", True)
    worker = Worker(config, dry_run)
    poll = config["github"].getint("poll_seconds", 60)
    if dry_run:
        log.info("dry run: nothing is posted and the database is not changed")

    while True:
        try:
            worker.run_once()
        except RateLimited as e:
            log.warning("%s", e)
            time.sleep(e.wait)
            continue
        if args.once or dry_run:
            return
        time.sleep(poll)


if __name__ == "__main__":
    main()
