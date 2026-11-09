-- Gate of the Setting Sun (map 962): DB rows for the scripts ported from
-- Legends-of-Azeroth-Pandaria-5.4.8 (src/server/scripts/Pandaria/GateOfTheSettingSun/).
-- Values come from the LoA world dump (2024-07-22). Safe to run twice.

-- Instance script
UPDATE `instance_template` SET `script` = 'instance_gate_of_the_setting_sun' WHERE `map` = 962;

-- Summoned by Krikthik Engulfers Engulfing Winds
UPDATE `creature_template` SET `ScriptName` = 'npc_engulfing_winds' WHERE `entry` = 56928;

-- Spell scripts
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_prey_time', 'spell_prey_time_vehicle_aura',
    'spell_rimok_viscous_fluid', 'spell_kiptilak_sabotage', 'spell_gadok_strafing', 'spell_raigonn_battering_headbutt',
    'spell_raigonn_stomp', 'spell_kiptilak_munitions_explosion', 'spell_rimok_saboteur_bombard');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(106933, 'spell_prey_time'),
(106934, 'spell_prey_time_vehicle_aura'),
(107078, 'spell_rimok_viscous_fluid'),
(107268, 'spell_kiptilak_sabotage'),
(107343, 'spell_gadok_strafing'),
(111671, 'spell_raigonn_battering_headbutt'),
(111728, 'spell_raigonn_stomp'),
(120552, 'spell_kiptilak_munitions_explosion'),
(120559, 'spell_rimok_saboteur_bombard');

-- Entrance areatrigger: opens the first door and starts Kiptilaks intro
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8359;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(8359, 'at_first_door');

