-- characters database
-- Play-tester findings: the server problems bots ran into, one row per
-- (type, subject, detail). Apply to the characters DB (not world/auth).
-- Also created automatically on module load via CREATE TABLE IF NOT EXISTS;
-- this file is the reference schema for tooling / manual apply.
--
-- type (BotFindingType in src/BotFindings.h), subject, detail:
--    1 quest-no-starter      quest
--    2 starter-no-spawn      quest, starter entry
--    3 starter-missing       quest, starter entry
--    4 accept-failed         quest
--    5 objective-no-spawn    quest, objective creature entry
--    6 kill-no-credit        quest, creature entry
--    7 quest-stalled         quest, objective creature entry (0 for an item objective)
--    8 quest-no-ender        quest
--    9 ender-no-spawn        quest, ender entry
--   10 ender-missing         quest, ender entry
--   11 turnin-failed         quest
--   12 questgiver-no-quests  creature entry
--   13 path-failed           map, 50-yard position cell
--   14 stuck                 map, 50-yard position cell
--   15 bad-position          map, 50-yard position cell
--   16 spell-never-casts     spell, specialization
--   17 interact-no-credit    quest, object or NPC entry
-- map/zone/position_* are where the first bot met the problem; first_seen and
-- last_seen are unix timestamps; bot is the last reporter.

CREATE TABLE IF NOT EXISTS `playerbots_findings` (
  `id` INT UNSIGNED NOT NULL,
  `type` TINYINT UNSIGNED NOT NULL,
  `subject` INT UNSIGNED NOT NULL DEFAULT 0,
  `detail` INT UNSIGNED NOT NULL DEFAULT 0,
  `map` INT UNSIGNED NOT NULL DEFAULT 0,
  `zone` INT UNSIGNED NOT NULL DEFAULT 0,
  `position_x` FLOAT NOT NULL DEFAULT 0,
  `position_y` FLOAT NOT NULL DEFAULT 0,
  `position_z` FLOAT NOT NULL DEFAULT 0,
  `hits` INT UNSIGNED NOT NULL DEFAULT 1,
  `first_seen` INT UNSIGNED NOT NULL DEFAULT 0,
  `last_seen` INT UNSIGNED NOT NULL DEFAULT 0,
  `bot` VARCHAR(12) NOT NULL DEFAULT '',
  `note` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `finding` (`type`, `subject`, `detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
