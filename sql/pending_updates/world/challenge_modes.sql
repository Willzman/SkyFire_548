-- Challenge modes (section 3, P16): world DB rows for the challenge mode core ported from Legends of Azeroth Pandaria
-- 5.4.8 (GPL v2, world DB of 2024-07-22). Safe to run twice.

-- challenge_mode_rewards: money and valor (precision units: 12500 = 125 Valor) per medal, and the realm best's title
-- and achievement, per map (LoA's table and rows)
CREATE TABLE IF NOT EXISTS `challenge_mode_rewards` (
  `map` int(10) unsigned NOT NULL,
  `none_money` int(10) unsigned NOT NULL DEFAULT '0',
  `bronze_money` int(10) unsigned NOT NULL DEFAULT '0',
  `silver_money` int(10) unsigned NOT NULL DEFAULT '0',
  `gold_money` int(10) unsigned NOT NULL DEFAULT '0',
  `none_valor` int(10) unsigned NOT NULL DEFAULT '0',
  `bronze_valor` int(10) unsigned NOT NULL DEFAULT '0',
  `silver_valor` int(10) unsigned NOT NULL DEFAULT '0',
  `gold_valor` int(10) unsigned NOT NULL DEFAULT '0',
  `title` int(10) unsigned NOT NULL DEFAULT '0',
  `platinum_achievement` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Challenge modes: rewards per map and medal';

DELETE FROM `challenge_mode_rewards` WHERE `map` IN (959,960,961,962,994,1001,1004,1007,1011);
INSERT INTO `challenge_mode_rewards` (`map`, `none_money`, `bronze_money`, `silver_money`, `gold_money`, `none_valor`, `bronze_valor`, `silver_valor`, `gold_valor`, `title`, `platinum_achievement`, `comment`) VALUES
(959, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 371, 8432, 'Shado-Pan Monastery'),
(960, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 374, 8430, 'Temple of the Jade Serpent'),
(961, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 373, 8431, 'Stormstout Brewery'),
(962, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 366, 8434, 'Gate of the Setting Sun'),
(994, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 367, 8433, 'Mogu''shan Palace'),
(1001, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 368, 8436, 'Scarlet Halls'),
(1004, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 369, 8437, 'Scarlet Monastery'),
(1007, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 370, 8438, 'Scholomance'),
(1011, 114000, 228000, 342000, 456000, 0, 12500, 15000, 16500, 372, 8439, 'Siege of Niuzao Temple');

-- The Challenger's Orb starts the run
UPDATE `gameobject_template` SET `ScriptName` = 'go_challenge_orb' WHERE `entry` = 211674;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 13872 AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcflag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(13872, 0, 0, 'Yes, start the Challenge.', 61906, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Challenge mode spawns: the orb and start door of the three dungeons SkyFire had none for (LoA's spawns)
DELETE FROM `gameobject` WHERE `guid` BETWEEN 9655000 AND 9655006;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9655000, 211674, 959, 256, 0, 0, 3663.06, 2554.42, 766.969, 0.461468, 0, 0, 0.228692, 0.973499, 7200, 255, 1),     -- Shado-Pan Monastery, LoA 546703
(9655001, 211989, 959, 256, 0, 0, 3666.94, 2556.52, 766.969, 0.481103, 0, 0, 0.238238, 0.971207, 7200, 255, 1),     -- LoA 546704
(9655002, 211674, 960, 256, 0, 0, 948.953, -2501.3, 180.608, 4.39458, 0, 0, 0.810088, -0.586308, 7200, 255, 1),     -- Temple of the Jade Serpent, LoA 546705
(9655003, 211991, 960, 256, 0, 0, 967.469, -2507.24, 180.504, 2.827, 0, 0, 0.987654, 0.156653, 7200, 255, 1),       -- LoA 546706
(9655004, 211991, 960, 256, 0, 0, 930.348, -2495.32, 180.503, 5.96743, 0, 0, 0.987654, 0.156653, 7200, 255, 1),     -- LoA 546724
(9655005, 211674, 1001, 256, 0, 0, 837.096, 607.629, 12.814, 0.61747, 0, 0, 0.303853, 0.952719, 7200, 255, 1),      -- Scarlet Halls, LoA 546713
(9655006, 211989, 1001, 256, 0, 0, 837.403, 603.343, 12.814, 4.72, 0, 0, -0.704411, 0.709793, 7200, 255, 1);        -- LoA 546714

-- Challenge mode (difficulty 8, spawn mask bit 256) uses the heroic dungeon: everything spawned on heroic is spawned
-- on challenge too (LoA spawns these maps with mask 262 = normal + heroic + challenge). Shado-Pan Monastery and the
-- Jade Serpent had no challenge spawns at all; the others only some.
UPDATE `creature` SET `spawnMask` = `spawnMask` | 256 WHERE `map` IN (959,960,961,962,994,1001,1004,1007,1011) AND (`spawnMask` & 4) <> 0;
UPDATE `gameobject` SET `spawnMask` = `spawnMask` | 256 WHERE `map` IN (959,960,961,962,994,1001,1004,1007,1011) AND (`spawnMask` & 4) <> 0;