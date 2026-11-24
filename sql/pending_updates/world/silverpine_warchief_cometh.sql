-- Silverpine Forest: quest 26965 "The Warchief Cometh" (Forsaken High Command scene).
-- Ported from TrinityCore cata_classic (scripts) and TDB 4.4.2 (texts, spawn, paths, conditions, spell_area).

-- Script bindings
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_silverpine_grand_executor_mortuus' WHERE `entry` = 44615;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_silverpine_fallen_human' WHERE `entry` IN (44592, 44593);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (83173, 83149);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(83173, 'spell_silverpine_raise_forsaken_83173'),
(83149, 'spell_silverpine_forsaken_trooper_masterscript_high_command');

-- Raise Forsaken (83173) hits only the Fallen Humans
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 83173;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 83173, 0, 0, 31, 0, 3, 44592, 0, 0, 0, 0, '', 'Raise Forsaken - Target Fallen Human (Male)'),
(13, 1, 83173, 0, 1, 31, 0, 3, 44593, 0, 0, 0, 0, '', 'Raise Forsaken - Target Fallen Human (Female)');

-- Scene texts (Sylvanas, Garrosh, Cromush)
DELETE FROM `creature_text` WHERE `entry` IN (44365, 44629, 44640);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(44365, 0, 0, 'Where is that ogre-headed buffoon?', 12, 0, 100, 6, 0, 20459, 'VO_QE_SP_Sylvanas_SPEvent01'),
(44365, 1, 0, 'Ah, speak of the devil...', 12, 0, 100, 1, 0, 20460, 'VO_QE_SP_Sylvanas_SPEvent02'),
(44365, 2, 0, 'Warchief, so glad you could make it.', 12, 0, 100, 1, 0, 20461, 'VO_QE_SP_Sylvanas_SPEvent03'),
(44365, 3, 0, 'With the death of the Lich King, many of the more intelligent Scourge became... unemployed. Those ''fiends,'' as you so delicately put it, are called val''kyr. They are under my command now...', 12, 0, 100, 0, 0, 20462, 'VO_QE_SP_Sylvanas_SPEvent04'),
(44365, 4, 0, '...and they are part of the reason that I asked to see you.', 12, 0, 100, 1, 0, 20463, 'VO_QE_SP_Sylvanas_SPEvent05'),
(44365, 5, 0, 'Very well, Warchief. I have solved the plight of the Forsaken!', 12, 0, 100, 5, 0, 20464, 'VO_QE_SP_Sylvanas_SPEvent06'),
(44365, 6, 0, 'As a race, we Forsaken are unable to procreate.', 12, 0, 100, 274, 0, 20465, 'VO_QE_SP_Sylvanas_SPEvent07'),
(44365, 7, 0, 'With the aid of the val''kyr, we are now able to take the corpses of the fallen and create new Forsaken.', 12, 0, 100, 0, 0, 20466, 'VO_QE_SP_Sylvanas_SPEvent08'),
(44365, 8, 0, 'Agatha, show the Warchief!', 12, 0, 100, 5, 0, 20467, 'VO_QE_SP_Sylvanas_SPEvent09'),
(44365, 9, 0, 'Warchief, without these new Forsaken my people would die out... Our hold upon Gilneas and northern Lordaeron would crumble.', 12, 0, 100, 0, 0, 20468, 'VO_QE_SP_Sylvanas_SPEvent10'),
(44365, 10, 0, 'Isn''t it obvious, Warchief? I serve the Horde.', 12, 0, 100, 66, 0, 20469, 'VO_QE_SP_Sylvanas_SPEvent11'),
(44629, 0, 0, 'This better be important, Sylvanas. You know how I detest this place and its foul stench. Why have you called for me?', 12, 0, 100, 0, 0, 20496, 'VO_QE_Garrosh_SPEvent01'),
(44629, 1, 0, 'And more importantly, what are those Scourge fiends doing here?', 12, 0, 100, 25, 0, 20497, 'VO_QE_Garrosh_SPEvent02'),
(44629, 2, 0, 'Get on with it, Sylvanas.', 12, 0, 100, 1, 0, 20498, 'VO_QE_Garrosh_SPEvent03'),
(44629, 3, 0, 'What you have done here, Sylvanas... it goes against the laws of nature. Disgusting is the only word I have to describe it.', 12, 0, 100, 0, 0, 20499, 'VO_QE_Garrosh_SPEvent04'),
(44629, 4, 0, 'Have you given any thought to what this means, Sylvanas?', 12, 0, 100, 6, 0, 20500, 'VO_QE_Garrosh_SPEvent05'),
(44629, 5, 0, 'What difference is there between you and the Lich King now?', 12, 0, 100, 6, 0, 20501, 'VO_QE_Garrosh_SPEvent06'),
(44629, 6, 0, 'Watch your clever mouth.', 12, 0, 100, 397, 0, 20502, 'VO_QE_Garrosh_SPEvent07'),
(44629, 7, 0, 'Cromush, you stay behind and make sure the Banshee Queen is well "guarded." I will be expecting a full report when next we meet.', 12, 0, 100, 0, 0, 20503, 'VO_QE_Garrosh_SPEvent08'),
(44629, 8, 0, 'Remember, Sylvanas, eventually we all have to stand before our maker and face judgment. Your day may come sooner than others...', 12, 0, 100, 0, 0, 20504, 'VO_QE_Garrosh_SPEvent09'),
(44640, 0, 0, 'ABBERATION!', 12, 0, 100, 5, 0, 0, 'VO_QE_SP_Crommush_SPEvent01'),
(44640, 1, 0, 'As you command, Warchief.', 12, 0, 100, 66, 0, 0, 'VO_QE_SP_Crommush_SPEvent01');

