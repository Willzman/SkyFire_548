# mod-tester-playerbots

Player bots for SkyFire (World of Warcraft 5.4.8, Mists of Pandaria) that double
as play-testers. Bots log in as real characters, quest, run dungeons with you,
queue for battlegrounds and arenas, and write down what is broken on the server
while they do it.

It is a port of the AzerothCore [mod-playerbots](https://github.com/mod-playerbots/mod-playerbots)
idea to SkyFire. The behaviour is modeled on that module; the code is written
against the 5.4.8 core.

* [COMMANDS.md](COMMANDS.md): every command and order in full detail.
* [PORTING.md](PORTING.md): what has been ported and how.
* [PORT_BACKLOG.md](PORT_BACKLOG.md): what is left, in priority order.
* [conf/playerbots.conf.dist](conf/playerbots.conf.dist): every setting, with its default.

## What the bots do

* **Play**: all 34 specializations have a combat or healing rotation. Bots
  follow, assist, tank, heal, interrupt, dispel, loot, roll, rest, repair, sell,
  mount and equip upgrades.
* **Quest on their own**: accept, kill, loot, use quest objects, open quest
  chests, talk to quest NPCs, travel to the turn-in and hand in.
* **Group content**: answer dungeon finder role checks and proposals, fill your
  dungeon queue, enter battlegrounds and arenas and fight there.
* **Test the server**: record quests that cannot be accepted, advanced or turned
  in, objectives that are not spawned, kills without credit, places they cannot
  path through and spells that never cast. Run a quest or a whole zone on
  demand and report pass or fail with the step that failed.

Not done yet: battleground objectives (bots brawl, they do not carry flags),
raid finder, boss mechanics, and quests that need an item used or an area
explored. See [PORT_BACKLOG.md](PORT_BACKLOG.md).

## Install

1. Put this repository in your SkyFire source tree as `modules/mod-playerbots`
   and build as usual. The module system compiles and links it automatically.
2. Copy `conf/playerbots.conf.dist` to `playerbots.conf` next to
   `worldserver.conf` and set `Playerbots.Enable = 1`.
3. Start the server. The two module tables (`playerbots_findings`,
   `playerbots_preferred_mounts`, both in the characters database) are created
   on startup; the same schema is in `sql/characters/` for manual use.

## Quick start

```
.playerbots create                 make the bot accounts and characters from the config
.playerbots status                 how many bots are online
.playerbots add Somechar           log one of your own characters in as a bot
/invite Somechar                   bots accept invites; then order them in /p or by whisper
.playerbots test quest 783         have a bot play quest 783 and report PASS or FAIL
.playerbots findings               what the bots have found wrong so far
```

For a pool of random bots set `Playerbots.RandomBots.Enable = 1`,
`Playerbots.RandomBots.MaxBots`, and the `Playerbots.AutoCreate.*` keys, then run
`.playerbots create` (or set `Playerbots.AutoCreate.OnStartup = 1`).

## GM commands

All start with `.playerbots` and need GM permission.

### Bots

| Command | What it does |
| --- | --- |
| `status` | Module state, bot counts, pending logins, activity throttle. |
| `list` | Names and GUIDs of the bots online. |
| `add <name>` | Log an offline character in as a bot. |
| `remove <name>` | Log that bot out. |
| `summon` | Teleport the bots in your group to you. |
| `create` | Create the bot accounts and characters the config asks for. Safe to repeat. |
| `wipe confirm` | Delete every bot account and its characters. |
| `reload` | Re-read `playerbots.conf` and the bot pool. |
| `init [<name>\|all\|self] [tank\|healer\|dps\|<spec>] [rare\|epic\|…] [relevel] [tele]` | Re-apply spec, talents, glyphs, spells and gear. `relevel` rolls a new level from the config band, `tele` scatters the bot to a spot that fits its level and faction. |
| `self [on\|off]` | Put the bot AI on your own character: you move, it fights. |

### Play-tester

| Command | What it does |
| --- | --- |
| `findings [<type>] [<page>]` | List what the bots found, most hits first. |
| `findings types` | The type names you can filter by. |
| `findings go <id>` | Teleport yourself to where a finding was first met. |
| `findings clear <id\|all>` | Delete one finding or all of them. A finding comes back if a bot meets it again. |
| `test quest <id> [<bot>]` | A bot plays the quest from its starter to the turn-in and reports `PASS`, `FAIL` or `SKIPPED`. |
| `test zone [<zone id>]` | Queue every solo quest of a zone (your own zone when left out). |
| `test status` | Queued and running tests, and the totals since startup. |
| `test results [fail]` | The last 20 results, or the last 20 failures. |
| `test stop` | Drop the queue and abort running tests. |

A failed test names the step, for example
`FAIL - objectives: no progress in 300s on - kill 299 'Young Wolf' 3/8 (4 kill(s) gave no credit)`.
`SKIPPED` means the quest could not be exercised: no bot may take it, or an
objective needs something a bot cannot do. Results are kept until the server
restarts; failures are also stored as findings.

### Finding types

| Type | Meaning |
| --- | --- |
| `quest-no-starter`, `quest-no-ender` | No creature or object starts or ends the quest. |
| `starter-no-spawn`, `ender-no-spawn` | The quest giver exists but is not spawned anywhere a bot can go. |
| `starter-missing`, `ender-missing` | The quest giver is spawned in the database but was not at its spawn point. |
| `accept-failed`, `turnin-failed` | The quest giver refused, or the quest log did not change. |
| `objective-no-spawn` | A kill objective whose creature is not in the `creature` table. Scripted summons show up here too. |
| `kill-no-credit` | The bot killed the objective creature and the counter did not move. |
| `interact-no-credit` | The bot used the objective's object, or talked to its NPC, three times with no progress. |
| `quest-stalled` | No objective progress for `Playerbots.Tester.QuestStallMinutes` while the bot was at the objective. |
| `questgiver-no-quests` | A creature with the questgiver flag that starts and ends no quest. |
| `path-failed`, `stuck` | No path to a destination, or the bot stopped making headway. One row per 50-yard cell. |
| `bad-position` | The bot stood where its map has no ground. |
| `spell-never-casts` | The rotation picked a ready spell 8 times in a row and the cast never started. |

A finding is a lead, not a verdict. The hit count is how often bots ran into
it; a dozen hits from different bots is worth more than one.

## Orders

Whisper a bot, or say the order in party or raid chat so every bot in the group
hears it. Prefix a party order with `@tank`, `@heal`, `@dps` or `@ranged` to
address one role: `/p @tank pull`.

| Order | What it does |
| --- | --- |
| `help` | List the orders. |
| `follow` / `come`, `stay` | Follow the leader, or hold position. |
| `summon`, `flee` | Teleport to you; `flee` also drops combat orders. |
| `leave` | Leave the group. |
| `attack`, `tank attack`, `dps attack` | Attack your target: everyone, tanks first, or damage dealers. |
| `pull` | Tanks pull your target or the marked one. |
| `rti <icon>` | Which raid icon bots focus (default skull). |
| `passive`, `aggressive` | Only fight back, or assist normally again. |
| `grind` | Attack anything hostile nearby. |
| `reset` | Clear orders and go back to the role defaults. |
| `heal`, `healer dps`, `save mana [off]` | Healer modes. |
| `eat` / `drink` | Sit and recover. |
| `quests` / `accept` / `turn in` | Use nearby quest givers. |
| `quests all\|completed\|incompleted\|summary` | Whisper the quest log. |
| `go [here\|x y z\|<name>]`, `position save\|go <name>` | Walk somewhere on the current map, or save and reuse a spot. |
| `sell`, `sell all` | Sell grey junk, or greens and better too; repairs at the same vendor. |
| `mount`, `dismount`, `mount prefer <spell>\|clear` | Mount up, or set a favourite mount. |
| `gossip [<n>]` | List or pick an NPC's gossip options. |
| `autogear [reset] [match\|<quality>\|<item level>]` | Upgrade gear for the current spec. |
| `equip upgrades` | Equip anything in the bags that is better than what is worn. |
| `maintenance` | Refresh spells, talents, glyphs, mounts, bags, enchants and gems, and repair. |
| `debug [on\|off]` | Say each combat action in chat. |

### Strategies

`co` (combat) and `nc` (non-combat) switch behaviours on and off, AzerothCore
style: `co +aoe`, `nc -loot`, `co ?` to list. Several at once:
`nc +follow,-grind`.

| | Strategies |
| --- | --- |
| `co` | `tank`, `tank assist`, `dps`, `dps assist`, `threat`, `heal`, `healer dps`, `save mana`, `wait for attack`, `aoe`, `boost`, `cc`, `avoid aoe`, `passive`, `grind`, `debug` |
| `nc` | `follow`, `stay`, `food`, `loot`, `quests`, `heal`, `passive`, `grind` |
| both | `walk` (self-bot only: lets the AI move your character to loot, to its target and out of bad ground) |

Strategies that do not fit the bot's role are refused, so `/p co +healer dps`
only changes healers.

## Settings worth knowing

Every key is documented in [conf/playerbots.conf.dist](conf/playerbots.conf.dist).

| Key | Default | What it controls |
| --- | --- | --- |
| `Playerbots.Enable` | 0 | The whole module. |
| `Playerbots.RandomBots.Enable`, `.MaxBots` | 0, 0 | The pool of random bots kept online. |
| `Playerbots.AutoCreate.*` | | How many bot accounts and characters to create, their levels, faction and role mix. |
| `Playerbots.Activity.Enable` | 1 | Bots far from any real player slow down or freeze to save server time. |
| `Playerbots.Tester.Enable` | 1 | Record findings. |
| `Playerbots.Tester.ActiveBots` | 10 | Random bots that keep playing with no real player near them. |
| `Playerbots.Tester.QuestStallMinutes` | 20 | Questing time without progress before a quest is dropped (and reported, if the bot was at the objective). |
| `Playerbots.Tester.MaxConcurrentTests` | 5 | Directed tests running at once. |
| `Playerbots.Quest.TeleportDistance` | 300 | Questing bots teleport to objectives farther than this, or on another map. 0 = walk only. |
| `Playerbots.RandomBotJoinLfg` | 0 | Random bots fill your dungeon finder queue. |
| `Playerbots.RandomBotJoinBG` | 0 | Random bots queue on both sides of a battleground you queue for. |
| `Playerbots.RandomBotJoinArena` | 0 | Random bots form a team against your arena group. |

Bots in your own group answer dungeon finder checks and take battleground and
arena invitations whatever the three fill settings say.

## Spawn index

Quest travel, directed tests and findings read creature and gameobject spawn
points from an in-memory index built at startup, so bot AI never queries the
database. After changing spawns, `.playerbots reload` rebuilds it on the world
thread; the bulk reads can delay that one update, so avoid repeated reloads
under load. It is a static hint: it knows nothing about phases or what is
currently alive.

## Tests

`python3 tests/test_gear_replacement.py` and `python3 tests/test_spawn_index.py`
compile a function from the real source against stubs. They need a C++
compiler and nothing else. The update-schedule test is plain C++:

```sh
g++ -std=c++17 -Wall -Wextra -Werror tests/BotUpdateScheduleTests.cpp -o /tmp/bot-update-schedule-test
/tmp/bot-update-schedule-test
```