-- Achievement "Bomberman" criteria (heroic only)
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` = 19135 AND `type` = 11;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(19135, 11, 0, 0, 'achievement_bomberman_gss');

-- Boss and event texts (Kiptilak, Gadok, Rimok, Raigonn, falling Serpents Spine Defenders)
DELETE FROM `creature_text` WHERE `entry` IN (56589, 56636, 56877, 56906, 58202);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(56589, 0, 0, 'Keep those archers off the wall. Raigonn must reach the gate.', 14, 0, 0, 0, 0, 29377, 'boss_striker_gadok'),
(56589, 1, 0, 'I\'ll hurl your corpses from this tower.', 14, 0, 0, 0, 0, 29375, 'boss_striker_gadok'),
(56589, 2, 0, 'Our numbers... endless! You... cannot win...', 14, 0, 0, 0, 0, 29376, 'boss_striker_gadok'),
(56589, 3, 0, 'You joined a battle already lost.', 14, 0, 0, 0, 0, 29378, 'boss_striker_gadok'),
(56589, 3, 1, 'Air superiority.', 14, 0, 0, 0, 0, 29379, 'boss_striker_gadok'),
(56589, 3, 2, 'As expected.', 14, 0, 0, 0, 0, 29380, 'boss_striker_gadok'),
(56636, 0, 0, 'There will be no escaping me.', 14, 0, 0, 0, 0, 29074, 'boss_commander_rimok'),
(56636, 1, 0, 'Empress... forgive me!', 14, 0, 0, 0, 0, 29075, 'boss_commander_rimok'),
(56636, 2, 0, 'The gates are about to fall. Quickly! Slaughter these meddlers!', 14, 0, 0, 0, 0, 29076, 'boss_commander_rimok'),
(56636, 3, 0, 'Hahahahaha!', 14, 0, 0, 0, 0, 26321, 'boss_commander_rimok'),
(56636, 3, 1, 'This wall is your grave!', 14, 0, 0, 0, 0, 29078, 'boss_commander_rimok'),
(56636, 3, 2, 'None may stand against us!', 14, 0, 0, 0, 0, 29079, 'boss_commander_rimok'),
(56877, 0, 0, '%s\'s |cFFFF0000Weak Spot|r is exposed! Attack it to break his Impervious Carapace!', 41, 0, 100, 0, 0, 0, 'boss_raigonn'),
(56877, 1, 0, 'The |cFFFE9A2EKrik\'thik Swarm Bringer|r reinforcements join the battle!', 41, 0, 100, 0, 0, 0, 'boss_raigonn'),
(56877, 2, 0, 'The |cFFFE9A2EKrik\'thik Engulfer|r reinforcements appear above!', 41, 0, 100, 0, 0, 0, 'boss_raigonn'),
(56877, 3, 0, 'The |cFFFE9A2EKrik\'thik Protectorate|r reinforcements appear!', 41, 0, 100, 0, 0, 0, 'boss_raigonn'),
(56906, 0, 0, 'Gate?! I\'m going to bring this whole wall down!', 14, 0, 0, 0, 0, 29341, 'boss_saboteur_kiptilak - SAY_INTRO'),
(56906, 1, 0, 'I brought enough bombs... for all of you!', 14, 0, 0, 0, 0, 29339, 'boss_saboteur_kiptilak - SAY_AGGRO'),
(56906, 2, 0, 'BOOM shakalaka!', 14, 0, 0, 0, 0, 29342, 'boss_saboteur_kiptilak - SAY_SLAY'),
(56906, 2, 1, 'I\'m the bomber man...tid!', 14, 0, 0, 0, 0, 29343, 'boss_saboteur_kiptilak - SAY_SLAY'),
(56906, 2, 2, 'You blew it!', 14, 0, 0, 0, 0, 29344, 'boss_saboteur_kiptilak - SAY_SLAY'),
(56906, 3, 0, 'I... blew it...', 14, 0, 0, 0, 0, 29340, 'boss_saboteur_kiptilak - SAY_DEATH'),
(56906, 4, 0, 'You\'re the bomb!', 14, 0, 0, 0, 0, 29345, 'boss_saboteur_kiptilak - SAY_SPECIAL'),
(56906, 4, 1, 'This will be the bomb.', 14, 0, 0, 0, 0, 29346, 'boss_saboteur_kiptilak - SAY_SPECIAL'),
(56906, 4, 2, 'Things that make you go... BOOM!', 14, 0, 0, 0, 0, 29347, 'boss_saboteur_kiptilak - SAY_SPECIAL'),
(56906, 4, 3, 'BOOM! Explosion! Overpowering!', 14, 0, 0, 0, 0, 29348, 'boss_saboteur_kiptilak - SAY_SPECIAL'),
(56906, 4, 4, 'There goes the BOOM!', 14, 0, 0, 0, 0, 29349, 'boss_saboteur_kiptilak - SAY_SPECIAL'),
(58202, 0, 0, 'Help!', 14, 0, 100, 0, 0, 0, 'Serpent\'s Spine Defender'),
(58202, 0, 1, 'Mmmphhh', 14, 0, 100, 0, 0, 0, 'Serpent\'s Spine Defender'),
(58202, 0, 2, 'The mantid are coming over the wall!', 14, 0, 100, 0, 0, 0, 'Serpent\'s Spine Defender');

-- Gameobject templates: SkyFire only had unk name type-0 stubs. The walls must be
-- destructible buildings (type 33) for SetDestructibleState, the bombs are traps (type 6).
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_VEB_greatDoorPhase_001', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 114, `flags` = 16 WHERE `entry` = 211245;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_VEB_greatDoorPhase_003', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 114, `flags` = 16 WHERE `entry` = 211246;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_GreatWall_Door_001', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 212982;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_GreatWall_Door_002', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 212983;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_GreatWall_Door_005', `size` = 1, `data0` = 1, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 212985;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_GreatWall_Door_014', `size` = 1.00968, `data0` = 1, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 212986;
UPDATE `gameobject_template` SET `type` = 33, `name` = 'Corner Piece C', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 78, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 153, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 114, `flags` = 32 WHERE `entry` = 213198;
UPDATE `gameobject_template` SET `type` = 33, `name` = 'Wall Corner B', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 78, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 152, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 114, `flags` = 32 WHERE `entry` = 213199;
UPDATE `gameobject_template` SET `type` = 33, `name` = 'Corner A', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 78, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 151, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 114, `flags` = 32 WHERE `entry` = 213200;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Signal Fire', `size` = 1, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 0, `flags` = 0 WHERE `entry` = 213507;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Courtyard Portcullis', `size` = 1.48464, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 214261;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Great Wall - Demolition Crew - Boss Wall', `size` = 1, `data0` = 1, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 0, `flags` = 0 WHERE `entry` = 214629;
UPDATE `gameobject_template` SET `type` = 0, `name` = 'Doodad_GreatWall_Door_020', `size` = 1.1, `data0` = 1, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 0, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 35, `flags` = 16 WHERE `entry` = 214888;
UPDATE `gameobject_template` SET `type` = 6, `name` = 'Mantid Bomb', `size` = 2, `data0` = 0, `data1` = 0, `data2` = 0, `data3` = 0, `data4` = 0, `data5` = 0, `data6` = 0, `data7` = 0, `data8` = 0, `data9` = 0, `data10` = 0, `data11` = 0, `data12` = 0, `data13` = 0, `data14` = 0, `data15` = 5793, `data16` = 0, `data17` = 0, `data18` = 0, `data19` = 0, `data20` = 0, `data21` = 0, `data22` = 0, `data23` = 0, `data24` = 0, `data25` = 0, `data26` = 0, `data27` = 0, `data28` = 0, `data29` = 0, `data30` = 0, `data31` = 0, `unkInt32` = 0, `faction` = 0, `flags` = 16 WHERE `entry` = 215757;

-- Spawns SkyFire lacks on map 962 and the scripts need: Striker Gadok, Raigonn,
-- the artillery vehicles, explosion target 1, the boss doors/walls and Kiptilaks bombs.
-- New GUID blocks (creature 8470000-8470099, gameobject 1040000-1040099), above the
-- forks current maximum; LoAs GUIDs are noted per row.
DELETE FROM `creature` WHERE `guid` BETWEEN 8470000 AND 8470099;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`,
    `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(8470000, 56589, 962, 262, 0, 0, 0, 0, 1234.36, 2304.07, 430.896, 6.16101, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 541727
(8470001, 63992, 962, 262, 0, 0, 0, 0, 832.122, 2375.98, 390.539, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 541858
(8470002, 59819, 962, 262, 0, 0, 0, 0, 930.719, 2238.33, 296.189, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542293
(8470003, 59819, 962, 262, 0, 0, 0, 0, 1006.88, 2308.83, 296.189, 1.55666, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542295
(8470004, 66904, 962, 262, 0, 0, 0, 0, 1051.01, 2229, 311.417, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542296
(8470005, 59819, 962, 262, 0, 0, 0, 0, 906.984, 2308.54, 296.189, 1.5972, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542297
(8470006, 59819, 962, 262, 0, 0, 0, 0, 1052.98, 2239.54, 296.189, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542305
(8470007, 56877, 962, 262, 0, 0, 0, 0, 958.269, 2330.16, 296.188, 4.67748, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542307
(8470008, 59819, 962, 262, 0, 0, 0, 0, 852.439, 2290.71, 296.189, 3.20398, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542309
(8470009, 59819, 962, 262, 0, 0, 0, 0, 1063.11, 2291.64, 296.189, 0.0347894, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542310
(8470010, 66904, 962, 262, 0, 0, 0, 0, 864.898, 2229.12, 311.431, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542323
(8470011, 59819, 962, 262, 0, 0, 0, 0, 863.842, 2240.41, 296.189, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA guid 542324
(8470012, 59819, 962, 262, 0, 0, 0, 0, 985.267, 2237.91, 296.189, 4.70416, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA guid 542327

DELETE FROM `gameobject` WHERE `guid` BETWEEN 1040000 AND 1040099;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`,
    `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(1040000, 215757, 962, 262, 0, 0, 718.863, 2333.91, 388.011, 1.76883, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534882
(1040001, 215757, 962, 262, 0, 0, 720.017, 2332.26, 388.042, 1.76883, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534883
(1040002, 215757, 962, 262, 0, 0, 721.759, 2332.5, 387.986, 1.76883, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534884
(1040003, 215757, 962, 262, 0, 0, 723.445, 2332.48, 387.966, 1.76883, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534885
(1040004, 214629, 962, 262, 0, 0, 721.934, 2331.21, 387.945, 1.5708, 0, 0, 0, 1, 7200, 255, 0), -- LoA guid 534886
(1040005, 215757, 962, 262, 0, 0, 750.76, 2307.21, 387.969, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534887
(1040006, 215757, 962, 262, 0, 0, 752.167, 2306.08, 387.991, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534888
(1040007, 215757, 962, 262, 0, 0, 748.92, 2306.41, 387.951, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534889
(1040008, 215757, 962, 262, 0, 0, 750.625, 2305.57, 390.253, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534890
(1040009, 215757, 962, 262, 0, 0, 693.096, 2307.35, 387.966, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534891
(1040010, 215757, 962, 262, 0, 0, 751.616, 2305.02, 389.1, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534892
(1040011, 215757, 962, 262, 0, 0, 749.764, 2305.65, 389.1, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534893
(1040012, 215757, 962, 262, 0, 0, 691.255, 2306.54, 388.029, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534894
(1040013, 215757, 962, 262, 0, 0, 750.597, 2305.36, 387.974, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534895
(1040014, 215757, 962, 262, 0, 0, 751.991, 2304.02, 387.994, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534896
(1040015, 215757, 962, 262, 0, 0, 720.715, 2334.12, 388, 1.76883, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534897
(1040016, 215757, 962, 262, 0, 0, 722.693, 2334.32, 387.973, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534898
(1040017, 213507, 962, 262, 0, 0, 1377.18, 2280.18, 451.725, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534901
(1040018, 215757, 962, 262, 0, 0, 720.99, 2334, 389.889, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534903
(1040019, 215757, 962, 262, 0, 0, 722.432, 2334.27, 390.085, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534904
(1040020, 215757, 962, 262, 0, 0, 723.328, 2333.81, 389.077, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534905
(1040021, 215757, 962, 262, 0, 0, 722.481, 2335.15, 389.077, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534906
(1040022, 215757, 962, 262, 0, 0, 721.997, 2333.91, 389.077, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534907
(1040023, 215757, 962, 262, 0, 0, 720.844, 2335.18, 389.077, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534908
(1040024, 215757, 962, 262, 0, 0, 720.594, 2333.24, 389.077, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534909
(1040025, 215757, 962, 262, 0, 0, 719.701, 2335.51, 388.044, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534910
(1040026, 215757, 962, 262, 0, 0, 721.753, 2335.75, 387.98, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534911
(1040027, 215757, 962, 262, 0, 0, 723.622, 2335.97, 387.955, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534912
(1040028, 215757, 962, 262, 0, 0, 724.436, 2334.23, 387.949, 1.14206, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534913
(1040029, 215757, 962, 262, 0, 0, 692.099, 2305.79, 389.077, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534914
(1040030, 215757, 962, 262, 0, 0, 750.411, 2304.05, 390.253, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534915
(1040031, 215757, 962, 262, 0, 0, 694.326, 2304.16, 387.975, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534916
(1040032, 215757, 962, 262, 0, 0, 692.745, 2303.52, 387.978, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534917
(1040033, 215757, 962, 262, 0, 0, 693.599, 2303.56, 389.324, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534918
(1040034, 215757, 962, 262, 0, 0, 692.125, 2303, 389.422, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534919
(1040035, 215757, 962, 262, 0, 0, 692.32, 2301.83, 387.974, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534920
(1040036, 215757, 962, 262, 0, 0, 694.182, 2302.28, 387.957, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534921
(1040037, 215757, 962, 262, 0, 0, 749.984, 2301.69, 387.96, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534922
(1040038, 214629, 962, 262, 0, 0, 721.608, 2278.02, 387.944, 1.5708, 0, 0, 0, 1, 7200, 255, 0), -- LoA guid 534923
(1040039, 212985, 962, 262, 0, 0, 1232.73, 2304.54, 388.163, 0, 0, 0, -0.707107, 0.707107, 7200, 255, 0), -- LoA guid 534925
(1040040, 212986, 962, 262, 0, 0, 1077.57, 2216.28, 314.474, 3.14159, 0, 0, -0.707107, 0.707107, 7200, 255, 0), -- LoA guid 534926
(1040041, 214888, 962, 262, 0, 0, 916.969, 2366.78, 392.188, 0.00000572205, 0, 0, -0.707107, 0.707107, 7200, 255, 0), -- LoA guid 534927
(1040042, 214261, 962, 262, 0, 0, 958.999, 2223.25, 295.098, 1.5708, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534928
(1040043, 212983, 962, 262, 0, 0, 759.203, 2304.53, 388.163, 0, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534929
(1040044, 212982, 962, 262, 0, 0, 721.774, 2267.16, 388.163, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534930
(1040045, 214629, 962, 262, 0, 0, 695.359, 2304.51, 388.028, 0, 0, 0, 0, 1, 7200, 255, 0), -- LoA guid 534931
(1040046, 215757, 962, 262, 0, 0, 690.793, 2303.14, 388.031, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534932
(1040047, 215757, 962, 262, 0, 0, 694.502, 2306.22, 387.954, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534933
(1040048, 215757, 962, 262, 0, 0, 750.137, 2304.14, 389.1, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534934
(1040049, 215757, 962, 262, 0, 0, 748.807, 2304.65, 387.949, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534935
(1040050, 215757, 962, 262, 0, 0, 692.932, 2305.5, 387.976, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534936
(1040051, 215757, 962, 262, 0, 0, 692.762, 2305.25, 390.172, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534937
(1040052, 214629, 962, 262, 0, 0, 748.418, 2304.54, 387.944, 0, 0, 0, 0, 1, 7200, 255, 0), -- LoA guid 534938
(1040053, 215757, 962, 262, 0, 0, 751.264, 2303.42, 389.1, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534939
(1040054, 215757, 962, 262, 0, 0, 691.142, 2304.79, 388.001, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534940
(1040055, 215757, 962, 262, 0, 0, 750.41, 2303.38, 387.972, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534941
(1040056, 215757, 962, 262, 0, 0, 748.458, 2303, 387.945, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534942
(1040057, 215757, 962, 262, 0, 0, 692.747, 2303.78, 390.198, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534943
(1040058, 215757, 962, 262, 0, 0, 751.847, 2302.14, 387.998, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534944
(1040059, 215757, 962, 262, 0, 0, 749.79, 2302.86, 389.1, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534945
(1040060, 215757, 962, 262, 0, 0, 692.472, 2304.28, 389.373, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534946
(1040061, 215757, 962, 262, 0, 0, 693.951, 2305.16, 389.123, 5.65642, 0, 0, 0, 1, 7200, 255, 1), -- LoA guid 534947
(1040062, 211245, 962, 262, 0, 0, 958.618, 2364.44, 296.537, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534987
(1040063, 211246, 962, 262, 0, 0, 959.401, 2364.44, 296.537, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534988
(1040064, 213200, 962, 262, 0, 0, 963.976, 2300.16, 299.306, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534992
(1040065, 213198, 962, 262, 0, 0, 963.976, 2300.16, 299.306, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1), -- LoA guid 534993
(1040066, 213199, 962, 262, 0, 0, 963.976, 2300.16, 299.306, 4.71239, 0, 0, -0.707107, 0.707107, 7200, 255, 1); -- LoA guid 534994