-- Lady Sylvanas Windrunner had no spawn at Forsaken High Command (she starts 27098 "Lordaeron"). Spot from TDB 4.4.2; guid block 9694000.
DELETE FROM `creature` WHERE `guid` = 9694000;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9694000, 44365, 0, 1, 0, 0, 0, 1, 1381.35, 1040.73, 54.4004, 3.90954, 120, 0, 0, 1, 0, 0, 0, 0, 0);

-- Agatha: TDB 4.4.2 spot (the scene ends with her back here)
UPDATE `creature` SET `position_z` = 58.132, `orientation` = 0.715585 WHERE `guid` = 196773 AND `id` = 44608;

-- Fallen Humans come back lying down right after they despawn as Forsaken Troopers (TDB: 1 s)
UPDATE `creature` SET `spawntimesecs` = 1 WHERE `id` IN (44592, 44593) AND `map` = 0;

-- See Quest Invis 9 (83989) lets players see Agatha (Quest Invis 9 aura 83988) from 26964 until they take 27097, and during 27099 (TDB 4.4.2)
DELETE FROM `spell_area` WHERE `spell` = 83989 AND `area` = 5369;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(83989, 5369, 26964, 27097, 0, 0, 2, 1, 66, 1),
(83989, 5369, 26965, 27097, 0, 0, 2, 1, 64, 1),
(83989, 5369, 27099, 27098, 0, 0, 2, 1, 64, 1),
(83989, 5369, 28568, 27097, 0, 0, 2, 1, 66, 1);

