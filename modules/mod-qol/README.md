# mod-qol

GM quality-of-life helpers for SkyFire 5.4.8. The module is standalone: it
does not require playerbots, and it does not change talents, level, or
location unless a future command is added to do so.

Commands use the existing GM permission (`RBAC_PERM_COMMAND_GM`). New helpers
should be added as extra `.qol` subcommands so this stays one module.

## Setup

1. Re-run CMake so `modules/mod-qol` is picked up, then rebuild worldserver.
2. Copy `conf/qol.conf.dist` next to `worldserver.conf` as **`qol.conf`**.
   The module loads that file on world config load (and on `.qol reload`).
   The `.dist` file alone is not enough.
3. Confirm the worldserver log shows `[mod-qol] Enabled` at startup.

Disable everything with `QoL.Enable = 0` in `qol.conf`.

## Commands

| Command | What it does |
| --- | --- |
| `.qol gear …` | Replace equipped gear with level/spec/quality items |
| `.gear …` | Shortcut for `.qol gear` |
| `.qol riding …` | Teach riding ranks, flying licenses, and two mounts |
| `.qol reload` | Reload `qol.conf` (also `.gear reload`) |

Target tokens (any order with the other arguments):

| Token | Target |
| --- | --- |
| *(none)* | Selected player, or yourself if nothing valid is selected |
| `self` | The character running the command |
| `group` / `party` | Every online group member |
| `<name>` | That online character |

Console use is allowed if you pass an online character name.

---

### `.qol gear` / `.gear`

Replaces every equipped slot except shirt and tabard. Old equipped items in
those slots are **destroyed**, not mailed or bagged. Spec/talents are not
changed; a spec token only affects which items are chosen (stats and weapons).

```
.qol gear [self|group|<name>] [tank|healer|dps|<spec>] [poor|common|uncommon|rare|epic|legendary]
```

Examples:

```
.gear
.gear self epic
.gear feral uncommon
.gear PlayerName enhancement rare
.gear group epic
```

**Quality**

- No rarity token: use `QoL.Gear.MinQuality`–`MaxQuality` (default uncommon–epic).
- With a rarity token and `QoL.Gear.ExactQuality = 1` (default): try that
  quality first, then step down toward MinQuality if a slot has no match.
- With `ExactQuality = 0`: the token is a maximum, MinQuality is the floor
  (playerbots-style band).

Aliases: `grey`/`gray`, `white`, `green`, `blue`, `purple`, `orange`, plus
`quality=epic` / `q=rare`.

**Spec / role**

Default is the player's current specialization (or a class DPS default below
level 10). Optional tokens:

| Role | Tokens |
| --- | --- |
| Tank | `tank`, `prot`, `protection` |
| Healer | `healer`, `heal`, `resto`, `holy` |
| DPS | `dps`, `damage`, `dd` |

| Spec | Tokens |
| --- | --- |
| Shaman | `elemental`/`ele`, `enhancement`/`enh` |
| Druid | `balance`/`moonkin`, `feral`, `guardian` |
| Paladin | `retribution`/`ret` |
| Priest | `shadow`, `discipline`/`disc` |
| Monk | `windwalker`/`ww`, `brewmaster`/`brm`, `mistweaver`/`mw` |
| Hunter | `beastmastery`/`bm`, `marksmanship`/`mm`, `survival`/`surv` |
| Warlock | `affliction`/`aff`, `demonology`/`demo`, `destruction`/`destro` |
| Mage | `arcane`, `fire`, `frost` |
| Warrior | `arms`, `fury` |
| Rogue | `assassination`/`mut`, `combat`, `subtlety`/`sub` |
| Death Knight | `blood`, `unholy` |

Ambiguous words (`holy`, `prot`, `resto`) map to a role so the class's matching
tree is used. A spec that does not belong to the target's class is rejected.

**How items are chosen**

- Required level near the character's level (not a raw item-level cap).
- Armor type for the class (cloth / leather / mail / plate).
- Primary stat for the spec (strength / agility / intellect).
- Weapons match the spec (for example feral prefers staff/polearm; assassination
  dual-wields daggers).
- Among the top item-level candidates for a slot, one is picked at random.

Designer / unobtainable templates are skipped (QA, `TEST` tokens, `Art Template`,
`5.4 Raid - …`, Wildcard/Undetermined placeholders, and similar). Items whose
name is clearly for another class (e.g. `Rogue` on a druid) are skipped unless
the name also includes the player's class.

---

### `.qol riding`

Teaches every MoP riding rank and continent license, then one random faction
ground mount and one random faction flying mount (race/class fit is checked;
neutral fallbacks exist).

```
.qol riding [self|group|<name>]
```

Skills taught (Spell.dbc trainer spells, saved independently):

| Spell | Name |
| --- | --- |
| 33388 | Apprentice Riding |
| 33391 | Journeyman Riding |
| 34090 | Expert Riding |
| 34091 | Artisan Riding |
| 90265 | Master Riding |
| 90267 | Flight Master's License |
| 54197 | Cold Weather Flying |
| 115913 | Wisdom of the Four Winds (Pandaria flying) |
| 130487 | Cloud Serpent Riding |

Mounts already known from the pool are left alone; a new random one is learned
when possible. Already-known riding spells are not re-taught.

## Configuration

`qol.conf` keys (see `conf/qol.conf.dist`):

| Key | Default | Meaning |
| --- | --- | --- |
| `QoL.Enable` | `1` | Master switch for all commands |
| `QoL.Gear.MinQuality` | `2` | Floor when no rarity token is given (`2` = uncommon) |
| `QoL.Gear.MaxQuality` | `4` | Ceiling when no rarity token is given (`4` = epic) |
| `QoL.Gear.ExactQuality` | `1` | `1` = rarity token means that quality; `0` = token is a cap |

## Layout

```
modules/mod-qol/
  README.md
  conf/qol.conf.dist
  src/QoL.h
  src/QoL.cpp              # gear selection + riding
  src/QoLCommands.cpp      # .qol / .gear
  src/mod_qol_loader.cpp   # Addmod_qolScripts()
```

No SQL is required. Core sources are not modified.

## Adding more helpers

Register another subcommand in `QoLCommands.cpp` next to `gear` and `riding`,
and put the logic on `PlayerQoL` in `QoL.cpp` / `QoL.h`. Keep one concern per
subcommand (this module should not grow a second copy of playerbot AI).
