#!/usr/bin/env python3
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Tests for the parts of tools/feedback that need no database or network:
#   python3 -m unittest test_feedback      (from tools/feedback)

import hashlib
import unittest

import feedback_common as common

CRASH = """==============================================================================
World of WarCraft: Retail Build (build 18414)

Exe:      C:\\Games\\WoW\\Wow-64.exe
Time:     Nov 26, 2026  4:26:05.724 PM
User:     someone
Computer: SOMEPC
------------------------------------------------------------------------------

This application has encountered a critical error:

ERROR #132 (0x85100084) Fatal exception!

Program:\tC:\\Games\\WoW\\Wow-64.exe
ProcessID:\t19948
Exception:\t0xC0000005 (ACCESS_VIOLATION) at 0033:00007FF6EA20458E

The instruction at "0x00007FF6EA20458E" referenced memory at "0x0000000000000000".
The memory could not be "read".

<Version> 5.4.8.18414
<Wow.Platform> X64
User: Real Name
Computer: SOMEPC
App Up Time: 0 days, 0 hours, 14 minutes, 25 seconds
Session Time(hh:mm:ss): 00:14:22
<CVar.accountName> SECRETACCOUNT
<Inspector.HashBlock:>
DBG-OPTIONS<NoImage NoAddress NoFileLine NoDbgAddr>
DBG-ADDR<00007FF6EA20458E>("Wow-64.exe")
DBG-ADDR<00007FF6EA204A4F>("Wow-64.exe")
<:Inspector.HashBlock>
RAX=0000000000000001
"""


class CrashLogTests(unittest.TestCase):
    def test_summary_has_no_personal_details(self):
        signature, title, summary, build = common.parse_crash_log(CRASH)
        self.assertEqual(build, "5.4.8.18414 X64")
        self.assertIn("ACCESS_VIOLATION", title)
        self.assertIn("Wow-64.exe+458E", summary)
        for private in ("someone", "Real Name", "SOMEPC", "SECRETACCOUNT", "Games", "RAX", "7FF6EA20458E"):
            self.assertNotIn(private, summary + title)

    def test_same_crash_after_aslr_same_signature(self):
        moved = CRASH.replace("7FF6EA2", "7FF61B2")  # image moved by a multiple of 64 KB
        self.assertEqual(common.parse_crash_log(CRASH)[0], common.parse_crash_log(moved)[0])

    def test_other_crash_other_signature(self):
        other = CRASH.replace("EA204A4F", "EA207777")
        self.assertNotEqual(common.parse_crash_log(CRASH)[0], common.parse_crash_log(other)[0])

    def test_not_a_crash_log(self):
        self.assertIsNone(common.parse_crash_log("hello"))


SAVED = """
ErrorCatcherDB = {
\t["errors"] = {
\t\t["Interface\\\\AddOns\\\\X\\\\x.lua:12: attempt to index \\"q\\" \xc3\xa9"] = {
\t\t\t["count"] = 3,
\t\t\t["line"] = 12,
\t\t\t["stack"] = "one\\ntwo",
\t\t\t["ok"] = true,
\t\t},
\t},
\t["session"] = 4,
\t["list"] = {
\t\t"a", -- [1]
\t\t"b", -- [2]
\t},
\t["neg"] = -1.5,
}
Other = nil
"""


class SavedVariablesTests(unittest.TestCase):
    def test_parse(self):
        saved = common.parse_saved_variables(SAVED)
        db = saved["ErrorCatcherDB"]
        key = 'Interface\\AddOns\\X\\x.lua:12: attempt to index "q" \u00e9'
        self.assertEqual(db["errors"][key]["count"], 3)
        self.assertEqual(db["errors"][key]["stack"], "one\ntwo")
        self.assertIs(db["errors"][key]["ok"], True)
        self.assertEqual(db["list"], {1: "a", 2: "b"})
        self.assertEqual(db["neg"], -1.5)
        self.assertIsNone(saved["Other"])

    def test_rejects_code(self):
        with self.assertRaises(common.LuaParseError):
            common.parse_saved_variables('X = os.execute("rm -rf /")')

    def test_rejects_deep_nesting(self):
        with self.assertRaises(common.LuaParseError):
            common.parse_saved_variables("X = " + "{" * 50 + "}" * 50)


class MarkdownTests(unittest.TestCase):
    def test_no_mentions_links_or_html(self):
        text = common.markdown_text("hi @Willzman see #12 GH-3 **b** <img src=x> [x](http://e.vil) ![i](u) `c` www.e.vil")
        self.assertNotIn("@W", text)
        self.assertNotIn("#1", text)
        self.assertNotIn("<img", text)
        self.assertNotIn("](", text)
        self.assertNotIn("**", text)
        self.assertNotIn("`c`", text)
        self.assertNotIn("://", text)
        self.assertNotIn("www.", text)

    def test_blockquote_keeps_lines(self):
        self.assertEqual(common.blockquote("a\n\nb"), "> a\n>\n> b")

    def test_code_block_fence_outlasts_content(self):
        block = common.code_block("x ```` y")
        self.assertTrue(block.startswith("`````\n"))
        self.assertTrue(block.endswith("\n`````"))

    def test_control_and_direction_characters_go(self):
        self.assertEqual(common.clean("a\x00b\u202ec\r\nd"), "abc\nd")


class TokenTests(unittest.TestCase):
    def test_matches_core(self):
        token = "AB" * 32
        self.assertEqual(common.token_hash(token), hashlib.sha256(token.encode()).hexdigest().upper())
        self.assertEqual(common.token_hash(token.lower()), common.token_hash(token))


if __name__ == "__main__":
    unittest.main()