-- High Warlord Cromush: PR #152 imported two copies at the hub whose paths are the scene's summoned walk-ins (9562103 = the
-- run in from the portal) and gave 9562102 Quest Invis 7 (83231) that no player can detect. Keep one, visible, on TDB's patrol.
DELETE FROM `creature` WHERE `guid` = 9562103;
DELETE FROM `creature_addon` WHERE `guid` = 9562103;
DELETE FROM `waypoint_data` WHERE `id` = 95621030;
UPDATE `creature` SET `position_x` = 1354.04, `position_y` = 1035.1, `position_z` = 52.8133, `orientation` = 0.20582, `MovementType` = 2, `currentwaypoint` = 0 WHERE `guid` = 9562102;
UPDATE `creature_addon` SET `auras` = NULL WHERE `guid` = 9562102;
DELETE FROM `waypoint_data` WHERE `id` = 95621020;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(95621020, 1, 1354.04, 1035.1, 52.8133, 0, 0, 0, 0, 100, 0),
(95621020, 2, 1359.16, 1022.61, 52.7326, 0, 0, 0, 0, 100, 0),
(95621020, 3, 1366.16, 1019.36, 52.9826, 0, 0, 0, 0, 100, 0),
(95621020, 4, 1372.14, 1016.71, 53.0572, 0, 0, 0, 0, 100, 0),
(95621020, 5, 1376.14, 1017.46, 53.3072, 0, 0, 0, 0, 100, 0),
(95621020, 6, 1385.07, 1019.4, 53.5022, 0, 0, 0, 0, 100, 0),
(95621020, 7, 1389.99, 1033.21, 53.6892, 0, 0, 0, 0, 100, 0),
(95621020, 8, 1388.99, 1035.96, 53.6892, 0, 0, 0, 0, 100, 0),
(95621020, 9, 1388.24, 1037.71, 53.9392, 0, 0, 0, 0, 100, 0),
(95621020, 10, 1387.49, 1039.46, 54.1892, 0, 0, 0, 0, 100, 0),
(95621020, 11, 1386.37, 1042.53, 54.2889, 0, 0, 0, 0, 100, 0),
(95621020, 12, 1384.62, 1043.53, 54.5389, 0, 0, 0, 0, 100, 0),
(95621020, 13, 1382.37, 1045.03, 54.2889, 0, 0, 0, 0, 100, 0),
(95621020, 14, 1380.87, 1046.28, 54.0389, 0, 0, 0, 0, 100, 0),
(95621020, 15, 1378.95, 1047.57, 53.8231, 0, 0, 0, 0, 100, 0),
(95621020, 16, 1377.7, 1048.32, 53.8231, 0, 0, 0, 0, 100, 0),
(95621020, 17, 1368.27, 1049.88, 53.3609, 0, 0, 0, 0, 100, 0),
(95621020, 18, 1360.77, 1049.13, 53.1109, 0, 0, 0, 0, 100, 0),
(95621020, 19, 1356.53, 1048.56, 53.0318, 0, 0, 0, 0, 100, 0),
(95621020, 20, 1355.28, 1042.56, 52.7818, 0, 0, 0, 0, 100, 0);

-- Scene paths: Garrosh walks off (TDB 3570320), Cromush runs in from the portal (TDB 3571216)
DELETE FROM `waypoint_data` WHERE `id` = 96940000;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(96940000, 1, 1377.69, 1048.67, 53.4456, 0, 0, 0, 0, 100, 0),
(96940000, 2, 1373.69, 1052.17, 53.4456, 0, 0, 0, 0, 100, 0),
(96940000, 3, 1365.23, 1058.61, 53.0524, 0, 0, 0, 0, 100, 0);
DELETE FROM `waypoint_data` WHERE `id` = 96940010;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(96940010, 1, 1412.05, 1089.42, 60.4771, 0, 0, 1, 0, 100, 0),
(96940010, 2, 1405.38, 1095.16, 60.4774, 0, 0, 1, 0, 100, 0),
(96940010, 3, 1392.62, 1093.5, 56.4067, 0, 0, 1, 0, 100, 0),
(96940010, 4, 1380.65, 1083.27, 52.6221, 0, 0, 1, 0, 100, 0),
(96940010, 5, 1372.86, 1062, 53.0398, 0, 0, 1, 0, 100, 0),
(96940010, 6, 1376.69, 1048.61, 53.3362, 0, 0, 1, 0, 100, 0),
(96940010, 7, 1375.32, 1046.38, 53.2336, 0, 0, 1, 0, 100, 0);
