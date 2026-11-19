-- Section 1 (P11): the six 5.0 scenarios ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2):
-- A Brewing Storm 1005, Greenstone Village 1024, Unga Ingoo 1048, Crypt of Forgotten Kings 1030,
-- Arena of Annihilation 1031, Brewmoon Festival 1051. Spawn GUID blocks 9581000-9592999. Safe to run twice.

-- Templates the scenario scripts need that SkyFire's DB lacks, copied from the Legends of Azeroth Pandaria
-- 5.4.8 world DB (GPL v2, 2024-07-22) by skyfire_port_plan/tools/TemplateImport.ps1. Safe to run twice.

-- creature_template (5)
DELETE FROM `creature_template` WHERE `entry` IN (70332,71124,71353,71489,71490);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Mana_mod_extra`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `faction_A`, `faction_H`, `npc_rank`) VALUES
(70332, 0, 0, 0, 0, 0, 20570, 11686, 0, 0, 'Arrow Tile Trap Bunny', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1074791424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, '', 14, 14, 0),
(71124, 0, 0, 0, 0, 0, 48618, 0, 0, 0, 'Blanche\'s Still', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 14, 14, 0),
(71353, 0, 0, 0, 0, 0, 42538, 0, 0, 0, 'Viletongue Decimator', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 34737, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_viletongue_decimator', 16, 16, 1),
(71489, 0, 0, 0, 0, 0, 48937, 11686, 0, 0, 'Fire Trap', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 33685504, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_cfk_fire_trap', 634, 634, 0),
(71490, 0, 0, 0, 0, 0, 48938, 11686, 0, 0, 'Fire Trap', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 131072, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1611661328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 634, 634, 0);

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` IN (71124,71353,71489,71490);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(71124, 0, 0, 0, 1, 0, ''),
(71353, 0, 0, 0, 1, 0, ''),
(71489, 0, 0, 0, 1, 0, ''),
(71490, 0, 0, 0, 1, 0, '');

-- creature_equip_template
DELETE FROM `creature_equip_template` WHERE `entry` IN (71353);
INSERT INTO `creature_equip_template` (`entry`, `id`, `itemEntry1`, `itemEntry2`, `itemEntry3`) VALUES
(71353, 1, 76495, 0, 0);

-- creature_model_info (models of the new templates)
DELETE FROM `creature_model_info` WHERE `modelid` IN (48618,48937,48938);
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(48618, 0.5, 7.5, 2, 0),
(48937, 0, 0, 2, 0),
(48938, 0, 0, 2, 0);

-- gameobject_template (2)
DELETE FROM `gameobject_template` WHERE `entry` IN (212273,215901);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `data24`, `data25`, `data26`, `data27`, `data28`, `data29`, `data30`, `data31`, `unkInt32`, `AIName`, `ScriptName`) VALUES
(212273, 10, 11364, 'Bigga Unga Keg', '', '', '', 1.5, 0, 0, 0, 0, 0, 0, 1690, 0, 0, 3000, 0, 1, 0, 0, 0, 0, 121942, 0, 0, 0, 19676, 0, 0, 0, 0, 0, 0, 0, 18821, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_brew_container'),
(215901, 10, 12706, 'Great Banquet of the Oven', '', '', '', 0.8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '');

-- A Brewing Storm (map 1005): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1005;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1005, 870, 'instance_brewing_storm', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_viletongue_sauroks' WHERE `entry` = 58737; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_viletongue_sauroks' WHERE `entry` = 58738; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_borokhula_the_destroyer' WHERE `entry` = 58739; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaster_blanche' WHERE `entry` = 58740; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewkeg' WHERE `entry` = 58916; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_viletongue_stalker' WHERE `entry` = 59635; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_viletongue_stalker' WHERE `entry` = 59650; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 111544 AND `ScriptName` = 'spell_brewing_storm_lightning_impact';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111544, 'spell_brewing_storm_lightning_impact');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111828 AND `ScriptName` = 'spell_brewing_storm_lightning_channel';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111828, 'spell_brewing_storm_lightning_channel');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115058 AND `ScriptName` = 'spell_boomer_brew_strike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115058, 'spell_boomer_brew_strike');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 58740;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58740, 0, 0, 'The storm is starting! Get ready.', 14, 0, 100, 5, 0, 0, 'Blacnhe - Intro'),
(58740, 1, 0, 'If the brewkegs catch fire, I need you to help put them out.', 14, 0, 100, 1, 0, 0, 'Blanche - About kegs'),
(58740, 2, 0, 'Watch out for lightning strikes!', 14, 0, 100, 5, 0, 0, 'Blanche - About lightning'),
(58740, 3, 0, '...Saurok? What are they doing here? Keep them away!', 14, 0, 100, 5, 0, 0, 'Blanche - About Sauroks'),
(58740, 4, 0, 'Yow, the storm is more intense than I thought! Be careful!', 14, 0, 100, 5, 0, 0, 'Blanche - On 50 pct progress bar'),
(58740, 5, 0, 'Stand in Blanche\'s Elixir of Replenishment to restore health and mana!', 41, 0, 100, 0, 0, 0, ''),
(58740, 6, 0, 'Stay on your toes!', 14, 0, 100, 0, 0, 0, 'Blanche - Hit lightning on player'),
(58740, 7, 0, 'You did it! Let\'s get this brew to the Monastery...', 14, 0, 100, 4, 0, 0, 'Blanche - First Chapter Done'),
(58740, 8, 0, 'Rest up for a second while I prep the keg.', 14, 0, 100, 1, 0, 0, 'Blanche - First Chapter Outro'),
(58740, 9, 0, 'Everyone ready? Let\'s roll!', 14, 0, 100, 1, 0, 0, 'Blanche - Second Chapter Begun'),
(58740, 10, 0, 'Ho boy, more saurok. They always seek high ground when the rains hit!', 14, 0, 100, 5, 0, 0, 'Blanche - At down of cliff'),
(58740, 11, 0, 'Don\'t you die on me!', 14, 0, 100, 0, 0, 0, 'Blanche - At low hp players'),
(58740, 12, 0, 'They\'re scaling the cliff walls! This is going to get dirty.', 14, 0, 100, 1, 0, 0, 'Blacnhe - At cliff'),
(58740, 13, 0, 'Watch your footing! The stones are still slick from rain.', 14, 0, 100, 1, 0, 0, 'Blanche - About wall cliff'),
(58740, 14, 0, 'Keep an eye on the rear! No - not MY rear. Behind us!', 14, 0, 100, 5, 0, 0, 'Blanche - Joke'),
(58740, 15, 0, 'Phew! I need a breather. Let\'s rest here a momen- wha?', 14, 0, 100, 1, 0, 0, 'Blanche - Breathing'),
(58740, 16, 0, 'No time to catch our breath. Quickly! We\'ve got to help them!', 14, 0, 100, 25, 0, 0, 'Blanche - Ready to go'),
(58740, 17, 0, 'Let me know when you\'re ready to go inside...', 14, 0, 100, 1, 0, 0, 'Blanche - Chapter Three Intro'),
(58740, 18, 0, 'Let\'s go be heroes!', 14, 0, 100, 4, 0, 0, 'Blanche - Chapter Three Begun'),
(58740, 19, 0, 'Use the Boomer Brew to zap saurok minions!', 41, 0, 100, 0, 0, 0, ''),
(58740, 20, 0, 'Last call, you fork-tongued dip-slithers!', 14, 0, 100, 15, 0, 0, 'Blanche - On Borokhala Intro'),
(58740, 21, 0, 'You don\'t have to go home, but you can\'t stay here.', 14, 0, 100, 25, 0, 0, 'Blanche - On 70% of Borokhala'),
(58740, 22, 0, 'You did it! Thunderpaw Refuge is saved!', 14, 0, 100, 4, 0, 0, 'Blanche - On Scenario End');

-- NOTE: instance_template map 1005 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 58737; -- Viletongue Raider
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 58738; -- Viletongue Skirmisher
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2299, `faction_H` = 2299, `unit_flags` = 131584, `unit_class` = 2, `VehicleId` = 2265 WHERE `entry` = 58740; -- Brewmaster Blanche
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 58869; -- Blanche\'s Lightning Rod
UPDATE `creature_template` SET `npcflag` = 16777216 WHERE `entry` = 58916; -- Brewkeg
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 190, `faction_H` = 190, `unit_flags` = 33555200, `unit_flags2` = 2099200, `VehicleId` = 2223, `InhabitType` = 4 WHERE `entry` = 59635; -- Viletongue Warrior Cliff-Scaling Vehicle
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 190, `faction_H` = 190, `unit_flags` = 33555200, `unit_flags2` = 2099200, `VehicleId` = 2075, `InhabitType` = 4 WHERE `entry` = 59650; -- Viletongue Skirmisher Cliff-Scaling Vehicle
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 190, `faction_H` = 190, `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 59734; -- Dave\'s Industrial Light and Magic Bunny (Large)(Sessile)(Large AOI)
UPDATE `creature_template` SET `unit_flags` = 0, `unit_flags2` = 0 WHERE `entry` = 59779; -- Thunderpaw Guardian
UPDATE `creature_template` SET `unit_flags` = 0, `unit_flags2` = 0 WHERE `entry` = 59781; -- Thunderpaw Initiate
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 131072 WHERE `entry` = 66962; -- Wind Slash

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 58740;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (58740, 0, 0, 0, 1, 0, '122353');
DELETE FROM `creature_template_addon` WHERE `entry` = 59635;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59635, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 59650;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59650, 0, 0, 50331648, 1, 0, '');

-- conditions

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 58916;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(58916, 111961, 1, 0);

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Blanche\'s Lightning Rod', `data1` = 1, `faction` = 14 WHERE `entry` = 210512;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Blanche\'s Lightning Lager', `faction` = 35 WHERE `entry` = 211271;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Blanche\'s Lightning Lager Keg Stand', `faction` = 35 WHERE `entry` = 211272;

-- INFO gameobject entries LoA spawns on map 1005 and SkyFire does not: 210512 211271 211272

-- A Brewing Storm (1005): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9581000-9581094, gameobject 9581000-9581006. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9581000 AND 9581094;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9581000, 59650, 1005, 6144, 0, 0, 0, 0, 2211.53, -1173.8, 442.589, 1.96034, 7200, 0, 0, 1, 1, 0, 0, 0, 0), -- LoA 543405
(9581001, 35845, 1005, 6144, 0, 0, 0, 0, 2221.03, -1016.9, 466.051, 3.08525, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543409
(9581002, 59635, 1005, 6144, 0, 0, 0, 0, 2292.72, -1170.01, 421.807, 2.96166, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543410
(9581003, 59635, 1005, 6144, 0, 0, 0, 0, 2271.12, -1198.07, 414.883, 2.40402, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543411
(9581004, 59635, 1005, 6144, 0, 0, 0, 0, 2227.22, -1136.8, 481.466, 0.0275402, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543418
(9581005, 59635, 1005, 6144, 0, 0, 0, 0, 2296.84, -1127.65, 439.442, 3.14859, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543420
(9581006, 59635, 1005, 6144, 0, 0, 0, 0, 2206.72, -1169.8, 442.366, 6.20118, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543427
(9581007, 59635, 1005, 6144, 0, 0, 0, 0, 2275.81, -1131.57, 479.751, 3.14796, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543428
(9581008, 59650, 1005, 6144, 0, 0, 0, 0, 2242.02, -1113.07, 481.794, 5.22766, 7200, 0, 0, 1, 1, 0, 0, 0, 0), -- LoA 543430
(9581009, 59635, 1005, 6144, 0, 0, 0, 0, 2264.7, -1162.13, 479.938, 2.07589, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543431
(9581010, 58916, 1005, 6144, 0, 0, 0, 0, 2243.69, -1143.43, 486.021, 0.864595, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543436
(9581011, 58916, 1005, 6144, 0, 0, 0, 0, 2257.95, -1130.02, 486, 3.62878, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543437
(9581012, 58916, 1005, 6144, 0, 0, 0, 0, 2256.28, -1142.91, 486.021, 2.16701, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543438
(9581013, 58737, 1005, 6144, 0, 0, 0, 0, 2233.33, -1229.08, 420.527, 0.776583, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543440
(9581014, 71353, 1005, 6144, 0, 0, 0, 0, 2284.97, -1160.58, 429.186, 4.27576, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543443
(9581015, 59635, 1005, 6144, 0, 0, 0, 0, 2275.58, -1208.04, 365.403, 2.66331, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543444
(9581016, 59650, 1005, 6144, 0, 0, 0, 0, 2288.85, -1190.08, 365.572, 3.5689, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543445
(9581017, 59635, 1005, 6144, 0, 0, 0, 0, 2298.46, -1181.93, 374.565, 2.65477, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543446
(9581018, 59650, 1005, 6144, 0, 0, 0, 0, 2281.57, -1202.37, 364.614, 2.90644, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543447
(9581019, 58916, 1005, 6144, 0, 0, 0, 0, 2239.77, -1133.08, 486.095, 6.07006, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543448
(9581020, 58916, 1005, 6144, 0, 0, 0, 0, 2248.25, -1124.55, 485.484, 4.86274, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543449
(9581021, 59650, 1005, 6144, 0, 0, 0, 0, 2282.57, -1200.41, 364.734, 2.90644, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543450
(9581022, 59635, 1005, 6144, 0, 0, 0, 0, 2262.89, -1222.52, 378.645, 2.51537, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543451
(9581023, 59650, 1005, 6144, 0, 0, 0, 0, 2301.97, -1150.31, 404.759, 2.90644, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543452
(9581024, 59635, 1005, 6144, 0, 0, 0, 0, 2300.41, -1178.72, 374.091, 2.24385, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543453
(9581025, 71353, 1005, 6144, 0, 0, 0, 0, 2270.7, -1092.22, 432.334, 5.43452, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543455
(9581026, 59650, 1005, 6144, 0, 0, 0, 0, 2305.12, -1126.89, 391.196, 3.77237, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543456
(9581027, 59635, 1005, 6144, 0, 0, 0, 0, 2305.09, -1123.2, 394.483, 3.25432, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543457
(9581028, 59635, 1005, 6144, 0, 0, 0, 0, 2219.51, -1066.73, 426.766, 1.28887, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543458
(9581029, 58737, 1005, 6144, 0, 0, 0, 0, 2230.3, -1052.4, 451.04, 1.60702, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543460
(9581030, 59635, 1005, 6144, 0, 0, 0, 0, 2207.35, -1067.95, 427.788, 1.58619, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543462
(9581031, 59734, 1005, 6144, 0, 0, 0, 0, 2241.81, -1041.26, 450.892, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543463
(9581032, 58737, 1005, 6144, 0, 0, 0, 0, 2183.82, -973.84, 457.339, 5.83912, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543464
(9581033, 58738, 1005, 6144, 0, 0, 0, 0, 2245.24, -1045.96, 451.279, 2.76076, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543465
(9581034, 59734, 1005, 6144, 0, 0, 0, 0, 2246.33, -1014.84, 484.743, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543466
(9581035, 59650, 1005, 6144, 0, 0, 0, 0, 2203.86, -1066.39, 431.37, 0.527088, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543467
(9581036, 58737, 1005, 6144, 0, 0, 0, 0, 2179.52, -1040.41, 456.995, 0.333793, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543468
(9581037, 59734, 1005, 6144, 0, 0, 0, 0, 2245.58, -1007.1, 488.313, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543470
(9581038, 59635, 1005, 6144, 0, 0, 0, 0, 2239.64, -1068.15, 419.454, 1.58619, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543471
(9581039, 59734, 1005, 6144, 0, 0, 0, 0, 2208.92, -1053.62, 450.854, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543474
(9581040, 59650, 1005, 6144, 0, 0, 0, 0, 2253.56, -1060.33, 421.628, 2.15923, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543475
(9581041, 58737, 1005, 6144, 0, 0, 0, 0, 2203.19, -956.723, 457.155, 4.92662, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543477
(9581042, 58739, 1005, 6144, 0, 0, 0, 0, 2232.47, -1017.27, 483.22, 3.1074, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543478
(9581043, 59734, 1005, 6144, 0, 0, 0, 0, 2251.36, -1009.1, 482.374, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543479
(9581044, 59650, 1005, 6144, 0, 0, 0, 0, 2226.36, -1068.14, 419.453, 1.58619, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543480
(9581045, 59734, 1005, 6144, 0, 0, 0, 0, 2253.9, -1010.52, 469.167, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543481
(9581046, 59734, 1005, 6144, 0, 0, 0, 0, 2224.63, -1052.01, 454.916, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543482
(9581047, 59650, 1005, 6144, 0, 0, 0, 0, 2260.05, -1050.47, 426.478, 2.3449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543483
(9581048, 59734, 1005, 6144, 0, 0, 0, 0, 2254.7, -1036.39, 453.081, 3.73525, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543484
(9581049, 58737, 1005, 6144, 0, 0, 0, 0, 2234.73, -978.446, 452.4, 3.73376, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543485
(9581050, 59781, 1005, 6144, 0, 0, 0, 0, 2202.09, -1049.56, 450.854, 2.07017, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543486
(9581051, 59734, 1005, 6144, 0, 0, 0, 0, 2245.9, -1023.63, 485.229, 5.12449, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543490
(9581052, 59781, 1005, 6144, 0, 0, 0, 0, 2214.74, -969.472, 450.854, 5.41707, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543491
(9581053, 58737, 1005, 6144, 0, 0, 0, 0, 2201.9, -957.914, 458.046, 5.38643, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543493
(9581054, 58738, 1005, 6144, 0, 0, 0, 0, 2204.79, -1059.15, 458.349, 1.7413, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543494
(9581055, 58738, 1005, 6144, 0, 0, 0, 0, 2184.16, -976.212, 458.69, 5.84441, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543495
(9581056, 58738, 1005, 6144, 0, 0, 0, 0, 2258.68, -1050.93, 438.724, 3.18391, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543496
(9581057, 58737, 1005, 6144, 0, 0, 0, 0, 2243.26, -977.097, 466.277, 3.97824, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543497
(9581058, 58738, 1005, 6144, 0, 0, 0, 0, 2208.94, -1058.55, 458.517, 1.58902, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543498
(9581059, 58737, 1005, 6144, 0, 0, 0, 0, 2181.79, -973.844, 450.787, 5.60321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543499
(9581060, 38821, 1005, 6144, 0, 0, 0, 0, 2255.31, -1125.12, 521.142, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543500
(9581061, 38821, 1005, 6144, 0, 0, 0, 0, 2241.94, -1127.32, 522.386, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543502
(9581062, 71124, 1005, 6144, 0, 0, 0, 0, 2250.81, -1135.94, 486.021, 2.27484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543503
(9581063, 38821, 1005, 6144, 0, 0, 0, 0, 2250.02, -1145.58, 522.313, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543506
(9581064, 38821, 1005, 6144, 0, 0, 0, 0, 2239.57, -1139.48, 522.773, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543507
(9581065, 38821, 1005, 6144, 0, 0, 0, 0, 2259.54, -1137.1, 522.931, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543508
(9581066, 58740, 1005, 6144, 0, 0, 0, 0, 2249.06, -1138.73, 485.937, 1.59257, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543509
(9581067, 59635, 1005, 6144, 0, 0, 0, 0, 2219.48, -1066.85, 425.892, 1.36901, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543511
(9581068, 58737, 1005, 6144, 0, 0, 0, 0, 2178.44, -1040.78, 451.496, 0.333793, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543512
(9581069, 59650, 1005, 6144, 0, 0, 0, 0, 2203.7, -1066.54, 430.219, 1.02792, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543513
(9581070, 59650, 1005, 6144, 0, 0, 0, 0, 2253.67, -1060.49, 420.746, 2.20187, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543514
(9581071, 58738, 1005, 6144, 0, 0, 0, 0, 2230.36, -1054.27, 451.171, 1.60702, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543515
(9581072, 58737, 1005, 6144, 0, 0, 0, 0, 2182.45, -973.188, 452.065, 5.83912, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543516
(9581073, 58737, 1005, 6144, 0, 0, 0, 0, 2202.92, -955.496, 451.834, 4.92662, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543517
(9581074, 58738, 1005, 6144, 0, 0, 0, 0, 2246.95, -1046.65, 451.347, 2.76076, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543518
(9581075, 59781, 1005, 6144, 0, 0, 0, 0, 2221.11, -1043.92, 450.871, 0.0924258, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543519
(9581076, 59781, 1005, 6144, 0, 0, 0, 0, 2209.32, -1041.14, 450.871, 2.05099, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543520
(9581077, 59781, 1005, 6144, 0, 0, 0, 0, 2196.64, -977.957, 450.798, 4.60721, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543526
(9581078, 58737, 1005, 6144, 0, 0, 0, 0, 2183.62, -975.959, 457.557, 5.84441, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543528
(9581079, 58738, 1005, 6144, 0, 0, 0, 0, 2201.58, -957.507, 456.414, 5.38643, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543529
(9581080, 58737, 1005, 6144, 0, 0, 0, 0, 2259.61, -1050.89, 435.549, 3.18391, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543530
(9581081, 58737, 1005, 6144, 0, 0, 0, 0, 2204.89, -1059.76, 457.185, 1.7413, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543531
(9581082, 58737, 1005, 6144, 0, 0, 0, 0, 2183.4, -975.143, 457.692, 5.60321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543532
(9581083, 58737, 1005, 6144, 0, 0, 0, 0, 2243.77, -976.524, 466.603, 3.97824, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543533
(9581084, 58738, 1005, 6144, 0, 0, 0, 0, 2208.95, -1059, 457.596, 1.58902, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543534
(9581085, 70097, 1005, 6144, 0, 0, 0, 0, 2244.29, -1125.34, 485.249, 4.75615, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 544660
(9581086, 58869, 1005, 6144, 0, 0, 0, 0, 2254.94, -1125.44, 490.34, 3.9961, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 544758
(9581087, 58869, 1005, 6144, 0, 0, 0, 0, 2239.63, -1139.54, 490.34, 0.54538, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 544761
(9581088, 58869, 1005, 6144, 0, 0, 0, 0, 2259.49, -1137.12, 490.34, 2.878, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 544765
(9581089, 70097, 1005, 6144, 0, 0, 0, 0, 2259.98, -1137.55, 486.001, 2.80498, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 545188
(9581090, 70097, 1005, 6144, 0, 0, 0, 0, 2250.73, -1146.79, 485.939, 1.56719, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 545470
(9581091, 70097, 1005, 6144, 0, 0, 0, 0, 2252.92, -1125.07, 485.812, 4.55643, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 545472
(9581092, 58869, 1005, 6144, 0, 0, 0, 0, 2249.95, -1145.52, 490.34, 1.41874, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 545473
(9581093, 58869, 1005, 6144, 0, 0, 0, 0, 2242.47, -1127.57, 490.34, 4.7862, 300, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 545763
(9581094, 70097, 1005, 6144, 0, 0, 0, 0, 2240.83, -1136.8, 485.923, 0.00449159, 300, 0, 0, 393941, 0, 0, 0, 0, 0); -- LoA 545818

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9581000 AND 9581006;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9581000, 210512, 1005, 6144, 0, 0, 2255.08, -1125.38, 485.918, 4.18296, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535510
(9581001, 210512, 1005, 6144, 0, 0, 2250.06, -1145.31, 485.938, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535511
(9581002, 210512, 1005, 6144, 0, 0, 2259.64, -1137.23, 485.978, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535512
(9581003, 210512, 1005, 6144, 0, 0, 2239.69, -1139.31, 485.928, 0.284858, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535513
(9581004, 210512, 1005, 6144, 0, 0, 2242.45, -1127.47, 485.431, 5.57665, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535514
(9581005, 211272, 1005, 6144, 0, 0, 2188.34, -1011.32, 450.771, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535515
(9581006, 211271, 1005, 6144, 0, 0, 2188.21, -1011.25, 450.771, 3.10903, 0, 0, 0, 1, 7200, 255, 1); -- LoA 535516

-- Greenstone Village (map 1024): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1024;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1024, 870, 'instance_greenstone_village', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_wily_woodling' WHERE `entry` = 61155; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_vengeful_hui' WHERE `entry` = 61156; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_pillager_base' WHERE `entry` = 61157; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_terror' WHERE `entry` = 61159; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_cursed_brew' WHERE `entry` = 61174; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_brewmaster_tzu' WHERE `entry` = 61203; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61342; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61343; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61346; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61350; -- was 'npc_innkeeper'
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61461; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 61462; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_monstrosity' WHERE `entry` = 62619; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_cursed_brew' WHERE `entry` = 62637; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_burgled_barrel' WHERE `entry` = 62682; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 62706; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_masson' WHERE `entry` = 62988; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_masson' WHERE `entry` = 62989; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_masson' WHERE `entry` = 62990; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_owner' WHERE `entry` = 65271; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_greenstone_village_monstrosity' WHERE `entry` = 66772; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 115662 AND `ScriptName` = 'spell_terror_shards_triggered_effect';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115662, 'spell_terror_shards_triggered_effect');
DELETE FROM `spell_script_names` WHERE `spell_id` = 119090 AND `ScriptName` = 'spell_greenstone_volatile_greenstone_brew';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (119090, 'spell_greenstone_volatile_greenstone_brew');
DELETE FROM `spell_script_names` WHERE `spell_id` = 122935 AND `ScriptName` = 'spell_keg_delivery_credit';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (122935, 'spell_keg_delivery_credit');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123064 AND `ScriptName` = 'spell_greenstone_kickstart';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123064, 'spell_greenstone_kickstart');
DELETE FROM `spell_script_names` WHERE `spell_id` = 131143 AND `ScriptName` = 'spell_greenstone_brew_bubble';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (131143, 'spell_greenstone_brew_bubble');
DELETE FROM `spell_script_names` WHERE `spell_id` = 131209 AND `ScriptName` = 'spell_greenstone_jade_pounce';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (131209, 'spell_greenstone_jade_pounce');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7868 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7868, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7869 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7869, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7872 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7872, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7873 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7873, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8083 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8083, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8102 AND `ScriptName` = 'AreaTrigger_at_behind_tzu';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8102, 'AreaTrigger_at_behind_tzu');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8469 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8469, 'AreaTrigger_at_greenstone_village');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8472 AND `ScriptName` = 'AreaTrigger_at_greenstone_village';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8472, 'AreaTrigger_at_greenstone_village');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 61203;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61203, 0, 0, 'Many thanks... I couldn\'t have held out much longer.', 12, 0, 100, 0, 0, 0, ''),
(61203, 1, 0, 'Alas, I\'m in no condition to go on. If only our entire supply of Greenstone Brew hadn\'t been stolen!', 12, 0, 100, 0, 0, 0, ''),
(61203, 2, 0, 'If you can venture into the surrounding forest and return any stolen barrels you find, I\'ll concoct a concentrated draft of marvelous power for you...', 12, 0, 100, 0, 0, 0, ''),
(61203, 3, 0, 'An adventurer saves the village, but a HERO returns the brew!', 14, 0, 100, 0, 0, 0, ''),
(61203, 3, 1, 'That\'ll teach those pests to pilfer our dojo\'s prized product!', 14, 0, 100, 0, 0, 0, ''),
(61203, 3, 2, 'Ah, back where it belongs. Thank you!', 14, 0, 100, 0, 0, 0, ''),
(61203, 3, 3, 'A precious barrel of Greenstone brew! Hurrah!', 14, 0, 100, 0, 0, 0, ''),
(61203, 4, 0, 'Ah, you have returned! One thousand thanks. Please, take this, our most potent creation: Volatile Greenstone Brew.', 12, 0, 100, 0, 0, 0, ''),
(61203, 5, 0, 'You\'ve received Volatile Greenstone Brew! Use it in combat to help defeat multiple enemies.', 41, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61342;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61342, 0, 0, 'Away, you fiends! Help!', 14, 0, 100, 20, 0, 0, ''),
(61342, 1, 0, 'There\'s hope for Greenstone! Thank you!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61346;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61346, 0, 0, 'Away, you fiends! Help!', 14, 0, 100, 20, 0, 0, ''),
(61346, 1, 0, 'Many thanks!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61350;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61350, 0, 0, 'Help! Help!', 14, 0, 100, 20, 0, 0, ''),
(61350, 1, 0, 'I thought I was doomed. Thank you so much!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61461;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61461, 0, 0, 'They\'ve overrun the village! HELP!', 14, 0, 100, 20, 0, 0, ''),
(61461, 1, 0, 'I thought I was doomed. Thank you so much!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61462;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61462, 0, 0, 'Away, you fiends! Help!', 14, 0, 100, 20, 0, 0, ''),
(61462, 1, 0, 'I thought I was doomed. Thank you so much!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62706;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62706, 0, 0, 'Eee! Monsters are attacking Greenstone Village! RUN AWAY!', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62988;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62988, 0, 0, 'You have my gratitude!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62989;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62989, 0, 0, 'You have my gratitude!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62990;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62990, 0, 0, 'You have my gratitude!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 65271;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(65271, 0, 0, 'Someone! Please help!', 14, 0, 100, 20, 0, 0, ''),
(65271, 1, 0, 'Many thanks!', 12, 0, 100, 0, 0, 0, ''),
(65271, 2, 0, 'The local earth spirit, Hui, is angry that we hired adventurers to drive off his mischievous sprites.', 12, 0, 100, 1, 0, 0, ''),
(65271, 3, 0, 'I can understand he\'s upset, but this attack is simply going too far!', 12, 0, 100, 5, 0, 0, '');

-- NOTE: instance_template map 1024 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 59357; -- Bucktooth Flapper
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_class` = 2 WHERE `entry` = 61155; -- Wily Woodling
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61157; -- Sassy Seedling
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61159; -- Greenstone Terror
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61174; -- Cursed Jade
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61183; -- Belligerent Blossom
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2110, `faction_H` = 2110 WHERE `entry` = 61203; -- Brewmaster Tzu
UPDATE `creature_template` SET `faction_A` = 190, `faction_H` = 190 WHERE `entry` = 61223; -- [DND] Monster Target (Wood)
UPDATE `creature_template` SET `npcflag` = 66177 WHERE `entry` = 61350; -- Graceful Swan
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61414; -- Doom Bloom
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62619; -- Jade Destroyer
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `flags_extra` = 128 WHERE `entry` = 62623; -- Jade Blaze
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `type` = 4, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62637; -- Cursed Brew
UPDATE `creature_template` SET `VehicleId` = 2262 WHERE `entry` = 62682; -- Burgled Barrel
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64774; -- Leopard Tree Frog
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64775; -- Masked Tanuki
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64776; -- Masked Tanuki Pup
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 66756; -- Cursed Brew Bubble
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 66772; -- Beast of Jade

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 61159;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61159, 0, 0, 0, 1, 0, '115662');
DELETE FROM `creature_template_addon` WHERE `entry` = 61461;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61461, 0, 0, 1, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62619;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62619, 0, 0, 0, 1, 0, '118865');
DELETE FROM `creature_template_addon` WHERE `entry` = 62637;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62637, 543755, 0, 0, 1, 0, '122260');
DELETE FROM `creature_template_addon` WHERE `entry` = 62988;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62988, 0, 0, 7, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62989;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62989, 0, 0, 7, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62990;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62990, 0, 0, 7, 1, 0, '');

-- conditions

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'PA SCROLL HUGE 06' WHERE `entry` = 215377;
UPDATE `gameobject_template` SET `type` = 3, `name` = 'Gold Coins', `data0` = 1635, `data1` = 49530, `data3` = 1 WHERE `entry` = 223230;

-- chest loot SkyFire lacks
-- Gold Coins (223230)
DELETE FROM `gameobject_loot_template` WHERE `entry` = 49530;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(49530, 34822, 0.5, 1, 0, 1, 1);

-- INFO gameobject entries LoA spawns on map 1024 and SkyFire does not: 212614 212615 212616 212617 212618 212619 212620 212621 212622 212623 212624 212625 214563 214564 214565 214566 214567 214568 214569 214570 215377 216301 216302 223230

-- Greenstone Village (1024): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9583000-9583299, gameobject 9583000-9583040. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9583000 AND 9583299;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9583000, 61157, 1024, 6144, 0, 0, 0, 0, 2044.24, -1974.76, 215.591, 1.44155, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543535
(9583001, 61157, 1024, 6144, 0, 0, 0, 0, 2041.2, -1976.09, 215.591, 3.39291, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543536
(9583002, 61157, 1024, 6144, 0, 0, 0, 0, 2042.14, -1973.19, 215.591, 5.34566, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543537
(9583003, 62706, 1024, 6144, 0, 0, 0, 0, 2004.06, -1992.08, 212.195, 2.66823, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543538
(9583004, 61223, 1024, 6144, 0, 0, 0, 0, 2046.73, -1985.9, 216.359, 1.75978, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543539
(9583005, 61204, 1024, 6144, 0, 0, 0, 0, 1988.72, -1961.75, 207.358, 5.07204, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543540
(9583006, 61157, 1024, 6144, 0, 0, 0, 0, 2047.72, -1974.87, 215.591, 3.90638, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543541
(9583007, 61174, 1024, 6144, 0, 0, 0, 0, 2089.18, -1886.98, 211.888, 0.708687, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543542
(9583008, 61223, 1024, 6144, 0, 0, 0, 0, 2049.45, -1978.48, 215.591, 3.31283, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543543
(9583009, 61157, 1024, 6144, 0, 0, 0, 0, 2003.45, -1969.14, 207.358, 5.68395, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543544
(9583010, 62945, 1024, 6144, 0, 0, 0, 0, 2071.56, -2072.98, 225.908, 5.08708, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543545
(9583011, 61183, 1024, 6144, 0, 0, 0, 0, 1957.86, -1972.9, 210.988, 4.56967, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543546
(9583012, 61155, 1024, 6144, 0, 0, 0, 0, 2045.82, -1978.26, 215.591, 4.87632, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543547
(9583013, 61155, 1024, 6144, 0, 0, 0, 0, 1996.98, -1961.03, 211.54, 5.28572, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543548
(9583014, 61155, 1024, 6144, 0, 0, 0, 0, 1960.16, -1975.19, 210.988, 3.51937, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543550
(9583015, 62945, 1024, 6144, 0, 0, 0, 0, 2094.47, -2032.53, 222.796, 4.33624, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543551
(9583016, 59312, 1024, 6144, 0, 0, 0, 0, 2083.95, -2016.02, 222.715, 0.431022, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543552
(9583017, 64761, 1024, 6144, 0, 0, 0, 0, 1960.26, -2021.62, 218.649, 1.74044, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543554
(9583018, 61462, 1024, 6144, 0, 0, 0, 0, 2046.52, -1983.39, 216.357, 1.73681, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543555
(9583019, 61183, 1024, 6144, 0, 0, 0, 0, 1920.32, -2007.2, 217.02, 2.45578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543556
(9583020, 61343, 1024, 6144, 0, 0, 0, 0, 1957.2, -1978.64, 211.771, 1.50776, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543557
(9583021, 61342, 1024, 6144, 0, 0, 0, 0, 1955.01, -1980.98, 211.757, 0.802056, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543558
(9583022, 61157, 1024, 6144, 0, 0, 0, 0, 2046.49, -1972.26, 215.591, 1.74372, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543559
(9583023, 61204, 1024, 6144, 0, 0, 0, 0, 1994.32, -1977.18, 207.358, 0.101594, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543561
(9583024, 61157, 1024, 6144, 0, 0, 0, 0, 2050.59, -1975.65, 215.591, 0.201652, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543562
(9583025, 61183, 1024, 6144, 0, 0, 0, 0, 1954.33, -1974.11, 210.988, 5.63777, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543563
(9583026, 61223, 1024, 6144, 0, 0, 0, 0, 2042.56, -1979.21, 215.591, 0.475792, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543564
(9583027, 61204, 1024, 6144, 0, 0, 0, 0, 2003.91, -1953.99, 207.358, 5.10917, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543565
(9583028, 61183, 1024, 6144, 0, 0, 0, 0, 1919.58, -2010.25, 217.908, 2.45614, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543568
(9583029, 61159, 1024, 6144, 0, 0, 0, 0, 2086.82, -1995.97, 219.694, 3.87105, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543569
(9583030, 61223, 1024, 6144, 0, 0, 0, 0, 1951.7, -1955.35, 207.358, 2.75321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543573
(9583031, 59312, 1024, 6144, 0, 0, 0, 0, 1972.06, -1939.92, 206.82, 3.92699, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543577
(9583032, 62619, 1024, 6144, 0, 0, 0, 0, 1938.19, -1861.92, 203.399, 4.56998, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543578
(9583033, 61203, 1024, 6144, 0, 0, 0, 0, 1937.45, -1866.51, 203.399, 1.39571, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543579
(9583034, 62682, 1024, 6144, 0, 0, 0, 0, 1919.66, -1986.73, 216.26, 3.59184, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543580
(9583035, 62682, 1024, 6144, 0, 0, 0, 0, 2100.54, -1995.81, 219.397, 1.30753, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543581
(9583036, 61183, 1024, 6144, 0, 0, 0, 0, 1968.28, -2016.62, 217.359, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543582
(9583037, 62945, 1024, 6144, 0, 0, 0, 0, 2070.46, -2070.18, 225.572, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543585
(9583038, 61155, 1024, 6144, 0, 0, 0, 0, 1971, -2015.74, 217.301, 2.81965, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543586
(9583039, 59312, 1024, 6144, 0, 0, 0, 0, 1960.58, -2023.5, 219.238, 1.3945, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543587
(9583040, 64761, 1024, 6144, 0, 0, 0, 0, 2083.03, -2016.44, 222.682, 2.25025, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543588
(9583041, 62945, 1024, 6144, 0, 0, 0, 0, 2095.57, -2029.73, 222.63, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543589
(9583042, 61183, 1024, 6144, 0, 0, 0, 0, 1919.69, -2009.96, 217.898, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543590
(9583043, 61183, 1024, 6144, 0, 0, 0, 0, 1922.44, -2008.94, 217.426, 2.45578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543591
(9583044, 61155, 1024, 6144, 0, 0, 0, 0, 2082.89, -2003.21, 222.119, 3.89243, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543593
(9583045, 61159, 1024, 6144, 0, 0, 0, 0, 1976.07, -1912.85, 204.042, 5.94531, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543594
(9583046, 61155, 1024, 6144, 0, 0, 0, 0, 1985.22, -1931.97, 203.955, 5.20108, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543595
(9583047, 61159, 1024, 6144, 0, 0, 0, 0, 1949.27, -1953.95, 207.278, 5.18782, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543596
(9583048, 64775, 1024, 6144, 0, 0, 0, 0, 1881.3, -1985.2, 213.123, 4.17263, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543598
(9583049, 61159, 1024, 6144, 0, 0, 0, 0, 1952.63, -1934.93, 207.278, 1.98583, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543600
(9583050, 61223, 1024, 6144, 0, 0, 0, 0, 1980.22, -1914.78, 204.326, 2.729, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543601
(9583051, 61157, 1024, 6144, 0, 0, 0, 0, 1983.43, -1928.39, 203.955, 3.62628, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543602
(9583052, 61223, 1024, 6144, 0, 0, 0, 0, 1981.38, -1917.17, 204.142, 4.35935, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543603
(9583053, 61223, 1024, 6144, 0, 0, 0, 0, 1945.39, -1952.33, 207.358, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543604
(9583054, 61223, 1024, 6144, 0, 0, 0, 0, 1983.19, -1914.85, 204.152, 0.124568, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543605
(9583055, 61223, 1024, 6144, 0, 0, 0, 0, 1950.58, -1931.48, 207.358, 4.64837, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543606
(9583056, 65271, 1024, 6144, 0, 0, 0, 0, 1981.97, -1915.81, 212.523, 5.44115, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543607
(9583057, 61159, 1024, 6144, 0, 0, 0, 0, 1980.6, -1920.48, 204.004, 1.36925, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543608
(9583058, 61223, 1024, 6144, 0, 0, 0, 0, 1945.03, -1943.06, 207.358, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543609
(9583059, 61461, 1024, 6144, 0, 0, 0, 0, 1937.31, -1947.56, 208.097, 0.0695852, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543610
(9583060, 61159, 1024, 6144, 0, 0, 0, 0, 1986.8, -1913.48, 204.004, 3.3137, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543612
(9583061, 61223, 1024, 6144, 0, 0, 0, 0, 1942.72, -1936.01, 207.358, 0.409659, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543613
(9583062, 61155, 1024, 6144, 0, 0, 0, 0, 1948.78, -1932.74, 207.33, 1.41112, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543614
(9583063, 64761, 1024, 6144, 0, 0, 0, 0, 1953.42, -1916.71, 207.665, 2.32858, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543615
(9583064, 61204, 1024, 6144, 0, 0, 0, 0, 1941.56, -1876.75, 203.762, 0.8597, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543616
(9583065, 61204, 1024, 6144, 0, 0, 0, 0, 1963.55, -1880.89, 200.538, 5.12145, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543618
(9583066, 61159, 1024, 6144, 0, 0, 0, 0, 1972.2, -1883.85, 200.538, 4.9382, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543620
(9583067, 61223, 1024, 6144, 0, 0, 0, 0, 2032.61, -1914.17, 208.444, 3.19156, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543621
(9583068, 61159, 1024, 6144, 0, 0, 0, 0, 1908.17, -1904.07, 201.508, 4.55558, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543622
(9583069, 61204, 1024, 6144, 0, 0, 0, 0, 1946.33, -1890.12, 200.538, 5.08433, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543624
(9583070, 61223, 1024, 6144, 0, 0, 0, 0, 1973.46, -1886.63, 199.742, 2.3963, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543625
(9583071, 61159, 1024, 6144, 0, 0, 0, 0, 2029.58, -1912.11, 207.358, 0.0996757, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543626
(9583072, 64761, 1024, 6144, 0, 0, 0, 0, 1922.04, -1900.12, 202.159, 2.88879, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543627
(9583073, 61204, 1024, 6144, 0, 0, 0, 0, 1957.33, -1893.56, 200.538, 0.113881, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543628
(9583074, 61223, 1024, 6144, 0, 0, 0, 0, 2031.8, -1909.6, 208.395, 3.63174, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543629
(9583075, 61223, 1024, 6144, 0, 0, 0, 0, 1971.96, -1887.62, 200.538, 2.3963, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543630
(9583076, 61155, 1024, 6144, 0, 0, 0, 0, 1968.33, -1879.38, 200.538, 4.6982, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543631
(9583077, 61155, 1024, 6144, 0, 0, 0, 0, 1910.38, -1913.05, 201.882, 5.73908, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543632
(9583078, 61183, 1024, 6144, 0, 0, 0, 0, 2018.88, -1887.63, 207.358, 1.78817, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543633
(9583079, 61183, 1024, 6144, 0, 0, 0, 0, 2014.07, -1887.72, 207.358, 1.37548, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543637
(9583080, 61346, 1024, 6144, 0, 0, 0, 0, 2016.12, -1880.37, 208.043, 4.70982, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543638
(9583081, 61204, 1024, 6144, 0, 0, 0, 0, 1926.46, -1869.03, 203.762, 5.88071, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543639
(9583082, 61204, 1024, 6144, 0, 0, 0, 0, 1945.21, -1859.03, 203.762, 1.51909, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543640
(9583083, 61183, 1024, 6144, 0, 0, 0, 0, 1906.47, -1875.06, 198.433, 4.48162, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543641
(9583084, 59312, 1024, 6144, 0, 0, 0, 0, 1994.75, -1869.73, 206.553, 4.70052, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543642
(9583085, 61183, 1024, 6144, 0, 0, 0, 0, 1902.19, -1880.86, 199.366, 4.50857, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543643
(9583086, 59312, 1024, 6144, 0, 0, 0, 0, 2038.27, -1861.79, 207.152, 2.8849, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543647
(9583087, 62945, 1024, 6144, 0, 0, 0, 0, 2051.29, -1836.83, 203.152, 5.66918, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543651
(9583088, 64775, 1024, 6144, 0, 0, 0, 0, 1936.34, -1801.31, 189.993, 5.95952, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543653
(9583089, 64775, 1024, 6144, 0, 0, 0, 0, 2074.07, -1888.79, 212.748, 4.07425, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543654
(9583090, 62945, 1024, 6144, 0, 0, 0, 0, 1984.95, -1791.64, 194.14, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543655
(9583091, 64776, 1024, 6144, 0, 0, 0, 0, 2067.83, -1897.21, 212.885, 4.07423, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543656
(9583092, 64776, 1024, 6144, 0, 0, 0, 0, 2069.02, -1895.6, 212.648, 4.07445, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543657
(9583093, 62945, 1024, 6144, 0, 0, 0, 0, 2080.1, -1840.3, 208.588, 3.32232, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543658
(9583094, 59312, 1024, 6144, 0, 0, 0, 0, 2105.55, -1923.98, 216.503, 1.2438, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543659
(9583095, 64775, 1024, 6144, 0, 0, 0, 0, 2123.34, -1961.05, 219.827, 3.13183, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543660
(9583096, 66772, 1024, 6144, 0, 0, 0, 0, 1938.19, -1861.92, 203.399, 4.56998, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543661
(9583097, 61183, 1024, 6144, 0, 0, 0, 0, 2134.61, -1996.78, 219.884, 3.26264, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543662
(9583098, 62682, 1024, 6144, 0, 0, 0, 0, 1914.65, -1903.28, 202.446, 3.45532, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543665
(9583099, 62682, 1024, 6144, 0, 0, 0, 0, 2002.59, -1842.92, 201.678, 0.9169, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543666
(9583100, 62682, 1024, 6144, 0, 0, 0, 0, 2047.02, -1859.08, 206.706, 0.881593, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543667
(9583101, 64775, 1024, 6144, 0, 0, 0, 0, 1817.91, -1891.48, 196.286, 4.83092, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543668
(9583102, 59312, 1024, 6144, 0, 0, 0, 0, 1864.38, -1939.12, 203.694, 0.228398, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543669
(9583103, 62682, 1024, 6144, 0, 0, 0, 0, 2081.88, -1862.06, 209.173, 1.36822, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543670
(9583104, 62682, 1024, 6144, 0, 0, 0, 0, 2116.78, -1819.77, 219.909, 3.8122, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543671
(9583105, 64776, 1024, 6144, 0, 0, 0, 0, 2135.76, -1858.14, 219.932, 5.63906, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543672
(9583106, 62682, 1024, 6144, 0, 0, 0, 0, 2118.51, -1887.22, 218.076, 0.54535, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543673
(9583107, 64775, 1024, 6144, 0, 0, 0, 0, 2135.64, -1857.83, 219.819, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543674
(9583108, 62682, 1024, 6144, 0, 0, 0, 0, 2100.4, -1932.22, 216.082, 2.50628, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543675
(9583109, 61183, 1024, 6144, 0, 0, 0, 0, 2121.34, -1832.12, 218.231, 3.9954, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543676
(9583110, 61183, 1024, 6144, 0, 0, 0, 0, 2118.31, -1839.92, 215.805, 4.01415, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543677
(9583111, 61183, 1024, 6144, 0, 0, 0, 0, 2125.85, -2000.59, 219.762, 0.092016, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543678
(9583112, 62682, 1024, 6144, 0, 0, 0, 0, 2142.56, -1960.33, 221.079, 5.37764, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543679
(9583113, 61157, 1024, 6144, 0, 0, 0, 0, 2160.48, -1926.24, 220.253, 5.41433, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543682
(9583114, 61159, 1024, 6144, 0, 0, 0, 0, 2164.52, -1886.5, 219.127, 2.57381, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543683
(9583115, 61157, 1024, 6144, 0, 0, 0, 0, 2156.67, -1921.54, 220.115, 5.67195, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543685
(9583116, 61157, 1024, 6144, 0, 0, 0, 0, 2161.52, -1917.83, 220.003, 4.07439, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543687
(9583117, 62682, 1024, 6144, 0, 0, 0, 0, 2032.8, -2009.06, 218.601, 0.0700965, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543688
(9583118, 61223, 1024, 6144, 0, 0, 0, 0, 2161.65, -1884.63, 219.127, 5.19058, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543690
(9583119, 62682, 1024, 6144, 0, 0, 0, 0, 2088.79, -1873.31, 211.439, 3.98547, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543692
(9583120, 62945, 1024, 6144, 0, 0, 0, 0, 2145.75, -2029.79, 225.317, 1.35425, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543693
(9583121, 62682, 1024, 6144, 0, 0, 0, 0, 2085.68, -2069.11, 223.209, 2.98361, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543694
(9583122, 61155, 1024, 6144, 0, 0, 0, 0, 2182.59, -1977.58, 223.222, 2.57588, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543695
(9583123, 61183, 1024, 6144, 0, 0, 0, 0, 2178.33, -1978.61, 223.779, 2.69088, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543696
(9583124, 61223, 1024, 6144, 0, 0, 0, 0, 2181.73, -1931.98, 219.127, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543697
(9583125, 61223, 1024, 6144, 0, 0, 0, 0, 2177.29, -1919.08, 219.127, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543698
(9583126, 61155, 1024, 6144, 0, 0, 0, 0, 2187.06, -1921.57, 219.152, 1.38891, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543699
(9583127, 61223, 1024, 6144, 0, 0, 0, 0, 2195.35, -1926.91, 219.128, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543700
(9583128, 61183, 1024, 6144, 0, 0, 0, 0, 2179.63, -1918.17, 219.127, 3.40039, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543701
(9583129, 61183, 1024, 6144, 0, 0, 0, 0, 2180.85, -1929.02, 219.127, 5.16229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543702
(9583130, 62989, 1024, 6144, 0, 0, 0, 0, 2186.24, -1926.59, 219.127, 4.55374, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543703
(9583131, 61157, 1024, 6144, 0, 0, 0, 0, 2180.34, -1907.23, 219.152, 2.17213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543704
(9583132, 61157, 1024, 6144, 0, 0, 0, 0, 2213.08, -1891.55, 222.949, 0.981965, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543705
(9583133, 62945, 1024, 6144, 0, 0, 0, 0, 2242.49, -1983.29, 219.421, 0.727292, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543706
(9583134, 61157, 1024, 6144, 0, 0, 0, 0, 2181.52, -1881.82, 219.169, 5.43222, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543707
(9583135, 61159, 1024, 6144, 0, 0, 0, 0, 2174.02, -1877.24, 219.127, 1.97894, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543708
(9583136, 61157, 1024, 6144, 0, 0, 0, 0, 2204.92, -1880.04, 223.449, 4.3964, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543709
(9583137, 61157, 1024, 6144, 0, 0, 0, 0, 2181.84, -1891.08, 219.169, 4.07207, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543710
(9583138, 62990, 1024, 6144, 0, 0, 0, 0, 2218.82, -1904.41, 223.003, 5.59318, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543711
(9583139, 61157, 1024, 6144, 0, 0, 0, 0, 2186.42, -1911.05, 219.152, 2.11726, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543712
(9583140, 61157, 1024, 6144, 0, 0, 0, 0, 2214.13, -1902.88, 223.044, 1.05443, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543713
(9583141, 61157, 1024, 6144, 0, 0, 0, 0, 2173.45, -1881.48, 219.169, 1.4164, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543714
(9583142, 62988, 1024, 6144, 0, 0, 0, 0, 2171.78, -1887.61, 219.127, 5.2741, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543715
(9583143, 61223, 1024, 6144, 0, 0, 0, 0, 2172.45, -1873.91, 219.127, 4.93324, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543717
(9583144, 61157, 1024, 6144, 0, 0, 0, 0, 2221.32, -1897.53, 222.949, 2.65119, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543718
(9583145, 61157, 1024, 6144, 0, 0, 0, 0, 2187.82, -1902.61, 219.152, 0.852214, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543719
(9583146, 64776, 1024, 6144, 0, 0, 0, 0, 2230.13, -1943.68, 223.607, 4.61579, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543720
(9583147, 64775, 1024, 6144, 0, 0, 0, 0, 2230.32, -1945.99, 223.684, 4.90018, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543721
(9583148, 61157, 1024, 6144, 0, 0, 0, 0, 2204.56, -1868.71, 224.059, 1.88001, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543722
(9583149, 59312, 1024, 6144, 0, 0, 0, 0, 2194.7, -1861.35, 223.686, 6.10054, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543723
(9583150, 61157, 1024, 6144, 0, 0, 0, 0, 2214.04, -1873.58, 225.527, 5.13845, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543724
(9583151, 61159, 1024, 6144, 0, 0, 0, 0, 2259.48, -1914.27, 225.124, 1.46607, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543728
(9583152, 61159, 1024, 6144, 0, 0, 0, 0, 2258.58, -1910.37, 224.886, 3.15136, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543729
(9583153, 61159, 1024, 6144, 0, 0, 0, 0, 2274.7, -1877.25, 231.02, 3.89731, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543732
(9583154, 61159, 1024, 6144, 0, 0, 0, 0, 2268.53, -1886.07, 229.716, 3.71117, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543733
(9583155, 59312, 1024, 6144, 0, 0, 0, 0, 2167.36, -1816.28, 222.615, 6.10246, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543734
(9583156, 61156, 1024, 6144, 0, 0, 0, 0, 2257.34, -1835.97, 231.032, 4.63725, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543735
(9583157, 64761, 1024, 6144, 0, 0, 0, 0, 2317.24, -1881.51, 225.678, 3.92147, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543736
(9583158, 62945, 1024, 6144, 0, 0, 0, 0, 2104.29, -2025.13, 224.466, 0.191701, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543738
(9583159, 64761, 1024, 6144, 0, 0, 0, 0, 1965.48, -2019.81, 218.123, 3.07905, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543739
(9583160, 59312, 1024, 6144, 0, 0, 0, 0, 2067.38, -1993.05, 217.203, 0.188587, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543740
(9583161, 61155, 1024, 6144, 0, 0, 0, 0, 1970.79, -2015.67, 217.285, 2.81965, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543741
(9583162, 61183, 1024, 6144, 0, 0, 0, 0, 1922.29, -2008.81, 217.397, 2.45578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543742
(9583163, 61174, 1024, 6144, 0, 0, 0, 0, 1998.9, -1970.64, 207.358, 4.97387, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543743
(9583164, 64761, 1024, 6144, 0, 0, 0, 0, 1960.58, -2023.5, 219.238, 4.38506, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543745
(9583165, 59312, 1024, 6144, 0, 0, 0, 0, 2083.03, -2016.44, 222.682, 1.31884, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543746
(9583166, 61157, 1024, 6144, 0, 0, 0, 0, 2016.28, -1888.94, 207.358, 1.48887, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543747
(9583167, 64775, 1024, 6144, 0, 0, 0, 0, 1881.92, -1984.73, 213.198, 4.53593, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543748
(9583168, 61157, 1024, 6144, 0, 0, 0, 0, 2019.26, -1892.64, 207.358, 1.97129, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543749
(9583169, 61157, 1024, 6144, 0, 0, 0, 0, 2013.24, -1892.14, 207.358, 0.848778, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543750
(9583170, 64761, 1024, 6144, 0, 0, 0, 0, 1922.09, -1899.2, 202.099, 2.61155, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543754
(9583171, 62637, 1024, 6144, 0, 0, 0, 0, 2021.67, -1909.61, 207.292, 1.56608, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 543755
(9583172, 61159, 1024, 6144, 0, 0, 0, 0, 2057.32, -2014.2, 221.298, 3.16881, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543757
(9583173, 61155, 1024, 6144, 0, 0, 0, 0, 2066.3, -1946.83, 212.074, 3.21396, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543758
(9583174, 61155, 1024, 6144, 0, 0, 0, 0, 2048.9, -2017.25, 221.321, 3.20014, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543760
(9583175, 59312, 1024, 6144, 0, 0, 0, 0, 1995.82, -1864.99, 205.315, 1.58252, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543761
(9583176, 61174, 1024, 6144, 0, 0, 0, 0, 2178.12, -1897.62, 219.169, 3.49217, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543762
(9583177, 59312, 1024, 6144, 0, 0, 0, 0, 1991.71, -1930.26, 203.957, 5.49746, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543769
(9583178, 61159, 1024, 6144, 0, 0, 0, 0, 2020.06, -1920.49, 207.358, 4.13545, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543772
(9583179, 61350, 1024, 6144, 0, 0, 0, 0, 2016.62, -1931.18, 207.318, 5.31291, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 543773
(9583180, 61183, 1024, 6144, 0, 0, 0, 0, 1907.29, -1863.07, 198.645, 4.70068, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543775
(9583181, 61183, 1024, 6144, 0, 0, 0, 0, 1905.02, -1859.48, 199.029, 4.4305, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543776
(9583182, 61155, 1024, 6144, 0, 0, 0, 0, 2002.96, -1836.79, 199.58, 5.82172, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543777
(9583183, 64761, 1024, 6144, 0, 0, 0, 0, 2035.33, -1872.72, 207.367, 5.30864, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543778
(9583184, 64776, 1024, 6144, 0, 0, 0, 0, 2075.74, -1887.78, 212.737, 4.18804, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543779
(9583185, 64776, 1024, 6144, 0, 0, 0, 0, 2076.75, -1886.1, 212.739, 4.19452, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543780
(9583186, 61155, 1024, 6144, 0, 0, 0, 0, 2012.97, -1837.41, 200.495, 5.99603, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543781
(9583187, 61155, 1024, 6144, 0, 0, 0, 0, 1977.62, -1837.76, 196.595, 5.24946, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543782
(9583188, 61159, 1024, 6144, 0, 0, 0, 0, 1975.73, -1832.79, 195.941, 5.74829, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543783
(9583189, 64775, 1024, 6144, 0, 0, 0, 0, 2074.68, -1889.62, 212.52, 4.16477, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543784
(9583190, 61183, 1024, 6144, 0, 0, 0, 0, 2092.49, -1910.57, 212.154, 1.42163, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543785
(9583191, 62945, 1024, 6144, 0, 0, 0, 0, 2046.46, -1838.87, 204.106, 0.401174, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543786
(9583192, 59312, 1024, 6144, 0, 0, 0, 0, 2107.77, -1916.48, 214.788, 1.27223, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543787
(9583193, 62945, 1024, 6144, 0, 0, 0, 0, 2089.13, -1839.78, 209.679, 3.29053, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543788
(9583194, 61183, 1024, 6144, 0, 0, 0, 0, 2118.32, -1961.73, 219.389, 4.37398, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543789
(9583195, 61183, 1024, 6144, 0, 0, 0, 0, 2120.42, -1964.28, 219.854, 4.37395, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543790
(9583196, 64775, 1024, 6144, 0, 0, 0, 0, 2126.44, -1952.53, 220.026, 2.24401, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543791
(9583197, 61155, 1024, 6144, 0, 0, 0, 0, 2125.49, -1921.89, 216.12, 3.63105, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543792
(9583198, 64775, 1024, 6144, 0, 0, 0, 0, 1942.31, -1802.99, 190.876, 6.00408, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543796
(9583199, 64761, 1024, 6144, 0, 0, 0, 0, 2056.48, -1750.34, 205.644, 0.334416, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543797
(9583200, 64774, 1024, 6144, 0, 0, 0, 0, 1923.97, -1749.07, 190.426, 5.39733, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543798
(9583201, 59357, 1024, 6144, 0, 0, 0, 0, 1962.34, -1698.68, 190.545, 4.60108, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543799
(9583202, 59357, 1024, 6144, 0, 0, 0, 0, 1957.12, -1706.73, 190.973, 5.07099, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543800
(9583203, 64775, 1024, 6144, 0, 0, 0, 0, 2141.81, -1860.91, 220.171, 5.95964, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543802
(9583204, 61183, 1024, 6144, 0, 0, 0, 0, 2125.07, -1832.15, 219.356, 0.847559, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543803
(9583205, 64776, 1024, 6144, 0, 0, 0, 0, 2139.05, -1859.69, 219.885, 5.89307, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543804
(9583206, 61157, 1024, 6144, 0, 0, 0, 0, 2155.16, -1921.76, 219.934, 5.22711, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543806
(9583207, 61183, 1024, 6144, 0, 0, 0, 0, 2120.83, -1832.76, 218.158, 0.883556, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543807
(9583208, 62682, 1024, 6144, 0, 0, 0, 0, 2135.5, -1853.37, 219.99, 4.18967, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543808
(9583209, 61157, 1024, 6144, 0, 0, 0, 0, 2161.57, -1920.2, 220.115, 4.65209, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543810
(9583210, 61157, 1024, 6144, 0, 0, 0, 0, 2181.25, -1907.93, 219.127, 0.624233, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543811
(9583211, 62682, 1024, 6144, 0, 0, 0, 0, 2145.65, -2020.67, 226.314, 4.49371, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543814
(9583212, 61183, 1024, 6144, 0, 0, 0, 0, 2174.24, -1974.73, 223.383, 5.05014, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543815
(9583213, 62945, 1024, 6144, 0, 0, 0, 0, 1977.98, -1795.39, 194.132, 0.901741, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543816
(9583214, 62945, 1024, 6144, 0, 0, 0, 0, 2138.78, -2034.86, 224.088, 5.86714, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543817
(9583215, 59312, 1024, 6144, 0, 0, 0, 0, 1845.94, -1937.82, 200.778, 5.97132, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543818
(9583216, 61157, 1024, 6144, 0, 0, 0, 0, 2184.8, -1886.21, 219.169, 4.05687, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543819
(9583217, 61157, 1024, 6144, 0, 0, 0, 0, 2204.82, -1876.78, 223.955, 5.8579, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543820
(9583218, 61157, 1024, 6144, 0, 0, 0, 0, 2214.49, -1872.4, 225.7, 0.234514, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543821
(9583219, 61155, 1024, 6144, 0, 0, 0, 0, 2214.11, -1951.48, 222.289, 4.30905, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543822
(9583220, 61157, 1024, 6144, 0, 0, 0, 0, 2181.76, -1880.1, 219.169, 5.45519, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543823
(9583221, 61157, 1024, 6144, 0, 0, 0, 0, 2203.81, -1871.23, 223.908, 4.48461, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543824
(9583222, 59312, 1024, 6144, 0, 0, 0, 0, 2212.72, -1862.42, 226.559, 2.96087, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543825
(9583223, 61157, 1024, 6144, 0, 0, 0, 0, 2212.56, -1906.2, 223.044, 1.92141, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543826
(9583224, 61157, 1024, 6144, 0, 0, 0, 0, 2222, -1897.32, 222.949, 2.64825, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543827
(9583225, 61157, 1024, 6144, 0, 0, 0, 0, 2214.76, -1889.9, 222.949, 1.40088, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543828
(9583226, 64775, 1024, 6144, 0, 0, 0, 0, 2247.39, -1941.85, 226.686, 1.69888, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543829
(9583227, 61159, 1024, 6144, 0, 0, 0, 0, 2247.15, -1932.91, 225.442, 3.83204, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543830
(9583228, 64776, 1024, 6144, 0, 0, 0, 0, 2246.76, -1943.67, 226.494, 0.906155, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543832
(9583229, 61159, 1024, 6144, 0, 0, 0, 0, 2243.74, -1941.66, 225.892, 4.30285, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543833
(9583230, 61159, 1024, 6144, 0, 0, 0, 0, 2207.12, -1835.04, 226.982, 0.840015, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543835
(9583231, 62945, 1024, 6144, 0, 0, 0, 0, 2247.97, -1986.69, 218.389, 0.531895, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543837
(9583232, 61159, 1024, 6144, 0, 0, 0, 0, 2264.97, -1885.02, 229.615, 3.68787, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543839
(9583233, 61159, 1024, 6144, 0, 0, 0, 0, 2273.21, -1882.05, 230.55, 3.82609, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543840
(9583234, 59312, 1024, 6144, 0, 0, 0, 0, 2170.27, -1818.19, 222.851, 1.07129, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543841
(9583235, 59312, 1024, 6144, 0, 0, 0, 0, 2318.04, -1897.58, 224.738, 4.64108, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543842
(9583236, 61159, 1024, 6144, 0, 0, 0, 0, 2067.92, -1946.62, 212.283, 0.0566907, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543851
(9583237, 61155, 1024, 6144, 0, 0, 0, 0, 2103.4, -1976, 218.166, 5.91713, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543852
(9583238, 61183, 1024, 6144, 0, 0, 0, 0, 2065.01, -1887.71, 211.765, 5.83877, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543854
(9583239, 59312, 1024, 6144, 0, 0, 0, 0, 2101.91, -1925.45, 216.701, 2.6714, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543856
(9583240, 61183, 1024, 6144, 0, 0, 0, 0, 2060.25, -1882.31, 210.399, 5.69268, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543857
(9583241, 64775, 1024, 6144, 0, 0, 0, 0, 2133.32, -1958.03, 221.219, 1.56883, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543859
(9583242, 59312, 1024, 6144, 0, 0, 0, 0, 1960.73, -1925.01, 204.81, 5.33207, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543860
(9583243, 61183, 1024, 6144, 0, 0, 0, 0, 2126.16, -1921.23, 216.186, 0.470641, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543863
(9583244, 64775, 1024, 6144, 0, 0, 0, 0, 2083.27, -1881.01, 211.298, 6.06248, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543866
(9583245, 64776, 1024, 6144, 0, 0, 0, 0, 2079.08, -1880.47, 211.722, 0.0701572, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543867
(9583246, 64776, 1024, 6144, 0, 0, 0, 0, 2080.4, -1880.35, 211.338, 6.05459, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543869
(9583247, 61183, 1024, 6144, 0, 0, 0, 0, 2126.74, -2001.82, 219.984, 3.44331, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543870
(9583248, 61157, 1024, 6144, 0, 0, 0, 0, 2158.78, -1925.58, 220.407, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543871
(9583249, 61155, 1024, 6144, 0, 0, 0, 0, 2039.42, -1861.31, 206.779, 5.20484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543873
(9583250, 64761, 1024, 6144, 0, 0, 0, 0, 2038.26, -1861.8, 207.152, 2.8869, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543874
(9583251, 61155, 1024, 6144, 0, 0, 0, 0, 2032.85, -1855.04, 207.732, 2.06328, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543877
(9583252, 61157, 1024, 6144, 0, 0, 0, 0, 2161.73, -1917.48, 219.736, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543879
(9583253, 59312, 1024, 6144, 0, 0, 0, 0, 1995.55, -1876.48, 207.22, 4.72606, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543883
(9583254, 62945, 1024, 6144, 0, 0, 0, 0, 2144.99, -2034.83, 224.685, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543884
(9583255, 61155, 1024, 6144, 0, 0, 0, 0, 2174.93, -1969.32, 222.293, 1.8491, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543886
(9583256, 61183, 1024, 6144, 0, 0, 0, 0, 2175.24, -1976.46, 223.641, 2.59215, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543888
(9583257, 61157, 1024, 6144, 0, 0, 0, 0, 2212.07, -1906.45, 223.003, 1.33555, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543889
(9583258, 61157, 1024, 6144, 0, 0, 0, 0, 2189.14, -1910.16, 219.127, 0.624233, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543890
(9583259, 61157, 1024, 6144, 0, 0, 0, 0, 2186.79, -1901.86, 219.127, 0.624233, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543891
(9583260, 64776, 1024, 6144, 0, 0, 0, 0, 2245.73, -1944.36, 226.238, 2.91962, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543892
(9583261, 61159, 1024, 6144, 0, 0, 0, 0, 2244.72, -1939.56, 225.903, 1.17827, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543893
(9583262, 61159, 1024, 6144, 0, 0, 0, 0, 2247.17, -1932.89, 225.591, 0.690686, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543894
(9583263, 64761, 1024, 6144, 0, 0, 0, 0, 2236.8, -2025.85, 225.809, 2.63784, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543895
(9583264, 64775, 1024, 6144, 0, 0, 0, 0, 2244.86, -1944.16, 226.134, 2.91296, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543896
(9583265, 62945, 1024, 6144, 0, 0, 0, 0, 2240.42, -1990.89, 221.155, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543897
(9583266, 61183, 1024, 6144, 0, 0, 0, 0, 2195.87, -1924.29, 219.13, 4.56906, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543898
(9583267, 61157, 1024, 6144, 0, 0, 0, 0, 2182.79, -1888.4, 219.169, 1.85713, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543899
(9583268, 61157, 1024, 6144, 0, 0, 0, 0, 2214.7, -1890.44, 222.949, 1.22517, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543900
(9583269, 61157, 1024, 6144, 0, 0, 0, 0, 2180.8, -1880.64, 219.169, 2.14979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543901
(9583270, 61157, 1024, 6144, 0, 0, 0, 0, 2222.32, -1898.06, 222.969, 4.82652, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543902
(9583271, 61157, 1024, 6144, 0, 0, 0, 0, 2173.9, -1885.92, 219.169, 5.02426, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543903
(9583272, 64775, 1024, 6144, 0, 0, 0, 0, 2149.18, -2110.22, 226.577, 0.785398, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543904
(9583273, 61157, 1024, 6144, 0, 0, 0, 0, 2204.48, -1868.31, 224.008, 1.33555, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543905
(9583274, 61157, 1024, 6144, 0, 0, 0, 0, 2204.25, -1876.53, 223.769, 1.33555, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543906
(9583275, 61157, 1024, 6144, 0, 0, 0, 0, 2211.69, -1873.06, 225.404, 1.33555, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543907
(9583276, 64776, 1024, 6144, 0, 0, 0, 0, 2134.36, -1857.09, 219.91, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543908
(9583277, 59312, 1024, 6144, 0, 0, 0, 0, 2214.71, -1863.91, 226.856, 3.34607, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543909
(9583278, 61183, 1024, 6144, 0, 0, 0, 0, 2109.78, -1849.17, 213.495, 4.23738, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543910
(9583279, 61183, 1024, 6144, 0, 0, 0, 0, 2109.91, -1855.48, 212.968, 4.34493, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543911
(9583280, 62945, 1024, 6144, 0, 0, 0, 0, 2086.27, -1837.62, 209.275, 2.48423, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543912
(9583281, 62945, 1024, 6144, 0, 0, 0, 0, 2055.68, -1841.37, 204.503, 3.03551, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543913
(9583282, 61159, 1024, 6144, 0, 0, 0, 0, 1957.42, -1895.19, 200.576, 4.24059, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543914
(9583283, 62682, 1024, 6144, 0, 0, 0, 0, 1997.12, -1780.3, 194.539, 3.80242, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543915
(9583284, 64761, 1024, 6144, 0, 0, 0, 0, 2059.26, -1752.74, 206.161, 0.527864, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543916
(9583285, 64775, 1024, 6144, 0, 0, 0, 0, 1942, -1802.26, 190.737, 3.27351, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543919
(9583286, 62945, 1024, 6144, 0, 0, 0, 0, 1992.98, -1785.87, 193.072, 0.963786, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543920
(9583287, 61183, 1024, 6144, 0, 0, 0, 0, 1902.79, -1877.54, 198.841, 4.54179, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543923
(9583288, 59312, 1024, 6144, 0, 0, 0, 0, 1925.27, -1890.72, 201.343, 0.127301, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543924
(9583289, 64774, 1024, 6144, 0, 0, 0, 0, 1925.33, -1752.78, 191.108, 4.80939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543926
(9583290, 61183, 1024, 6144, 0, 0, 0, 0, 1904.45, -1883.64, 199.736, 4.48089, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543927
(9583291, 64761, 1024, 6144, 0, 0, 0, 0, 1843.69, -1780.85, 188.84, 0.734267, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543928
(9583292, 62945, 1024, 6144, 0, 0, 0, 0, 2167.74, -1783.98, 222.554, 0.263878, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543930
(9583293, 62945, 1024, 6144, 0, 0, 0, 0, 2090.69, -1763.56, 213.805, 4.95215, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543931
(9583294, 64761, 1024, 6144, 0, 0, 0, 0, 2152.59, -1814.37, 223.053, 5.60006, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 543932
(9583295, 64775, 1024, 6144, 0, 0, 0, 0, 2129.48, -1732.27, 220.891, 0.496852, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543933
(9583296, 62682, 1024, 6144, 0, 0, 0, 0, 1943.42, -1912.72, 206.523, 0.98118, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543934
(9583297, 59312, 1024, 6144, 0, 0, 0, 0, 1872.98, -1934.77, 203.422, 6.10054, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543935
(9583298, 61159, 1024, 6144, 0, 0, 0, 0, 2264.73, -1885.17, 229.562, 3.68787, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543941
(9583299, 59312, 1024, 6144, 0, 0, 0, 0, 2318, -1879.61, 225.337, 3.27736, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA 543943

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9583000 AND 9583040;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9583000, 214563, 1024, 6144, 0, 0, 2046.95, -1988.58, 216.188, 4.79965, 0, 0, -0.642788, 0.766044, 7200, 255, 1), -- LoA 535521
(9583001, 214566, 1024, 6144, 0, 0, 1954.92, -1987.37, 211.655, 1.21837, 0, 0, -0.737277, 0.67559, 7200, 255, 1), -- LoA 535522
(9583002, 214567, 1024, 6144, 0, 0, 1958.08, -1988.03, 211.655, 2.25684, 0, 0, -0.737277, 0.67559, 7200, 255, 1), -- LoA 535523
(9583003, 215377, 1024, 6144, 0, 0, 2015.05, -1886.75, 207.425, 0.96007, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535524
(9583004, 215377, 1024, 6144, 0, 0, 2012.71, -1889.52, 207.425, 5.66689, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535525
(9583005, 215377, 1024, 6144, 0, 0, 2020.82, -1887.66, 207.425, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535526
(9583006, 215377, 1024, 6144, 0, 0, 2017.34, -1889.5, 207.425, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535527
(9583007, 215377, 1024, 6144, 0, 0, 2015.09, -1890.09, 207.425, 5.49779, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535528
(9583008, 212619, 1024, 6144, 0, 0, 2038.32, -1918.7, 208.272, 5.25344, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535529
(9583009, 215377, 1024, 6144, 0, 0, 2015.38, -1888.47, 207.425, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535530
(9583010, 212620, 1024, 6144, 0, 0, 2040.33, -1922.73, 207.526, 0.0959918, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535531
(9583011, 215377, 1024, 6144, 0, 0, 2019.24, -1886.19, 207.425, 0.928688, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535532
(9583012, 215377, 1024, 6144, 0, 0, 2011.77, -1887.93, 207.425, 0.588003, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535533
(9583013, 212617, 1024, 6144, 0, 0, 2039.44, -1909.04, 208.294, 5.8294, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535534
(9583014, 212616, 1024, 6144, 0, 0, 2039, -1911.36, 208.294, 0.139626, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535535
(9583015, 212618, 1024, 6144, 0, 0, 2041.86, -1918.3, 208.272, 4.21497, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535536
(9583016, 212614, 1024, 6144, 0, 0, 2044.25, -1910.81, 208.379, 0.104717, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535537
(9583017, 212615, 1024, 6144, 0, 0, 2039.62, -1913.14, 208.272, 0.549777, 0, 0, 0.0479782, 0.998848, 7200, 255, 1), -- LoA 535538
(9583018, 215377, 1024, 6144, 0, 0, 2020.03, -1889.81, 207.425, 0.844154, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535539
(9583019, 215377, 1024, 6144, 0, 0, 2016.73, -1887.2, 207.425, 0.193211, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535540
(9583020, 215377, 1024, 6144, 0, 0, 2012.85, -1886.1, 207.425, 1.23606, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535541
(9583021, 214564, 1024, 6144, 0, 0, 2016.28, -1875.88, 207.899, 4.54658, 0, 0, 0.697791, 0.716302, 7200, 255, 1), -- LoA 535542
(9583022, 214565, 1024, 6144, 0, 0, 2018.44, -1874, 207.899, 1.89368, 0, 0, 0.697791, 0.716302, 7200, 255, 1), -- LoA 535543
(9583023, 212624, 1024, 6144, 0, 0, 2175.85, -1937.57, 219.857, 6.23955, 0, 0, -0.728371, 0.685183, 7200, 255, 1), -- LoA 535544
(9583024, 212625, 1024, 6144, 0, 0, 2172.39, -1940.79, 219.845, 3.08918, 0, 0, -0.728371, 0.685183, 7200, 255, 1), -- LoA 535545
(9583025, 212623, 1024, 6144, 0, 0, 2177.83, -1939.2, 219.857, 1.82387, 0, 0, -0.728371, 0.685183, 7200, 255, 1), -- LoA 535546
(9583026, 212621, 1024, 6144, 0, 0, 2190.89, -1946.09, 219.857, 0.619591, 0, 0, -0.728371, 0.685183, 7200, 255, 1), -- LoA 535547
(9583027, 212622, 1024, 6144, 0, 0, 2179.06, -1937.66, 219.857, 3.04558, 0, 0, -0.728371, 0.685183, 7200, 255, 1), -- LoA 535548
(9583028, 214569, 1024, 6144, 0, 0, 2225.5, -1915.34, 223.631, 5.75959, 0, 0, -0.402747, 0.915312, 7200, 255, 1), -- LoA 535549
(9583029, 214570, 1024, 6144, 0, 0, 2225.8, -1918.29, 223.722, 0.441702, 0, 0, -0.402747, 0.915312, 7200, 255, 1), -- LoA 535550
(9583030, 216302, 1024, 6144, 0, 0, 2229.25, -1912.18, 223.695, 3.86292, 0, 0, -0.402747, 0.915312, 7200, 255, 1), -- LoA 535551
(9583031, 212616, 1024, 6144, 0, 0, 2164.72, -1871.33, 219.76, 2.37364, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535552
(9583032, 212614, 1024, 6144, 0, 0, 2161.05, -1867.53, 219.846, 2.33874, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535553
(9583033, 212619, 1024, 6144, 0, 0, 2170.92, -1867.34, 219.738, 1.20428, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535554
(9583034, 212618, 1024, 6144, 0, 0, 2168.43, -1864.81, 219.738, 0.165807, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535555
(9583035, 212620, 1024, 6144, 0, 0, 2172.86, -1863.28, 218.993, 2.33001, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535556
(9583036, 212617, 1024, 6144, 0, 0, 2162.61, -1872.41, 219.76, 1.78024, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535557
(9583037, 212615, 1024, 6144, 0, 0, 2165.74, -1869.75, 219.738, 2.7838, 0, 0, 0.918791, 0.394744, 7200, 255, 1), -- LoA 535558
(9583038, 214568, 1024, 6144, 0, 0, 1938.97, -1945.02, 207.973, 3.0597, 0, 0, 0.999962, -0.00872653, 7200, 255, 1), -- LoA 535559
(9583039, 216301, 1024, 6144, 0, 0, 1938.57, -1951.83, 207.967, 1.56781, 0, 0, 0.999962, -0.00872653, 7200, 255, 1), -- LoA 535560
(9583040, 223230, 1024, 6144, 0, 0, 1997.85, -1962.72, 207.337, 4.98512, 0, 0, 0, 1, 7200, 255, 1); -- LoA 535587

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 95830000 AND 95832990 OR `id` BETWEEN 9583000 AND 9583299;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(9583171, 1, 2023.54, -1914.75, 207.295, 0, 0, 0, 0, 100, 0),
(9583171, 2, 2023.22, -1913.8, 207.295, 0, 0, 0, 0, 100, 0),
(9583171, 3, 2027.75, -1917.47, 207.295, 0, 0, 0, 0, 100, 0),
(9583171, 4, 2027.75, -1917.47, 207.295, 0, 0, 0, 0, 100, 0),
(9583179, 1, 2028.35, -1926.96, 207.295, 0, 0, 1, 0, 100, 0),
(9583179, 2, 2028.08, -1926, 207.295, 0, 0, 1, 0, 100, 0),
(9583179, 3, 2025.91, -1918.12, 207.295, 0, 0, 1, 0, 100, 0),
(9583179, 4, 2024.48, -1909, 207.295, 0, 0, 1, 0, 100, 0),
(9583179, 5, 2024.48, -1909, 207.295, 0, 0, 1, 0, 100, 0);

-- Unga Ingoo (map 1048): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1048;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1048, 870, 'instance_unga_ingoo', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_captain_ook' WHERE `entry` = 62465; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaster_bo_escort' WHERE `entry` = 62467; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_ookie' WHERE `entry` = 62468; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_spearscamp' WHERE `entry` = 62474; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_bird_haver' WHERE `entry` = 62475; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_gladiators' WHERE `entry` = 62485; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_gladiators' WHERE `entry` = 62486; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaster_bo_brew' WHERE `entry` = 62491; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_ookie' WHERE `entry` = 62498; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_zipline_to_ship' WHERE `entry` = 62500; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_pirate' WHERE `entry` = 62506; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_pirate' WHERE `entry` = 62508; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_pirate' WHERE `entry` = 62590; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unstable_keg' WHERE `entry` = 62713; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_pirate' WHERE `entry` = 63256; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_banana_ship' WHERE `entry` = 64367; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_unga_pirate' WHERE `entry` = 67027; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_brew_container' WHERE `entry` = 212248; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_brew_container' WHERE `entry` = 212252; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_brew_container' WHERE `entry` = 212253; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_brew_container' WHERE `entry` = 212256; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_brew_container' WHERE `entry` = 215165; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 121878 AND `ScriptName` = 'spell_unga_jungle_brew_collected';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (121878, 'spell_unga_jungle_brew_collected');
DELETE FROM `spell_script_names` WHERE `spell_id` = 121906 AND `ScriptName` = 'spell_unga_mug_collected';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (121906, 'spell_unga_mug_collected');
DELETE FROM `spell_script_names` WHERE `spell_id` = 121911 AND `ScriptName` = 'spell_calling_birds';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (121911, 'spell_calling_birds');
DELETE FROM `spell_script_names` WHERE `spell_id` = 122436 AND `ScriptName` = 'spell_unga_popped_cork';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (122436, 'spell_unga_popped_cork');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130269 AND `ScriptName` = 'spell_unga_throw_keg';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130269, 'spell_unga_throw_keg');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130638 AND `ScriptName` = 'spell_unga_encumbered';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130638, 'spell_unga_encumbered');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8146 AND `ScriptName` = 'AreaTrigger_at_unga_ingoo_cauldron';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8146, 'AreaTrigger_at_unga_ingoo_cauldron');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 62465;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62465, 0, 0, 'YOU BETTER BE READY TO GET SOME OOK IN YER DOOKER!', 14, 0, 100, 0, 0, 0, ''),
(62465, 1, 0, 'Captain Ook is comin\' down with the scurvy! Keep the orange away from him!', 41, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62467;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62467, 0, 0, 'Ah! Good! You made it. It is time to teach these \"pirate\" hozen why they should not raid our villages.', 12, 0, 100, 0, 0, 0, ''),
(62467, 1, 0, 'The trick to dealing with pirate hozen is to have the element of surprise.', 12, 0, 100, 1, 0, 0, ''),
(62467, 2, 0, 'Watch out!', 12, 0, 100, 0, 0, 0, ''),
(62467, 3, 0, 'Okay... so... the new trick to dealing with pirate hozen is to do what you just did right there.', 12, 0, 100, 0, 0, 0, ''),
(62467, 4, 0, 'Birds too?! How\'d they even learn to tame the birds?!', 12, 0, 100, 0, 0, 0, ''),
(62467, 5, 0, 'Well look what we have here. Our first keg of recovered brew! I\'ll take this one, folks.', 12, 0, 100, 0, 0, 0, ''),
(62467, 6, 0, 'We\'d better keep moving before this whole island finds out we\'re here.', 12, 0, 100, 0, 0, 0, ''),
(62467, 7, 0, 'Hozen gladiators? Where did they get all of these weapons?', 12, 0, 100, 0, 0, 0, ''),
(62467, 8, 0, 'Well! This looks like as good a place to brew as any.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62468;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62468, 0, 0, 'You are what\'s on the menu!', 12, 0, 100, 0, 0, 0, ''),
(62468, 1, 0, 'You look a little pale!', 12, 0, 100, 0, 0, 0, ''),
(62468, 2, 0, 'Wikkets... gonna... pay.', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62491;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62491, 0, 0, 'This cauldron will be perfect for brewing our... brew.', 12, 0, 100, 1, 0, 0, ''),
(62491, 1, 0, 'Err... What was that?', 12, 0, 100, 5, 0, 0, ''),
(62491, 2, 0, 'Phew! That was close. Ok, here\'s the deal...', 12, 0, 100, 5, 0, 0, ''),
(62491, 3, 0, 'One of you, stay with me to keep the cauldron safe. The others, go find some Unga Jungle Brew and bring it back!', 12, 0, 100, 1, 0, 0, ''),
(62491, 4, 0, 'Search the island to collect brew for Bo\'s cauldron! But be sure to leave one person nearby to defend Bo!', 41, 0, 100, 1, 0, 0, ''),
(62491, 5, 0, 'You can use the bombs and cannons nearby to blast the hozen away!', 41, 0, 100, 5, 0, 0, ''),
(62491, 6, 0, 'We need more brew. I think I saw brew guzzling hozen on the mountain peak to the southeast.', 14, 0, 100, 0, 0, 0, ''),
(62491, 7, 0, 'DELICIOUS!', 12, 0, 100, 7, 0, 0, ''),
(62491, 8, 0, 'Oh... my. That brew is a bit stronger than I had expected... I...', 12, 0, 100, 64, 0, 0, ''),
(62491, 9, 0, 'Just need to rest my eyes a bit...', 12, 0, 100, 12, 0, 0, ''),
(62491, 10, 0, 'Search the island to collect brew for Bo\'s cauldron! But be sure to leave one person nearby to defend Bo!', 41, 0, 100, 1, 0, 0, ''),
(62491, 11, 0, 'You can use the bombs and cannons nearby to blast the hozen away!', 41, 0, 100, 5, 0, 0, ''),
(62491, 12, 0, 'A hozen bandit is stealing the brew! Stop him!', 41, 0, 100, 1, 0, 0, ''),
(62491, 13, 0, 'Hozen ships appear in the distance!', 41, 0, 100, 5, 0, 0, ''),
(62491, 14, 0, 'Captain Ook is comin\' down with the scurvy! Keep the orange away from him!', 41, 0, 100, 0, 0, 0, ''),
(62491, 15, 0, '$n has got the orange!', 41, 0, 100, 0, 0, 0, ''),
(62491, 16, 0, '$n tossed the orange!', 41, 0, 100, 0, 0, 0, ''),
(62491, 17, 0, 'You are carrying too much brew. Return to the Brewing Cauldron to turn in what you have.', 42, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62508;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62508, 0, 0, 'WIKKETS!!!', 14, 0, 100, 4, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62590;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62590, 0, 0, 'Brew run!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 63256;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(63256, 0, 0, 'Heyarrrrrrrr!', 12, 0, 100, 0, 0, 0, '');

-- NOTE: instance_template map 1048 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 41200; -- Generic Bunny - PRK
UPDATE `creature_template` SET `npcflag` = 16777216, `VehicleId` = 25 WHERE `entry` = 55370; -- General Purpose Bunny ZTO
UPDATE `creature_template` SET `npcflag` = 16777216, `unit_flags2` = 0, `flags_extra` = 128 WHERE `entry` = 62167; -- General Purpose Bunny ZTO
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14, `VehicleId` = 2239 WHERE `entry` = 62465; -- Captain Ook
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62466; -- Ba-Bam
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2263, `faction_H` = 2263, `unit_class` = 2, `VehicleId` = 2223 WHERE `entry` = 62467; -- Brewmaster Bo
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62468; -- Ookie
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `type` = 10 WHERE `entry` = 62469; -- Unga Totem
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_class` = 2, `VehicleId` = 25 WHERE `entry` = 62473; -- Mad Eye
UPDATE `creature_template` SET `faction_A` = 2502, `faction_H` = 2502 WHERE `entry` = 62474; -- Unga Spearscamp
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 62475; -- Unga Bird-Haver
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771, `InhabitType` = 4 WHERE `entry` = 62476; -- Trained Jungle Lory
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `VehicleId` = 2240, `InhabitType` = 4 WHERE `entry` = 62478; -- Trained Jibberwing
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_class` = 2, `VehicleId` = 2241 WHERE `entry` = 62482; -- Hozen Swing
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_class` = 2, `VehicleId` = 25 WHERE `entry` = 62483; -- Hozen Totem Fire Effect
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 62485; -- Gagoon
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 62486; -- Oku-Oku
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 2 WHERE `entry` = 62488; -- Grooka Grooka
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2263, `faction_H` = 2263, `unit_class` = 2, `VehicleId` = 2457 WHERE `entry` = 62491; -- Brewmaster Bo
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_class` = 2 WHERE `entry` = 62492; -- Unga Totemchipper
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62494; -- Unga Nibstabber
UPDATE `creature_template` SET `faction_A` = 2102, `faction_H` = 2102 WHERE `entry` = 62495; -- Unga Villager
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 62498; -- Chihozen Binono
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62499; -- Unga Beachbummer
UPDATE `creature_template` SET `VehicleId` = 2322, `InhabitType` = 4 WHERE `entry` = 62500; -- Zip Line
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_class` = 2, `VehicleId` = 2244 WHERE `entry` = 62502; -- Hozen Swing
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 62504; -- Ookie\'s Orange
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_flags` = 33554432, `VehicleId` = 2245 WHERE `entry` = 62506; -- Hozen Pirate Ship
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `VehicleId` = 2289 WHERE `entry` = 62508; -- Unga Brewstealer
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62535; -- Cove Shark
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `type` = 10 WHERE `entry` = 62557; -- Unga Totem
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 62569; -- Rik Rik
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62590; -- Unga Scallywag
UPDATE `creature_template` SET `VehicleId` = 2287 WHERE `entry` = 62705; -- Brew Defender
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63256; -- Unga Hozekateer
UPDATE `creature_template` SET `VehicleId` = 2396, `InhabitType` = 4 WHERE `entry` = 64367; -- Invisible Man
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64798; -- Amethyst Spiderling
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64799; -- Savory Beetle
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64800; -- Spiny Terrapin
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 66195; -- Unga Rocket Surgeon
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 66252; -- Unga Jungle Brew Keg
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `VehicleId` = 2482 WHERE `entry` = 66701; -- Brewmaster Boat
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `VehicleId` = 2289 WHERE `entry` = 67027; -- Jungle Brewstealer
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `VehicleId` = 2496 WHERE `entry` = 67028; -- Trained Jibberwing

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 41200;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (41200, 0, 0, 50331648, 1, 0, '51195');
DELETE FROM `creature_template_addon` WHERE `entry` = 55370;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (55370, 0, 0, 50331648, 1, 0, '115909');
DELETE FROM `creature_template_addon` WHERE `entry` = 62465;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62465, 0, 0, 0, 1, 0, '115762 115762');
DELETE FROM `creature_template_addon` WHERE `entry` = 62466;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62466, 0, 0, 0, 1, 0, '121933');
DELETE FROM `creature_template_addon` WHERE `entry` = 62467;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62467, 0, 0, 0, 1, 0, '130268');
DELETE FROM `creature_template_addon` WHERE `entry` = 62468;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62468, 0, 0, 0, 1, 0, '122478');
DELETE FROM `creature_template_addon` WHERE `entry` = 62473;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62473, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62478;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62478, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62482;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62482, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62483;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62483, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62488;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62488, 0, 0, 0, 1, 0, '121932');
DELETE FROM `creature_template_addon` WHERE `entry` = 62491;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62491, 0, 0, 0, 1, 0, '130268');
DELETE FROM `creature_template_addon` WHERE `entry` = 62498;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62498, 0, 0, 0, 1, 0, '121959');
DELETE FROM `creature_template_addon` WHERE `entry` = 62499;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62499, 0, 0, 0, 1, 0, '108848');
DELETE FROM `creature_template_addon` WHERE `entry` = 62502;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62502, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 62508;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62508, 0, 0, 0, 1, 0, '122361');
DELETE FROM `creature_template_addon` WHERE `entry` = 62569;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62569, 0, 0, 0, 1, 0, '115762');
DELETE FROM `creature_template_addon` WHERE `entry` = 62590;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62590, 0, 0, 0, 1, 0, '115762');
DELETE FROM `creature_template_addon` WHERE `entry` = 63256;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63256, 0, 0, 0, 1, 0, '115762');
DELETE FROM `creature_template_addon` WHERE `entry` = 66195;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (66195, 0, 0, 50331648, 1, 0, '130185 130177');
DELETE FROM `creature_template_addon` WHERE `entry` = 67028;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (67028, 0, 0, 50331648, 1, 0, '');

-- conditions

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 55370;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(55370, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 62167;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(62167, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 62705;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(62705, 46598, 1, 0);

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Keg', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 121907, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212248;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Keg', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 131760, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212252;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Mug', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 121906, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212253;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Mug', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 121906, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212254;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Mug', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 121906, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212255;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Mug', `data0` = 1690, `data3` = 3000, `data5` = 1, `data10` = 121906, `data14` = 19676, `data22` = 18821, `data23` = 1 WHERE `entry` = 212256;
UPDATE `gameobject_template` SET `type` = 6, `name` = 'Scurvy-Curing Orange', `data0` = 95, `data2` = 5, `data3` = 121905, `data4` = 1, `data10` = 1, `data11` = 1, `data14` = 1, `data16` = 1, `faction` = 14, `flags` = 32 WHERE `entry` = 212261;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Banana' WHERE `entry` = 212268;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Barrel' WHERE `entry` = 212269;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Zip Line', `data0` = 1691, `data3` = 3000, `data10` = 121956, `data14` = 61860, `data22` = 18683, `data23` = 1 WHERE `entry` = 212271;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 212274;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 212275;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 212276;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Bonfire', `data0` = 4, `data1` = 10, `data2` = 179900 WHERE `entry` = 212277;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Restorative Apple', `data3` = 3000, `data5` = 1, `data10` = 121947, `data23` = 1 WHERE `entry` = 212279;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Inactive Beach Bomb', `data0` = 1634, `data5` = 1, `data10` = 127235, `data14` = 27700, `data22` = 18683, `data23` = 1 WHERE `entry` = 212293;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Frenzy Fish' WHERE `entry` = 212508;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Fortifying Brew', `data3` = 3000, `data5` = 1, `data10` = 122498, `data23` = 1 WHERE `entry` = 212509;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Large Turnip', `data3` = 3000, `data5` = 1, `data10` = 122500, `data23` = 1 WHERE `entry` = 212510;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Energizing Carrot', `data3` = 3000, `data5` = 1, `data10` = 122501, `data23` = 1 WHERE `entry` = 212511;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Rocket Rice', `data3` = 3000, `data5` = 1, `data10` = 122502, `data23` = 1 WHERE `entry` = 212512;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Zipline to Ship', `data1` = 1 WHERE `entry` = 213185;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Bigga Unga Keg', `data3` = 3000, `data5` = 1, `data14` = 19676, `data23` = 1, `faction` = 1375 WHERE `entry` = 215165;
UPDATE `gameobject_template` SET `name` = 'Pirate Ship Door', `data2` = 3000, `faction` = 114 WHERE `entry` = 215400;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Unga Jungle Brew', `data0` = 43, `data3` = 3000, `data10` = 131819, `data14` = 37086, `data23` = 1, `faction` = 35 WHERE `entry` = 215853;

-- INFO gameobject entries LoA spawns on map 1048 and SkyFire does not: 212248 212252 212253 212254 212255 212256 212261 212268 212269 212271 212273 212274 212275 212276 212277 212279 212293 212508 212509 212510 212511 212512 213185 215165 215400 215853 215901

-- Unga Ingoo (1048): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9585000-9585166, gameobject 9585000-9585097. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9585000 AND 9585166;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9585000, 62465, 1048, 4096, 0, 0, 0, 0, -2645.39, 734.142, 13.1584, 3.44862, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544295
(9585001, 62467, 1048, 4096, 0, 0, 0, 0, -3086.78, 750.25, 1.36551, 4.03768, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544296
(9585002, 62492, 1048, 4096, 0, 0, 0, 0, -3018.81, 755.451, 22.9253, 0.248664, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544297
(9585003, 62478, 1048, 4096, 0, 0, 0, 0, -2808.84, 524.107, 22.1761, 4.97775, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544298
(9585004, 64798, 1048, 4096, 0, 0, 0, 0, -3009.4, 745.456, 23.1729, 2.04318, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544299
(9585005, 59481, 1048, 4096, 0, 0, 0, 0, -2938.56, 767.628, 9.52768, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544300
(9585006, 62535, 1048, 4096, 0, 0, 0, 0, -3146.59, 673.913, -12.9438, 3.10081, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544301
(9585007, 62494, 1048, 4096, 0, 0, 0, 0, -3019.23, 694.053, 38.236, 5.06099, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544302
(9585008, 62478, 1048, 4096, 0, 0, 0, 0, -2960.35, 956.127, 30.4298, 0.72524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544303
(9585009, 62494, 1048, 4096, 0, 0, 0, 0, -3020.37, 691.731, 38.4996, 6.25353, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544304
(9585010, 62494, 1048, 4096, 0, 0, 0, 0, -3015.55, 753.267, 22.9249, 0.914343, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544305
(9585011, 64798, 1048, 4096, 0, 0, 0, 0, -3006.13, 745.594, 23.4471, 3.84871, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544306
(9585012, 63256, 1048, 4096, 0, 0, 0, 0, -3014.25, 772.715, 22.8442, 5.14655, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544307
(9585013, 62485, 1048, 4096, 0, 0, 0, 0, -2941.49, 861.442, 1.19573, 4.63084, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544309
(9585014, 64798, 1048, 4096, 0, 0, 0, 0, -2994.73, 742.958, 22.5864, 1.55517, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544310
(9585015, 63256, 1048, 4096, 0, 0, 0, 0, -3005.89, 768.511, 20.8308, 2.80225, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544311
(9585016, 63256, 1048, 4096, 0, 0, 0, 0, -3003.14, 771.29, 19.7578, 5.93043, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544312
(9585017, 62482, 1048, 4096, 0, 0, 0, 0, -3021.75, 791.976, 43.6343, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544313
(9585018, 62494, 1048, 4096, 0, 0, 0, 0, -3015.61, 817.019, 28.7622, 5.61331, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544317
(9585019, 64367, 1048, 4096, 0, 0, 0, 0, -2673.74, 726.271, 2.47708, 2.99376, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544318
(9585020, 62492, 1048, 4096, 0, 0, 0, 0, -3010.8, 830.104, 30.3946, 4.7577, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544319
(9585021, 62478, 1048, 4096, 0, 0, 0, 0, -2861.98, 1051.85, 25.332, 4.94838, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544320
(9585022, 64799, 1048, 4096, 0, 0, 0, 0, -3006.97, 801.212, 26.0814, 3.91136, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544321
(9585023, 62478, 1048, 4096, 0, 0, 0, 0, -2781.54, 997.499, 33.7295, 5.88007, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544322
(9585024, 64798, 1048, 4096, 0, 0, 0, 0, -2979.16, 876.745, 7.47984, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544323
(9585025, 64798, 1048, 4096, 0, 0, 0, 0, -2976.83, 881.232, 7.29076, 4.24394, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544324
(9585026, 64798, 1048, 4096, 0, 0, 0, 0, -2979.75, 876.654, 7.33824, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544325
(9585027, 62475, 1048, 4096, 0, 0, 0, 0, -2995.47, 850.957, 16.585, 2.91236, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544326
(9585028, 41200, 1048, 4096, 0, 0, 0, 0, -2941.96, 855.922, 5.29446, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544327
(9585029, 62495, 1048, 4096, 0, 0, 0, 0, -2942.05, 871.531, 1.9987, 4.76214, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544328
(9585030, 62495, 1048, 4096, 0, 0, 0, 0, -2939.7, 879.549, 4.59709, 4.9574, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544329
(9585031, 62495, 1048, 4096, 0, 0, 0, 0, -2930.61, 855.292, 1.21658, 2.59867, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544330
(9585032, 62495, 1048, 4096, 0, 0, 0, 0, -2945.91, 877.793, 4.00251, 5.05754, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544331
(9585033, 62495, 1048, 4096, 0, 0, 0, 0, -2937.21, 838.575, 5.72566, 1.98582, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544332
(9585034, 62495, 1048, 4096, 0, 0, 0, 0, -2932.99, 840.779, 5.58102, 2.00585, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544333
(9585035, 62495, 1048, 4096, 0, 0, 0, 0, -2926.11, 846.76, 3.40265, 2.54022, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544334
(9585036, 62492, 1048, 4096, 0, 0, 0, 0, -2937.41, 921.08, 8.78866, 5.13077, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544335
(9585037, 64799, 1048, 4096, 0, 0, 0, 0, -2929.33, 883.101, 7.83523, 2.03164, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544336
(9585038, 62495, 1048, 4096, 0, 0, 0, 0, -2923.78, 864.859, 4.21959, 3.08825, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544337
(9585039, 62492, 1048, 4096, 0, 0, 0, 0, -2931.56, 917.628, 8.78866, 3.21694, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544338
(9585040, 62492, 1048, 4096, 0, 0, 0, 0, -2907.76, 825.6, 0.866556, 3.28871, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544339
(9585041, 62494, 1048, 4096, 0, 0, 0, 0, -2910.58, 820.226, 1.24947, 1.82671, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544340
(9585042, 64800, 1048, 4096, 0, 0, 0, 0, -2880.44, 833.697, 0.320452, 4.19942, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544341
(9585043, 64800, 1048, 4096, 0, 0, 0, 0, -2874.43, 834.271, 0.308989, 2.8092, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544342
(9585044, 64800, 1048, 4096, 0, 0, 0, 0, -2866.52, 841.911, 0.352155, 0.38422, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544343
(9585045, 62705, 1048, 4096, 0, 0, 0, 0, -2920.17, 753.689, 2.63982, 0.278311, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544344
(9585046, 62482, 1048, 4096, 0, 0, 0, 0, -2951.87, 727.648, 18.3149, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544345
(9585047, 62494, 1048, 4096, 0, 0, 0, 0, -2960.99, 709.571, 15.2661, 6.28048, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544346
(9585048, 64800, 1048, 4096, 0, 0, 0, 0, -2853.28, 734.504, 0.317023, 5.13499, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544347
(9585049, 64800, 1048, 4096, 0, 0, 0, 0, -2864.47, 730.613, 0.354596, 3.85509, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544348
(9585050, 62492, 1048, 4096, 0, 0, 0, 0, -2958.3, 705.411, 15.2907, 0.973741, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544351
(9585051, 64798, 1048, 4096, 0, 0, 0, 0, -2922.62, 670.905, 20.3679, 2.99058, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544353
(9585052, 64798, 1048, 4096, 0, 0, 0, 0, -2922.89, 670.183, 20.9756, 3.3501, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544354
(9585053, 62483, 1048, 4096, 0, 0, 0, 0, -2993.18, 673.76, 42.9974, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544355
(9585054, 64798, 1048, 4096, 0, 0, 0, 0, -2921.65, 669.587, 21.1981, 3.38646, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544356
(9585055, 62473, 1048, 4096, 0, 0, 0, 0, -2996.33, 676.583, 53.3825, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544357
(9585056, 62473, 1048, 4096, 0, 0, 0, 0, -2997.03, 674.779, 53.3294, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544358
(9585057, 62466, 1048, 4096, 0, 0, 0, 0, -3016.31, 943.257, 11.3965, 6.24613, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544359
(9585058, 62491, 1048, 4096, 0, 0, 0, 0, -2939.14, 767.198, 9.43278, 3.24446, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544360
(9585059, 62569, 1048, 4096, 0, 0, 0, 0, -2892.81, 511.385, 74.3083, 1.76263, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544361
(9585060, 62713, 1048, 4096, 0, 0, 0, 0, -2838.61, 500.585, 7.78741, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544363
(9585061, 62469, 1048, 4096, 0, 0, 0, 0, -2852.08, 500.538, 8.26124, 6.2719, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544364
(9585062, 55370, 1048, 4096, 0, 0, 0, 0, -2936.8, 767.262, 4.0206, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544366
(9585063, 62468, 1048, 4096, 0, 0, 0, 0, -2704.18, 948.304, 3.36775, 2.86366, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544367
(9585064, 62590, 1048, 4096, 0, 0, 0, 0, -2883.27, 769.882, 0.446181, 3.06939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544368
(9585065, 62590, 1048, 4096, 0, 0, 0, 0, -2880.25, 766.661, 0.251425, 3.06939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544369
(9585066, 62590, 1048, 4096, 0, 0, 0, 0, -2879.5, 763.16, 0.496459, 3.06939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544370
(9585067, 62590, 1048, 4096, 0, 0, 0, 0, -2883.73, 760.438, 0.954861, 3.06939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544371
(9585068, 62508, 1048, 4096, 0, 0, 0, 0, -2884.79, 764.641, 0.234375, 3.06939, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544372
(9585069, 66195, 1048, 4096, 0, 0, 0, 0, -2643.3, 728.427, 13.1719, 5.91235, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544378
(9585070, 62167, 1048, 4096, 0, 0, 0, 0, -3007.79, 681.365, 38.4705, 5.63399, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544379
(9585071, 66195, 1048, 4096, 0, 0, 0, 0, -2638.01, 726.914, 13.65, 6.02115, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544383
(9585072, 66701, 1048, 4096, 0, 0, 0, 0, -2599.85, 645.627, -0.169868, 2.575, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544391
(9585073, 66701, 1048, 4096, 0, 0, 0, 0, -2708.07, 582.4, -0.330279, 2.26317, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544392
(9585074, 66701, 1048, 4096, 0, 0, 0, 0, -2615.68, 638.364, -0.232221, 2.67856, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544393
(9585075, 62492, 1048, 4096, 0, 0, 0, 0, -3015.55, 753.267, 22.9249, 0.914343, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544394
(9585076, 62494, 1048, 4096, 0, 0, 0, 0, -3019.72, 705.733, 36.5177, 5.06107, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544395
(9585077, 62492, 1048, 4096, 0, 0, 0, 0, -3017.95, 702.045, 37.2536, 1.31492, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544397
(9585078, 62535, 1048, 4096, 0, 0, 0, 0, -3146, 662.938, -12.8672, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544398
(9585079, 62492, 1048, 4096, 0, 0, 0, 0, -3020.37, 691.731, 38.4996, 6.25353, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544399
(9585080, 62494, 1048, 4096, 0, 0, 0, 0, -3018.81, 755.451, 22.9253, 0.248664, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544400
(9585081, 62478, 1048, 4096, 0, 0, 0, 0, -3087.39, 751.111, 40.8216, 1.00868, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544401
(9585082, 64799, 1048, 4096, 0, 0, 0, 0, -3007.92, 742.309, 23.8941, 2.41853, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544402
(9585083, 64799, 1048, 4096, 0, 0, 0, 0, -3008.33, 742.68, 23.8438, 0.203777, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544403
(9585084, 64799, 1048, 4096, 0, 0, 0, 0, -3007.74, 742.771, 23.7371, 0.764049, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544404
(9585085, 63256, 1048, 4096, 0, 0, 0, 0, -3009.33, 793.119, 25.9491, 4.05658, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544405
(9585086, 63256, 1048, 4096, 0, 0, 0, 0, -3003.73, 788.807, 25.6583, 4.05659, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544407
(9585087, 62486, 1048, 4096, 0, 0, 0, 0, -2942.09, 854.172, 1.21646, 1.3462, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544408
(9585088, 63256, 1048, 4096, 0, 0, 0, 0, -3014.01, 781.254, 24.0597, 4.05218, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544409
(9585089, 64798, 1048, 4096, 0, 0, 0, 0, -3011.53, 807.926, 27.8619, 3.34723, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544414
(9585090, 64799, 1048, 4096, 0, 0, 0, 0, -2967.25, 870.08, 7.04697, 3.18063, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544415
(9585091, 64799, 1048, 4096, 0, 0, 0, 0, -2981.56, 871.068, 10.2194, 0.612646, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544416
(9585092, 64799, 1048, 4096, 0, 0, 0, 0, -2972.06, 866.398, 7.6296, 4.05717, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544417
(9585093, 64798, 1048, 4096, 0, 0, 0, 0, -2925.14, 878.747, 6.79001, 3.15946, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544422
(9585094, 62478, 1048, 4096, 0, 0, 0, 0, -2811.25, 1194.09, 25.1504, 3.5367, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544428
(9585095, 64800, 1048, 4096, 0, 0, 0, 0, -2867.29, 843.974, 0.385789, 1.92868, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544429
(9585096, 64799, 1048, 4096, 0, 0, 0, 0, -2882.06, 916.062, 8.41106, 5.0715, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544430
(9585097, 64800, 1048, 4096, 0, 0, 0, 0, -2881.19, 836.523, 0.479579, 2.13768, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544431
(9585098, 63256, 1048, 4096, 0, 0, 0, 0, -2879.24, 873.928, 3.12089, 1.52111, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544432
(9585099, 64799, 1048, 4096, 0, 0, 0, 0, -2881.72, 921.266, 9.39617, 1.61021, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544433
(9585100, 64799, 1048, 4096, 0, 0, 0, 0, -2881.72, 916.007, 8.35735, 5.4225, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544434
(9585101, 64800, 1048, 4096, 0, 0, 0, 0, -2872.83, 832.143, 0.293909, 3.78515, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544435
(9585102, 64798, 1048, 4096, 0, 0, 0, 0, -2927.53, 951.569, 14.703, 4.9813, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544436
(9585103, 62478, 1048, 4096, 0, 0, 0, 0, -2764.54, 1180.08, 29.7361, 3.18217, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544437
(9585104, 64800, 1048, 4096, 0, 0, 0, 0, -2862.17, 730.508, 0.346951, 5.58854, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544439
(9585105, 64800, 1048, 4096, 0, 0, 0, 0, -2853.14, 736.19, 0.277547, 1.24091, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544441
(9585106, 64798, 1048, 4096, 0, 0, 0, 0, -2922.93, 670.353, 20.907, 3.29261, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544442
(9585107, 64798, 1048, 4096, 0, 0, 0, 0, -2922.19, 669.098, 21.1982, 3.60824, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544443
(9585108, 64798, 1048, 4096, 0, 0, 0, 0, -2919.66, 671.497, 20.1809, 2.02835, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544444
(9585109, 62488, 1048, 4096, 0, 0, 0, 0, -2836.96, 501.064, 7.78188, 0.031689, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544446
(9585110, 62498, 1048, 4096, 0, 0, 0, 0, -2891.56, 497.54, 74.4419, 1.64595, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544447
(9585111, 62713, 1048, 4096, 0, 0, 0, 0, -2696.07, 937.127, 2.11458, 3.18171, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544449
(9585112, 62468, 1048, 4096, 0, 0, 0, 0, -3014.98, 939.779, 11.5484, 6.02507, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544450
(9585113, 62557, 1048, 4096, 0, 0, 0, 0, -2993.29, 673.92, 42.9564, 2.64942, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544452
(9585114, 62492, 1048, 4096, 0, 0, 0, 0, -2915.31, 637.389, 24.8829, 5.37727, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544453
(9585115, 62482, 1048, 4096, 0, 0, 0, 0, -2960.31, 624.413, 78.7996, 4.26026, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544458
(9585116, 64798, 1048, 4096, 0, 0, 0, 0, -2882.86, 626.018, 30.7264, 0.790526, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544461
(9585117, 62482, 1048, 4096, 0, 0, 0, 0, -2905.53, 556.717, 85.7416, 2.26239, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544462
(9585118, 64800, 1048, 4096, 0, 0, 0, 0, -2794.58, 639.701, 1.47844, 4.24747, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544463
(9585119, 64799, 1048, 4096, 0, 0, 0, 0, -2854.16, 561.61, 32.7916, 1.83568, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544464
(9585120, 64800, 1048, 4096, 0, 0, 0, 0, -2809.18, 621.74, 1.02135, 2.33986, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544465
(9585121, 64800, 1048, 4096, 0, 0, 0, 0, -2808.07, 621.193, 0.838381, 1.80784, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544466
(9585122, 64799, 1048, 4096, 0, 0, 0, 0, -2912.08, 563.714, 72.429, 5.96984, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544469
(9585123, 64799, 1048, 4096, 0, 0, 0, 0, -2911.63, 563.563, 72.3406, 6.04401, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544470
(9585124, 64799, 1048, 4096, 0, 0, 0, 0, -2911.53, 563.685, 72.3465, 5.92842, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544471
(9585125, 64799, 1048, 4096, 0, 0, 0, 0, -2982.2, 605.98, 69.2398, 3.41769, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544472
(9585126, 66195, 1048, 4096, 0, 0, 0, 0, -2636.66, 726.524, 13.7205, 6.01739, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544473
(9585127, 64800, 1048, 4096, 0, 0, 0, 0, -2821.54, 871.047, 0.360393, 1.19149, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544476
(9585128, 62499, 1048, 4096, 0, 0, 0, 0, -2807.73, 876.887, 0.277629, 0.16936, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544477
(9585129, 62499, 1048, 4096, 0, 0, 0, 0, -2805.08, 878.389, 0.277196, 3.57368, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544478
(9585130, 64800, 1048, 4096, 0, 0, 0, 0, -2816.92, 876.719, 0.354395, 5.11574, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544479
(9585131, 66195, 1048, 4096, 0, 0, 0, 0, -2642.63, 728.199, 13.2362, 5.97697, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544480
(9585132, 62499, 1048, 4096, 0, 0, 0, 0, -2795.06, 909.967, 1.15184, 5.75895, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544482
(9585133, 64800, 1048, 4096, 0, 0, 0, 0, -2824.4, 927.938, 2.22606, 1.64899, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544483
(9585134, 62499, 1048, 4096, 0, 0, 0, 0, -2797.82, 881.976, 0.246997, 4.86127, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544484
(9585135, 62499, 1048, 4096, 0, 0, 0, 0, -2795.61, 906.5, 1.08371, 0.0893022, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544485
(9585136, 62499, 1048, 4096, 0, 0, 0, 0, -2784.29, 897.217, 1.42726, 2.34397, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544486
(9585137, 62499, 1048, 4096, 0, 0, 0, 0, -2824.5, 954.75, 1.02219, 5.39546, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544487
(9585138, 62499, 1048, 4096, 0, 0, 0, 0, -2813.65, 952.375, 1.44728, 3.13481, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544488
(9585139, 62499, 1048, 4096, 0, 0, 0, 0, -2820.53, 948.846, 1.07273, 2.17755, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544489
(9585140, 62499, 1048, 4096, 0, 0, 0, 0, -2820.07, 961.653, 1.54761, 4.28364, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544490
(9585141, 62494, 1048, 4096, 0, 0, 0, 0, -2855.95, 981.359, 0.635174, 1.63096, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544491
(9585142, 62502, 1048, 4096, 0, 0, 0, 0, -2783.17, 922.488, 3.02411, 4.14944, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544492
(9585143, 62499, 1048, 4096, 0, 0, 0, 0, -2788.19, 921.002, 0.521119, 4.55334, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544493
(9585144, 62499, 1048, 4096, 0, 0, 0, 0, -2830.04, 961.729, 1.25739, 0.0982387, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544494
(9585145, 62492, 1048, 4096, 0, 0, 0, 0, -2860.55, 992.111, 1.12405, 1.41955, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544495
(9585146, 64799, 1048, 4096, 0, 0, 0, 0, -2902.87, 983.76, 13.8438, 4.99552, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544496
(9585147, 62502, 1048, 4096, 0, 0, 0, 0, -2814.15, 960.811, 2.37866, 3.51038, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544497
(9585148, 62494, 1048, 4096, 0, 0, 0, 0, -2862.82, 979.776, 1.13988, 1.62778, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544498
(9585149, 64800, 1048, 4096, 0, 0, 0, 0, -2853.88, 971.069, 0.835055, 0.598566, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544499
(9585150, 64800, 1048, 4096, 0, 0, 0, 0, -2854.62, 985.816, 0.552154, 3.89314, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544500
(9585151, 62504, 1048, 4096, 0, 0, 0, 0, -3000.17, 932.446, 11.2946, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544504
(9585152, 62504, 1048, 4096, 0, 0, 0, 0, -3010.58, 931.441, 12.3114, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544505
(9585153, 62504, 1048, 4096, 0, 0, 0, 0, -2999.91, 939.549, 12.7828, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544506
(9585154, 62504, 1048, 4096, 0, 0, 0, 0, -2991.99, 923.976, -0.112221, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544507
(9585155, 55370, 1048, 4096, 0, 0, 0, 0, -2994.78, 953.695, 11.2196, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544508
(9585156, 62492, 1048, 4096, 0, 0, 0, 0, -2991.35, 953.253, -1.48711, 0.973741, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544509
(9585157, 62504, 1048, 4096, 0, 0, 0, 0, -2988.26, 953.63, 12.34, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544510
(9585158, 62492, 1048, 4096, 0, 0, 0, 0, -2990.79, 956.349, -1.48712, 6.28048, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544511
(9585159, 62504, 1048, 4096, 0, 0, 0, 0, -3003.8, 945.512, 11.3254, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544512
(9585160, 62504, 1048, 4096, 0, 0, 0, 0, -3002.3, 960.26, 12.6276, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544513
(9585161, 62504, 1048, 4096, 0, 0, 0, 0, -2993.75, 955.41, 12.8406, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544514
(9585162, 62504, 1048, 4096, 0, 0, 0, 0, -3015.09, 941.45, 11.4614, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544518
(9585163, 66195, 1048, 4096, 0, 0, 0, 0, -2640.51, 727.58, 13.4162, 6.00988, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544519
(9585164, 66701, 1048, 4096, 0, 0, 0, 0, -2604.34, 648.482, -0.169868, 2.57459, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544521
(9585165, 66701, 1048, 4096, 0, 0, 0, 0, -2619.94, 640.478, -0.232221, 2.6828, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544522
(9585166, 66701, 1048, 4096, 0, 0, 0, 0, -2711.08, 586.388, -0.330279, 2.16491, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA 544523

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9585000 AND 9585097;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9585000, 212248, 1048, 4096, 0, 0, -2918.89, 546.403, 83.2342, 2.76341, 0, 0, -0.982175, -0.187969, 7200, 0, 1), -- LoA 30034
(9585001, 212252, 1048, 4096, 0, 0, -2897.67, 550.96, 73.2438, 5.20589, 0, 0, -0.512978, 0.858402, 7200, 0, 1), -- LoA 30056
(9585002, 212248, 1048, 4096, 0, 0, -3019.4, 823.731, 29.2362, 4.78646, 0, 0, -0.680441, 0.732803, 7200, 0, 1), -- LoA 30057
(9585003, 212252, 1048, 4096, 0, 0, -2937.62, 927.964, 8.88492, 4.72757, 0, 0, -0.70172, 0.712453, 7200, 0, 1), -- LoA 30058
(9585004, 212252, 1048, 4096, 0, 0, -2943.92, 650.163, 23.9566, 0.203673, 0, 0, -0.101661, -0.994819, 7200, 0, 1), -- LoA 30059
(9585005, 212248, 1048, 4096, 0, 0, -2884.74, 484.252, 74.5861, 1.68022, 0, 0, -0.744715, -0.667383, 7200, 0, 1), -- LoA 30060
(9585006, 212252, 1048, 4096, 0, 0, -2775.06, 909.587, 0.20505, 2.9948, 0, 0, -0.997308, -0.0733292, 7200, 0, 1), -- LoA 30061
(9585007, 212252, 1048, 4096, 0, 0, -2816.42, 959.456, 0.429228, 3.85481, 0, 0, -0.937085, 0.349101, 7200, 0, 1), -- LoA 30062
(9585008, 212276, 1048, 4096, 0, 0, -2997.56, 794.229, 26.0239, 1.65806, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535718
(9585009, 213185, 1048, 4096, 0, 0, -2954.23, 799.738, 6.9533, 0.0932762, -0.1553, -0.0639, 0.0368, 0.9851, 7200, 255, 1), -- LoA 535719
(9585010, 212271, 1048, 4096, 0, 0, -2955.32, 800.368, 33.905, 6.09993, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535720
(9585011, 212274, 1048, 4096, 0, 0, -2934.97, 917.415, 8.72431, 4.35338, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535721
(9585012, 215165, 1048, 4096, 0, 0, -2997.63, 850.256, 16.5289, 2.89541, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535722
(9585013, 212275, 1048, 4096, 0, 0, -2954.72, 709.814, 14.7356, 1.65806, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535723
(9585014, 212255, 1048, 4096, 0, 0, -2923.9, 851.505, 3.94038, 0.607704, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535724
(9585015, 212293, 1048, 4096, 0, 0, -2927.97, 781.361, 3.05119, 4.85644, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535725
(9585016, 212293, 1048, 4096, 0, 0, -2943.64, 752.507, 4.99361, 6.27228, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535726
(9585017, 212293, 1048, 4096, 0, 0, -2929.06, 782.695, 3.12607, 0.00756647, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535727
(9585018, 212293, 1048, 4096, 0, 0, -2941.31, 751.422, 4.73993, 4.82914, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535728
(9585019, 212293, 1048, 4096, 0, 0, -2939.25, 749.846, 4.58879, 6.1343, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535729
(9585020, 212293, 1048, 4096, 0, 0, -2925.8, 780.656, 2.89341, 6.1343, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535730
(9585021, 212252, 1048, 4096, 0, 0, -3021.75, 752.085, 22.8451, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535731
(9585022, 212253, 1048, 4096, 0, 0, -3012.15, 828.866, 30.342, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535732
(9585023, 212256, 1048, 4096, 0, 0, -2930.83, 841.884, 5.26372, 0.357577, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535733
(9585024, 212253, 1048, 4096, 0, 0, -3028.24, 760.766, 22.8818, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535734
(9585025, 212255, 1048, 4096, 0, 0, -2955.92, 708.195, 14.9417, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535735
(9585026, 212254, 1048, 4096, 0, 0, -2940.56, 659.738, 25.7117, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535736
(9585027, 212256, 1048, 4096, 0, 0, -3018.28, 691.663, 38.4184, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535737
(9585028, 212254, 1048, 4096, 0, 0, -2939.99, 659.455, 25.7213, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535738
(9585029, 212252, 1048, 4096, 0, 0, -3016.65, 687.951, 38.723, 3.71121, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535739
(9585030, 212253, 1048, 4096, 0, 0, -2884.44, 646.247, 19.175, 2.20896, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535740
(9585031, 212252, 1048, 4096, 0, 0, -2964.94, 705.83, 15.2717, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535741
(9585032, 212253, 1048, 4096, 0, 0, -2995.35, 671.993, 42.8876, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535742
(9585033, 212253, 1048, 4096, 0, 0, -2928.26, 900.401, 8.37989, 0.412046, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535746
(9585034, 212254, 1048, 4096, 0, 0, -2922.71, 909.509, 8.16855, 1.50669, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535747
(9585035, 212255, 1048, 4096, 0, 0, -2881.16, 921.816, 9.36059, 5.32037, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535748
(9585036, 212256, 1048, 4096, 0, 0, -2944.07, 924.009, 8.75888, 2.0787, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535749
(9585037, 212255, 1048, 4096, 0, 0, -2790.39, 904.46, 0.558175, 3.56102, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535750
(9585038, 212277, 1048, 4096, 0, 0, -2790.66, 907.802, 0.626736, 3.17653, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535751
(9585039, 212256, 1048, 4096, 0, 0, -2820.13, 966.59, 1.55306, 4.16398, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535752
(9585040, 212253, 1048, 4096, 0, 0, -2818.35, 961.012, 1.02486, 4.16398, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535753
(9585041, 212256, 1048, 4096, 0, 0, -2781.87, 897.509, 0.936307, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535754
(9585042, 212256, 1048, 4096, 0, 0, -2817.47, 961.589, 0.954377, 0.137542, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535755
(9585043, 212256, 1048, 4096, 0, 0, -2789.38, 912.227, 0.596301, 3.56102, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535756
(9585044, 212254, 1048, 4096, 0, 0, -2786.8, 924.71, 1.65483, 2.27225, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535757
(9585045, 212253, 1048, 4096, 0, 0, -2791.66, 926.529, 1.79595, 2.86301, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535758
(9585046, 212256, 1048, 4096, 0, 0, -2821.1, 964.554, 0.526825, 5.50336, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535759
(9585047, 212256, 1048, 4096, 0, 0, -2939.21, 839.344, 5.77031, 5.32037, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535760
(9585048, 212252, 1048, 4096, 0, 0, -2986.28, 952.193, 10.9396, 3.71121, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535761
(9585049, 212279, 1048, 4096, 0, 0, -2993.76, 952.514, 11.0848, 6.23893, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535762
(9585050, 212512, 1048, 4096, 0, 0, -2992.7, 953.3, 11.0686, 0.792905, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535763
(9585051, 212254, 1048, 4096, 0, 0, -2990.08, 950.616, 5.75152, 3.86638, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535764
(9585052, 212279, 1048, 4096, 0, 0, -3014.31, 933.154, 13.8941, 1.51412, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535765
(9585053, 212253, 1048, 4096, 0, 0, -2973.13, 975.148, 6.44887, 0.763944, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535766
(9585054, 212269, 1048, 4096, 0, 0, -2999.75, 939.576, 11.0787, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535767
(9585055, 212269, 1048, 4096, 0, 0, -2991.97, 954.111, 11.0617, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535768
(9585056, 212256, 1048, 4096, 0, 0, -3007.77, 952.014, 5.75222, 4.61709, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535769
(9585057, 212511, 1048, 4096, 0, 0, -2994.67, 956.122, 11.1379, 4.44382, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535770
(9585058, 212255, 1048, 4096, 0, 0, -3012.49, 940.472, -1.56407, 5.81633, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535771
(9585059, 212268, 1048, 4096, 0, 0, -2999.13, 956.542, 11.9133, 6.15543, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535772
(9585060, 212510, 1048, 4096, 0, 0, -2981.7, 971.594, 17.0853, 1.33964, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535773
(9585061, 212279, 1048, 4096, 0, 0, -2997.19, 964.865, 13.0066, 1.48234, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535774
(9585062, 212248, 1048, 4096, 0, 0, -2991.29, 862.988, 15.8175, 5.55158, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535775
(9585063, 212269, 1048, 4096, 0, 0, -2993.8, 955.17, 11.1359, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535776
(9585064, 212255, 1048, 4096, 0, 0, -3000.91, 937.84, 5.75209, 3.30151, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535777
(9585065, 212279, 1048, 4096, 0, 0, -2980.34, 969.748, 17.0927, 1.48234, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535778
(9585066, 212253, 1048, 4096, 0, 0, -2978, 969.983, 17.9412, 0.763944, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535779
(9585067, 212253, 1048, 4096, 0, 0, -2990.84, 958.427, -1.5861, 5.81633, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535780
(9585068, 212279, 1048, 4096, 0, 0, -2998.4, 941.542, 11.0522, 1.48234, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535781
(9585069, 212268, 1048, 4096, 0, 0, -3002.11, 937.177, 11.7452, 0.0596707, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535782
(9585070, 215400, 1048, 4096, 0, 0, -2993.23, 964.054, 10.9123, 0.762758, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535783
(9585071, 212256, 1048, 4096, 0, 0, -3003.22, 956.88, 5.75152, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535784
(9585072, 212253, 1048, 4096, 0, 0, -2996.19, 860.229, 15.9309, 3.86638, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535785
(9585073, 212509, 1048, 4096, 0, 0, -2993.3, 953.971, 11.1006, 0.330902, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535786
(9585074, 212268, 1048, 4096, 0, 0, -2993.11, 946.861, 11.7925, 2.15995, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535787
(9585075, 212511, 1048, 4096, 0, 0, -3011.08, 931.797, 12.5303, 2.03302, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535788
(9585076, 212508, 1048, 4096, 0, 0, -3010.96, 933.835, 11.5194, 4.58102, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535789
(9585077, 212512, 1048, 4096, 0, 0, -3014.06, 935.92, 11.6181, 0.792905, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535790
(9585078, 212279, 1048, 4096, 0, 0, -2977.06, 969.953, 17.9414, 2.75083, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535791
(9585079, 212508, 1048, 4096, 0, 0, -2994.13, 946.79, 10.9878, 1.26039, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535792
(9585080, 212279, 1048, 4096, 0, 0, -3018.09, 943.792, 11.3187, 6.19142, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535799
(9585081, 212269, 1048, 4096, 0, 0, -3018.67, 940.12, 11.497, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535800
(9585082, 212510, 1048, 4096, 0, 0, -3018.32, 937.014, 11.5571, 4.23681, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535801
(9585083, 212511, 1048, 4096, 0, 0, -3018.64, 939.84, 13.2809, 1.09947, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535802
(9585084, 212273, 1048, 4096, 0, 0, -3005.07, 940.187, 11.235, 0.607447, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535803
(9585085, 212261, 1048, 4096, 0, 0, -2914.39, 790.91, 1.94234, 6.22425, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535810
(9585086, 215853, 1048, 4096, 0, 0, -2927.62, 765.748, 3.36218, 6.15801, 0, 0, 0, 1, -86400, 255, 1), -- LoA 535811
(9585087, 212253, 1048, 4096, 0, 0, -2930.83, 841.884, 5.26372, 0.357577, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535819
(9585088, 212256, 1048, 4096, 0, 0, -2923.9, 851.505, 3.94038, 0.607704, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535825
(9585089, 212255, 1048, 4096, 0, 0, -2939.21, 839.344, 5.77031, 5.32037, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535826
(9585090, 212253, 1048, 4096, 0, 0, -2948.96, 837.186, 3.89521, 0.763944, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535827
(9585091, 212256, 1048, 4096, 0, 0, -3028.24, 760.766, 22.8818, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535828
(9585092, 212253, 1048, 4096, 0, 0, -2952.3, 841.165, 3.74592, 0.763944, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535830
(9585093, 212256, 1048, 4096, 0, 0, -2941.02, 660.917, 25.7159, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535831
(9585094, 212248, 1048, 4096, 0, 0, -2932.33, 863.79, 1.13315, 3.26169, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535832
(9585095, 212254, 1048, 4096, 0, 0, -2958.09, 871.762, 7.00214, 0.763944, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535833
(9585096, 215901, 1048, 4096, 0, 0, -2923.47, 764.378, 2.98913, 3.40446, 0, 0, 0, 1, -86400, 255, 1), -- LoA 535838
(9585097, 215901, 1048, 4096, 0, 0, -2923.89, 765.154, 3.03918, 3.84975, 0, 0, 0, 1, -86400, 255, 1); -- LoA 535839

-- Crypt of Forgotten Kings (map 1030): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1030;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1030, 870, 'instance_crypt_of_forgotten_kings', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_crypt_guardian_vault' WHERE `entry` = 61418; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_seething_sha' WHERE `entry` = 61610; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_abomination_of_anger' WHERE `entry` = 61707; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_sha_base' WHERE `entry` = 61709; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_crypt_guardian_vault' WHERE `entry` = 61766; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_crypt_guardian_hall' WHERE `entry` = 61783; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_jin_ironfist' WHERE `entry` = 61814; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_pool_of_life' WHERE `entry` = 61885; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_shadows_of_anger' WHERE `entry` = 62009; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_shado_pan_initiate' WHERE `entry` = 65225; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_seething_sha' WHERE `entry` = 65304; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_sha_base' WHERE `entry` = 65581; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_lightning_trap' WHERE `entry` = 65590; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cfk_sha_spirit' WHERE `entry` = 65607; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_cfk_treasure_urn' WHERE `entry` = 213290; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 120349 AND `ScriptName` = 'spell_cfk_trigger_fire_trap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (120349, 'spell_cfk_trigger_fire_trap');
DELETE FROM `spell_script_names` WHERE `spell_id` = 120742 AND `ScriptName` = 'spell_cfk_anger_eff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (120742, 'spell_cfk_anger_eff');
DELETE FROM `spell_script_names` WHERE `spell_id` = 120744 AND `ScriptName` = 'spell_cfk_hate_periodic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (120744, 'spell_cfk_hate_periodic');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123800 AND `ScriptName` = 'spell_cfk_trigger_lightning_trap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123800, 'spell_cfk_trigger_lightning_trap');
DELETE FROM `spell_script_names` WHERE `spell_id` = 128681 AND `ScriptName` = 'spell_cfk_shadow_step';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (128681, 'spell_cfk_shadow_step');
DELETE FROM `spell_script_names` WHERE `spell_id` = 131641 AND `ScriptName` = 'spell_cfk_sha_rain';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (131641, 'spell_cfk_sha_rain');
DELETE FROM `spell_script_names` WHERE `spell_id` = 143316 AND `ScriptName` = 'spell_achiev_fight_with_anger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (143316, 'spell_achiev_fight_with_anger');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7908 AND `ScriptName` = 'AreaTrigger_at_crypt_steam_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7908, 'AreaTrigger_at_crypt_steam_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7909 AND `ScriptName` = 'AreaTrigger_at_crypt_steam_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7909, 'AreaTrigger_at_crypt_steam_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7916 AND `ScriptName` = 'AreaTrigger_at_crypt_steam_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7916, 'AreaTrigger_at_crypt_steam_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7921 AND `ScriptName` = 'AreaTrigger_at_crypt_steam_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7921, 'AreaTrigger_at_crypt_steam_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7923 AND `ScriptName` = 'AreaTrigger_at_crypt_steam_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7923, 'AreaTrigger_at_crypt_steam_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7986 AND `ScriptName` = 'AreaTrigger_at_crypt_quilen_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7986, 'AreaTrigger_at_crypt_quilen_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7987 AND `ScriptName` = 'AreaTrigger_at_crypt_quilen_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7987, 'AreaTrigger_at_crypt_quilen_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7988 AND `ScriptName` = 'AreaTrigger_at_crypt_quilen_trap';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7988, 'AreaTrigger_at_crypt_quilen_trap');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8340 AND `ScriptName` = 'AreaTrigger_at_crypt_behind_abomination';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8340, 'AreaTrigger_at_crypt_behind_abomination');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 61707;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61707, 0, 0, 'You will soon join the corpses buried here, little $c!', 14, 0, 100, 0, 0, 0, 'abomination - intro'),
(61707, 1, 0, '|TInterface\\Icons\\sha_ability_rogue_envelopingshadows.blp:20|t%s is unleashing |cFFFF0000|Hspell:120215|h[Deathforce]|h|r! RUN AWAY!', 41, 0, 100, 0, 0, 0, 'abomination - announce');
DELETE FROM `creature_text` WHERE `entry` = 61766;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61766, 0, 0, 'Intruders in the crypt!  Don\'t let them leave alive!', 14, 0, 100, 0, 0, 0, 'vault guardian - intro');
DELETE FROM `creature_text` WHERE `entry` = 61783;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61783, 0, 0, 'Who dares disturb this crypt?', 14, 0, 100, 0, 0, 0, 'hall guardian - combat');
DELETE FROM `creature_text` WHERE `entry` = 61814;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61814, 0, 0, 'Good!  These pathetic initiates were boring me!', 14, 0, 100, 0, 0, 0, 'ironfist - past intro');
DELETE FROM `creature_text` WHERE `entry` = 65590;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(65590, 0, 0, '$n stepped on a lightning trap!', 41, 0, 100, 0, 0, 0, 'step on lightning trap');

-- NOTE: instance_template map 1030 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` = 2110; -- Black Rat
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61418; -- Crypt Guardian
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 33685506 WHERE `entry` = 61565; -- Quilen Statue
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61610; -- Seething Sha
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61707; -- Abomination of Anger
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61709; -- Spawn of Anger
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 61766; -- Crypt Guardian
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 61783; -- Crypt Guardian
UPDATE `creature_template` SET `faction_A` = 2482, `faction_H` = 2482 WHERE `entry` = 61791; -- Novice Snow
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 61814; -- Jin Ironfist
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 131072 WHERE `entry` = 62009; -- Shadows of Anger
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 62055; -- Cloud of Anger
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 188, `faction_H` = 188 WHERE `entry` = 62230; -- Crypt Scarab
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 62254; -- Quilen Watcher
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 65304; -- Hateful Monstrosity
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 65556; -- Spawn of Anger
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 65581; -- Essence of Hate
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 634, `faction_H` = 634, `unit_flags` = 33685504 WHERE `entry` = 65590; -- Lightning Trap
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_flags` = 33554432, `dmg_multiplier` = 0.2 WHERE `entry` = 65607; -- Sha Spirit
UPDATE `creature_template` SET `faction_A` = 2482, `faction_H` = 2482 WHERE `entry` = 66378; -- Wounded Shado-Pan

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 61565;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61565, 0, 0, 0, 1, 0, '117838 119881');
DELETE FROM `creature_template_addon` WHERE `entry` = 61766;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61766, 0, 0, 0, 1, 0, '18950');
DELETE FROM `creature_template_addon` WHERE `entry` = 61783;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61783, 0, 0, 0, 1, 0, '18950');
DELETE FROM `creature_template_addon` WHERE `entry` = 61804;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61804, 0, 0, 262144, 1, 0, '35356');
DELETE FROM `creature_template_addon` WHERE `entry` = 61814;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61814, 0, 0, 0, 1, 0, '120398');
DELETE FROM `creature_template_addon` WHERE `entry` = 62009;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62009, 0, 0, 50331648, 1, 0, '120698');
DELETE FROM `creature_template_addon` WHERE `entry` = 62015;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62015, 0, 0, 0, 1, 0, '120686');
DELETE FROM `creature_template_addon` WHERE `entry` = 62055;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62055, 0, 0, 0, 1, 0, '120743 120744');
DELETE FROM `creature_template_addon` WHERE `entry` = 63873;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63873, 0, 0, 0, 1, 0, '116673');
DELETE FROM `creature_template_addon` WHERE `entry` = 65607;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (65607, 0, 0, 0, 1, 0, '128980');
DELETE FROM `creature_template_addon` WHERE `entry` = 66378;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (66378, 0, 0, 3, 1, 0, NULL);

-- conditions

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Stasis Trap' WHERE `entry` = 211709;
UPDATE `gameobject_template` SET `name` = 'Fire Trap' WHERE `entry` = 211841;
UPDATE `gameobject_template` SET `name` = 'Lightning Trap' WHERE `entry` = 211842;
UPDATE `gameobject_template` SET `name` = 'Stasis Trap' WHERE `entry` = 211843;
UPDATE `gameobject_template` SET `name` = 'Activation Trap' WHERE `entry` = 211995;
UPDATE `gameobject_template` SET `name` = 'Golden Doors', `flags` = 32 WHERE `entry` = 212637;
UPDATE `gameobject_template` SET `name` = 'Golden Doors', `flags` = 32 WHERE `entry` = 212638;
UPDATE `gameobject_template` SET `name` = 'Golden Doors', `flags` = 36 WHERE `entry` = 212639;
UPDATE `gameobject_template` SET `name` = 'Golden Doors', `flags` = 32 WHERE `entry` = 212640;
UPDATE `gameobject_template` SET `name` = 'Sha Corruption', `flags` = 32 WHERE `entry` = 214643;

-- INFO gameobject entries LoA spawns on map 1030 and SkyFire does not: 211623 211707 211709 211712 211841 211842 211843 211995 212637 212638 212639 212640 213251 213290 214643 215128

-- Crypt of Forgotten Kings (1030): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9587000-9587194, gameobject 9587000-9587038. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9587000 AND 9587194;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9587000, 61565, 1030, 6144, 0, 0, 0, 0, 615.597, 2358.5, 82.573, 0.00534725, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 541484
(9587001, 61565, 1030, 6144, 0, 0, 0, 0, 615.293, 2348.82, 82.573, 6.25712, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 541493
(9587002, 65225, 1030, 6144, 0, 0, 0, 0, 789.968, 2485.61, 82.5724, 6.26382, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 541496
(9587003, 65225, 1030, 6144, 0, 0, 0, 0, 805.039, 2482.69, 82.5724, 2.73031, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 541716
(9587004, 61885, 1030, 6144, 0, 0, 0, 0, 699.95, 2467.16, 73.9, 6.11, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543944
(9587005, 61709, 1030, 6144, 0, 0, 0, 0, 787.919, 2398.14, 52.7219, 2.36522, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543946
(9587006, 61709, 1030, 6144, 0, 0, 0, 0, 783.906, 2391.48, 52.7219, 0.886797, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543947
(9587007, 61804, 1030, 6144, 0, 0, 0, 0, 797.939, 2389.08, 82.3482, 0.861994, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543949
(9587008, 62230, 1030, 6144, 0, 0, 0, 0, 800.813, 2332.1, 52.7219, 6.27595, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543950
(9587009, 61418, 1030, 6144, 0, 0, 0, 0, 675.115, 2353.75, 82.5722, 3.14504, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 543951
(9587010, 62230, 1030, 6144, 0, 0, 0, 0, 821.7, 2438.04, 82.5722, 4.82694, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543952
(9587011, 62230, 1030, 6144, 0, 0, 0, 0, 799.669, 2306.25, 82.5722, 1.49309, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543953
(9587012, 62230, 1030, 6144, 0, 0, 0, 0, 797.476, 2345.36, 52.7219, 5.33125, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543954
(9587013, 61804, 1030, 6144, 0, 0, 0, 0, 807.764, 2395.28, 82.3482, 2.37436, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543957
(9587014, 62230, 1030, 6144, 0, 0, 0, 0, 764.213, 2302.39, 52.7219, 1.7691, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543958
(9587015, 61709, 1030, 6144, 0, 0, 0, 0, 752.05, 2463.98, 82.5722, 2.51874, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543959
(9587016, 71490, 1030, 6144, 0, 0, 0, 0, 796.137, 2479.67, 82.4625, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543960
(9587017, 61804, 1030, 6144, 0, 0, 0, 0, 795.87, 2501.56, 88.6458, 0.861994, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543961
(9587018, 62230, 1030, 6144, 0, 0, 0, 0, 772.006, 2478.8, 82.5722, 0.141023, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543962
(9587019, 61804, 1030, 6144, 0, 0, 0, 0, 813.762, 2470.62, 82.6555, 0.391476, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543963
(9587020, 2110, 1030, 6144, 0, 0, 0, 0, 809.009, 2487.84, 82.5722, 3.95524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543964
(9587021, 61804, 1030, 6144, 0, 0, 0, 0, 781.399, 2473.47, 82.6555, 5.00256, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543965
(9587022, 62230, 1030, 6144, 0, 0, 0, 0, 727.679, 2399.29, 45.0336, 1.63494, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543966
(9587023, 71490, 1030, 6144, 0, 0, 0, 0, 778.073, 2479.59, 82.4625, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543967
(9587024, 61709, 1030, 6144, 0, 0, 0, 0, 723.244, 2377.93, 45.0336, 0.166506, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543968
(9587025, 62230, 1030, 6144, 0, 0, 0, 0, 719.496, 2393.58, 45.0336, 4.81165, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543969
(9587026, 62230, 1030, 6144, 0, 0, 0, 0, 718.454, 2399.99, 45.0336, 2.1607, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543970
(9587027, 61709, 1030, 6144, 0, 0, 0, 0, 771.219, 2468.14, 82.5722, 3.47198, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543971
(9587028, 61709, 1030, 6144, 0, 0, 0, 0, 805.541, 2484.72, 82.5722, 1.41034, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543972
(9587029, 61709, 1030, 6144, 0, 0, 0, 0, 717.648, 2381.03, 45.0336, 0.565822, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 543973
(9587030, 62230, 1030, 6144, 0, 0, 0, 0, 729.995, 2387.63, 45.0336, 4.52035, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543974
(9587031, 62230, 1030, 6144, 0, 0, 0, 0, 814.529, 2505.07, 85.1673, 1.14648, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543975
(9587032, 62009, 1030, 6144, 0, 0, 0, 0, 720.488, 2381.84, 45.1169, 3.92623, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543976
(9587033, 61804, 1030, 6144, 0, 0, 0, 0, 698.611, 2452.3, 75.4404, 0.861994, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543983
(9587034, 65581, 1030, 6144, 0, 0, 0, 0, 700.69, 2453.93, 75.357, 3.51835, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 543984
(9587035, 65581, 1030, 6144, 0, 0, 0, 0, 696.48, 2459.88, 74.6045, 2.96451, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 543986
(9587036, 62230, 1030, 6144, 0, 0, 0, 0, 772.821, 2375.87, 82.5722, 2.87944, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 543991
(9587037, 65581, 1030, 6144, 0, 0, 0, 0, 698.771, 2463.01, 73.9007, 3.92212, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 543993
(9587038, 61709, 1030, 6144, 0, 0, 0, 0, 728.141, 2381.22, 45.0336, 4.65653, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544004
(9587039, 61709, 1030, 6144, 0, 0, 0, 0, 719.299, 2386.3, 45.0336, 0.309491, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544005
(9587040, 62230, 1030, 6144, 0, 0, 0, 0, 702.335, 2377.07, 82.5722, 0.907652, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544011
(9587041, 61766, 1030, 6144, 0, 0, 0, 0, 802.269, 2404.9, 82.6281, 1.57707, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544025
(9587042, 61709, 1030, 6144, 0, 0, 0, 0, 786.144, 2396.39, 52.7219, 0.283801, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544031
(9587043, 61709, 1030, 6144, 0, 0, 0, 0, 788.147, 2385.41, 52.7219, 5.3426, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544032
(9587044, 62230, 1030, 6144, 0, 0, 0, 0, 821.503, 2396.47, 82.2648, 2.4683, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544033
(9587045, 61709, 1030, 6144, 0, 0, 0, 0, 819.2, 2358.14, 82.2648, 3.35995, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544034
(9587046, 61709, 1030, 6144, 0, 0, 0, 0, 818.501, 2356.97, 82.2648, 0.678308, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544035
(9587047, 61709, 1030, 6144, 0, 0, 0, 0, 820.49, 2360.68, 82.2648, 3.63312, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544036
(9587048, 61709, 1030, 6144, 0, 0, 0, 0, 820.341, 2355.75, 82.2648, 5.78433, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544038
(9587049, 71489, 1030, 6144, 0, 0, 0, 0, 825.269, 2317.55, 82.069, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544039
(9587050, 62230, 1030, 6144, 0, 0, 0, 0, 850.108, 2362.1, 82.5229, 5.53691, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544040
(9587051, 71489, 1030, 6144, 0, 0, 0, 0, 718.229, 2360.52, 82.3661, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544041
(9587052, 65590, 1030, 6144, 0, 0, 0, 0, 743.003, 2347.53, 82.3747, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544043
(9587053, 62230, 1030, 6144, 0, 0, 0, 0, 760.5, 2348.25, 82.5722, 4.64245, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544045
(9587054, 61804, 1030, 6144, 0, 0, 0, 0, 825.398, 2348.29, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544046
(9587055, 62230, 1030, 6144, 0, 0, 0, 0, 832.826, 2347, 82.2648, 1.82745, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544047
(9587056, 62230, 1030, 6144, 0, 0, 0, 0, 729.247, 2349.17, 82.5722, 5.28883, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544048
(9587057, 61709, 1030, 6144, 0, 0, 0, 0, 731.146, 2321.75, 45.0336, 4.35952, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544049
(9587058, 2110, 1030, 6144, 0, 0, 0, 0, 802.113, 2294.72, 82.5722, 4.68222, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544050
(9587059, 62230, 1030, 6144, 0, 0, 0, 0, 766.472, 2303.35, 52.7219, 0.868131, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544051
(9587060, 62230, 1030, 6144, 0, 0, 0, 0, 759.561, 2311.01, 82.2648, 0.25919, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544052
(9587061, 61709, 1030, 6144, 0, 0, 0, 0, 711.898, 2357.44, 45.0336, 3.47816, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544053
(9587062, 61709, 1030, 6144, 0, 0, 0, 0, 704.936, 2360.59, 45.0336, 0.326847, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544056
(9587063, 61709, 1030, 6144, 0, 0, 0, 0, 708.638, 2350.28, 45.0336, 3.20442, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544057
(9587064, 61709, 1030, 6144, 0, 0, 0, 0, 724.998, 2328.3, 45.1169, 3.97423, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544059
(9587065, 62230, 1030, 6144, 0, 0, 0, 0, 686.25, 2364.81, 45.0336, 0.0547807, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544060
(9587066, 62230, 1030, 6144, 0, 0, 0, 0, 691.606, 2345.95, 45.0336, 0.327473, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544061
(9587067, 61804, 1030, 6144, 0, 0, 0, 0, 710.248, 2453.88, 75.4404, 0.861994, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544062
(9587068, 62230, 1030, 6144, 0, 0, 0, 0, 687.741, 2343.53, 82.5722, 0.273349, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544063
(9587069, 65607, 1030, 6144, 0, 0, 0, 0, 602.865, 2361.68, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544064
(9587070, 62230, 1030, 6144, 0, 0, 0, 0, 773.308, 2404.71, 52.7219, 4.4327, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544065
(9587071, 65607, 1030, 6144, 0, 0, 0, 0, 609.734, 2367.09, 66.7816, 6.09484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544066
(9587072, 65607, 1030, 6144, 0, 0, 0, 0, 626.764, 2346.61, 63.3769, 0.497112, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544067
(9587073, 65607, 1030, 6144, 0, 0, 0, 0, 600.153, 2351.61, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544068
(9587074, 62230, 1030, 6144, 0, 0, 0, 0, 603.06, 2308.37, 67.647, 6.03994, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544069
(9587075, 65607, 1030, 6144, 0, 0, 0, 0, 631.218, 2355.38, 63.376, 6.26733, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544070
(9587076, 62230, 1030, 6144, 0, 0, 0, 0, 596.329, 2361.56, 67.647, 5.26768, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544071
(9587077, 61565, 1030, 6144, 0, 0, 0, 0, 587.217, 2354.08, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544072
(9587078, 65607, 1030, 6144, 0, 0, 0, 0, 600.83, 2341.86, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544073
(9587079, 65607, 1030, 6144, 0, 0, 0, 0, 599.971, 2360.43, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544074
(9587080, 65607, 1030, 6144, 0, 0, 0, 0, 593.703, 2372.49, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544075
(9587081, 65607, 1030, 6144, 0, 0, 0, 0, 593.036, 2355.99, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544076
(9587082, 65607, 1030, 6144, 0, 0, 0, 0, 592.752, 2340.16, 67.7304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544077
(9587083, 62230, 1030, 6144, 0, 0, 0, 0, 710.772, 2321.45, 45.0336, 3.10272, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544078
(9587084, 62009, 1030, 6144, 0, 0, 0, 0, 701.304, 2354.47, 45.1169, 3.92623, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544079
(9587085, 61707, 1030, 6144, 0, 0, 0, 0, 749.946, 2353.53, 52.8053, 3.00784, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544080
(9587086, 61709, 1030, 6144, 0, 0, 0, 0, 701.038, 2349.39, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544081
(9587087, 61709, 1030, 6144, 0, 0, 0, 0, 696.257, 2352.27, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544082
(9587088, 61709, 1030, 6144, 0, 0, 0, 0, 709.073, 2350.31, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544083
(9587089, 61709, 1030, 6144, 0, 0, 0, 0, 697.25, 2358.02, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544084
(9587090, 61709, 1030, 6144, 0, 0, 0, 0, 703.99, 2360.27, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544085
(9587091, 61709, 1030, 6144, 0, 0, 0, 0, 710.757, 2356.91, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544086
(9587092, 61709, 1030, 6144, 0, 0, 0, 0, 723.123, 2318.14, 45.0336, 4.36931, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544087
(9587093, 62230, 1030, 6144, 0, 0, 0, 0, 722.65, 2309.34, 45.0336, 4.20266, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544088
(9587094, 61709, 1030, 6144, 0, 0, 0, 0, 730.58, 2385.89, 45.0336, 2.62722, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544089
(9587095, 61709, 1030, 6144, 0, 0, 0, 0, 724.958, 2385.75, 45.0336, 5.62315, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544090
(9587096, 61709, 1030, 6144, 0, 0, 0, 0, 728.257, 2377.68, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544094
(9587097, 61709, 1030, 6144, 0, 0, 0, 0, 723.174, 2387.64, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544095
(9587098, 61709, 1030, 6144, 0, 0, 0, 0, 715.441, 2379.63, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544096
(9587099, 61709, 1030, 6144, 0, 0, 0, 0, 720.222, 2376.75, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544097
(9587100, 61709, 1030, 6144, 0, 0, 0, 0, 716.434, 2385.39, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544098
(9587101, 61709, 1030, 6144, 0, 0, 0, 0, 729.941, 2384.27, 45.1169, 0, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544099
(9587102, 62230, 1030, 6144, 0, 0, 0, 0, 753.839, 2455.91, 82.5722, 5.84603, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544100
(9587103, 61709, 1030, 6144, 0, 0, 0, 0, 696.162, 2359.28, 45.0336, 1.47901, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544101
(9587104, 65590, 1030, 6144, 0, 0, 0, 0, 694.701, 2341.78, 82.4184, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544102
(9587105, 61783, 1030, 6144, 0, 0, 0, 0, 736.17, 2354.38, 82.6555, 6.254, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544103
(9587106, 66378, 1030, 6144, 0, 0, 0, 0, 898.096, 2358.1, 97.6454, 0.618538, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544105
(9587107, 66378, 1030, 6144, 0, 0, 0, 0, 901.899, 2359.72, 97.6455, 3.00999, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544107
(9587108, 62230, 1030, 6144, 0, 0, 0, 0, 849.991, 2354.08, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544108
(9587109, 62230, 1030, 6144, 0, 0, 0, 0, 832.109, 2348.56, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544109
(9587110, 65590, 1030, 6144, 0, 0, 0, 0, 812.408, 2366.25, 82.069, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544110
(9587111, 61791, 1030, 6144, 0, 0, 0, 0, 898.648, 2361, 97.6454, 4.52478, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544111
(9587112, 61610, 1030, 6144, 0, 0, 0, 0, 815.635, 2348.34, 82.3482, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544112
(9587113, 61814, 1030, 6144, 0, 0, 0, 0, 797.064, 2485.96, 82.6555, 4.81051, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544113
(9587114, 71489, 1030, 6144, 0, 0, 0, 0, 818.747, 2384.63, 82.1304, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544114
(9587115, 62230, 1030, 6144, 0, 0, 0, 0, 817.868, 2388, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544115
(9587116, 62230, 1030, 6144, 0, 0, 0, 0, 829.79, 2392.93, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544116
(9587117, 62230, 1030, 6144, 0, 0, 0, 0, 824.833, 2318.7, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544117
(9587118, 62230, 1030, 6144, 0, 0, 0, 0, 820.404, 2323.12, 82.3482, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544118
(9587119, 2110, 1030, 6144, 0, 0, 0, 0, 810.461, 2314.84, 82.2648, 0.259888, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544119
(9587120, 61610, 1030, 6144, 0, 0, 0, 0, 773.369, 2392.09, 52.7219, 2.33669, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544120
(9587121, 62230, 1030, 6144, 0, 0, 0, 0, 767.876, 2312.52, 82.2648, 5.60104, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544121
(9587122, 62230, 1030, 6144, 0, 0, 0, 0, 821.439, 2441.43, 82.5722, 1.77066, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544122
(9587123, 62230, 1030, 6144, 0, 0, 0, 0, 765.922, 2339.76, 82.5722, 5.23329, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544123
(9587124, 61709, 1030, 6144, 0, 0, 0, 0, 789.227, 2394.81, 52.7219, 0.110719, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544125
(9587125, 62230, 1030, 6144, 0, 0, 0, 0, 793.737, 2352.09, 52.7219, 3.64683, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544127
(9587126, 62230, 1030, 6144, 0, 0, 0, 0, 800.248, 2304.05, 82.5722, 2.54674, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544128
(9587127, 61709, 1030, 6144, 0, 0, 0, 0, 778.121, 2392.55, 52.7219, 3.26053, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544129
(9587128, 61610, 1030, 6144, 0, 0, 0, 0, 769.744, 2314.34, 52.7219, 2.9695, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544131
(9587129, 61610, 1030, 6144, 0, 0, 0, 0, 780.63, 2314.87, 52.7219, 3.5255, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544132
(9587130, 62230, 1030, 6144, 0, 0, 0, 0, 784.478, 2331.56, 52.7219, 3.1838, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544133
(9587131, 62230, 1030, 6144, 0, 0, 0, 0, 783.887, 2401.1, 52.7219, 2.14471, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544134
(9587132, 62230, 1030, 6144, 0, 0, 0, 0, 770.144, 2379.03, 82.5722, 3.30213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544135
(9587133, 61709, 1030, 6144, 0, 0, 0, 0, 781.214, 2396.41, 52.7219, 2.22757, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544136
(9587134, 61709, 1030, 6144, 0, 0, 0, 0, 782.134, 2388.48, 52.7219, 1.15419, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544137
(9587135, 61610, 1030, 6144, 0, 0, 0, 0, 770.925, 2336.67, 82.5722, 4.6534, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544138
(9587136, 65304, 1030, 6144, 0, 0, 0, 0, 766.72, 2394.45, 82.2648, 0.395316, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 544139
(9587137, 62230, 1030, 6144, 0, 0, 0, 0, 771.94, 2405.51, 52.7219, 4.99502, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544141
(9587138, 65590, 1030, 6144, 0, 0, 0, 0, 784.059, 2443.32, 82.4174, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544142
(9587139, 62230, 1030, 6144, 0, 0, 0, 0, 763.968, 2306.75, 52.7219, 1.79611, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544143
(9587140, 62230, 1030, 6144, 0, 0, 0, 0, 727.574, 2349.97, 82.5722, 2.67921, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544144
(9587141, 62230, 1030, 6144, 0, 0, 0, 0, 764.314, 2304.57, 52.7219, 2.18575, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544145
(9587142, 65590, 1030, 6144, 0, 0, 0, 0, 814.094, 2461.52, 82.4174, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544146
(9587143, 61709, 1030, 6144, 0, 0, 0, 0, 815.377, 2455.96, 82.5722, 4.26171, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544147
(9587144, 65581, 1030, 6144, 0, 0, 0, 0, 703.239, 2464.96, 73.9007, 1.97884, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544149
(9587145, 65581, 1030, 6144, 0, 0, 0, 0, 705.144, 2479.28, 75.357, 4.09552, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544153
(9587146, 65581, 1030, 6144, 0, 0, 0, 0, 694.329, 2448.4, 75.357, 0.89413, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544157
(9587147, 62230, 1030, 6144, 0, 0, 0, 0, 723.423, 2391.61, 45.0336, 0.715924, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544158
(9587148, 65581, 1030, 6144, 0, 0, 0, 0, 694.225, 2469.9, 74.1994, 3.12712, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544159
(9587149, 62230, 1030, 6144, 0, 0, 0, 0, 733.685, 2400.38, 45.0336, 3.11816, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544160
(9587150, 65581, 1030, 6144, 0, 0, 0, 0, 692.778, 2459.36, 75.1876, 3.0969, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544161
(9587151, 61709, 1030, 6144, 0, 0, 0, 0, 729.516, 2385.75, 45.0336, 2.22376, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544162
(9587152, 62230, 1030, 6144, 0, 0, 0, 0, 683.655, 2455.83, 75.357, 1.80865, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544163
(9587153, 61709, 1030, 6144, 0, 0, 0, 0, 723.936, 2387.66, 45.0336, 0.642446, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544164
(9587154, 65581, 1030, 6144, 0, 0, 0, 0, 713.931, 2469.76, 75.357, 6.07531, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544171
(9587155, 65581, 1030, 6144, 0, 0, 0, 0, 712.358, 2460.35, 75.357, 3.18911, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544179
(9587156, 65581, 1030, 6144, 0, 0, 0, 0, 711.344, 2476.03, 75.357, 2.43724, 7200, 6, 0, 1, 0, 1, 0, 0, 0), -- LoA 544183
(9587157, 61709, 1030, 6144, 0, 0, 0, 0, 719.014, 2384.32, 45.0336, 5.92355, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544187
(9587158, 61766, 1030, 6144, 0, 0, 0, 0, 802.279, 2403.19, 82.6464, 1.57707, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544199
(9587159, 61709, 1030, 6144, 0, 0, 0, 0, 716.372, 2380.2, 45.0336, 0.958086, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544201
(9587160, 61709, 1030, 6144, 0, 0, 0, 0, 727.969, 2380.25, 45.0336, 2.84932, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544202
(9587161, 62230, 1030, 6144, 0, 0, 0, 0, 818.781, 2512.43, 86.6864, 0.816503, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544203
(9587162, 61709, 1030, 6144, 0, 0, 0, 0, 720.222, 2379, 45.0336, 1.84208, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544204
(9587163, 62230, 1030, 6144, 0, 0, 0, 0, 719.744, 2389.72, 45.0336, 4.28747, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544205
(9587164, 61709, 1030, 6144, 0, 0, 0, 0, 732.865, 2320.21, 45.0336, 2.02226, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544206
(9587165, 61709, 1030, 6144, 0, 0, 0, 0, 711.883, 2357.77, 45.0336, 3.86767, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544207
(9587166, 61709, 1030, 6144, 0, 0, 0, 0, 726.197, 2329.56, 45.0336, 3.87131, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544208
(9587167, 61709, 1030, 6144, 0, 0, 0, 0, 731.123, 2323.36, 45.0336, 2.59184, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544209
(9587168, 71489, 1030, 6144, 0, 0, 0, 0, 656.519, 2341.72, 82.4333, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544212
(9587169, 62230, 1030, 6144, 0, 0, 0, 0, 710.143, 2318.32, 45.0336, 3.72631, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544218
(9587170, 61709, 1030, 6144, 0, 0, 0, 0, 716.466, 2319.88, 45.0336, 0.490237, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544219
(9587171, 61709, 1030, 6144, 0, 0, 0, 0, 718.979, 2326.49, 45.0336, 2.01905, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544220
(9587172, 61709, 1030, 6144, 0, 0, 0, 0, 725.52, 2384.69, 45.0336, 0.743534, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544221
(9587173, 62009, 1030, 6144, 0, 0, 0, 0, 722.312, 2322.5, 45.1169, 3.92623, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544222
(9587174, 61709, 1030, 6144, 0, 0, 0, 0, 707.715, 2361.66, 45.0336, 6.17495, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544223
(9587175, 61709, 1030, 6144, 0, 0, 0, 0, 726.201, 2380.39, 45.0336, 0.344813, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544224
(9587176, 61709, 1030, 6144, 0, 0, 0, 0, 696.683, 2360.22, 45.0336, 1.09128, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544225
(9587177, 61709, 1030, 6144, 0, 0, 0, 0, 704.778, 2361.19, 45.0336, 3.86527, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544226
(9587178, 61709, 1030, 6144, 0, 0, 0, 0, 717.013, 2372.77, 45.0336, 0.89009, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544227
(9587179, 61709, 1030, 6144, 0, 0, 0, 0, 723.065, 2317.91, 45.0336, 3.5745, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544228
(9587180, 61709, 1030, 6144, 0, 0, 0, 0, 695.65, 2351.67, 45.0336, 3.91924, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544229
(9587181, 61709, 1030, 6144, 0, 0, 0, 0, 696.681, 2358.33, 45.0336, 6.02569, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544230
(9587182, 61709, 1030, 6144, 0, 0, 0, 0, 727.475, 2382.06, 45.0336, 0.314541, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544231
(9587183, 62230, 1030, 6144, 0, 0, 0, 0, 698.594, 2361.44, 82.5722, 4.24539, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544232
(9587184, 61709, 1030, 6144, 0, 0, 0, 0, 699.984, 2354.5, 45.0336, 0.78769, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544233
(9587185, 61709, 1030, 6144, 0, 0, 0, 0, 727.564, 2378.29, 45.0336, 1.03282, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544234
(9587186, 62230, 1030, 6144, 0, 0, 0, 0, 751.591, 2455.29, 82.5722, 5.97297, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544239
(9587187, 61804, 1030, 6144, 0, 0, 0, 0, 753.967, 2461.21, 82.6555, 2.41129, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544240
(9587188, 62230, 1030, 6144, 0, 0, 0, 0, 716.249, 2474.76, 75.357, 5.62898, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544241
(9587189, 2110, 1030, 6144, 0, 0, 0, 0, 714.429, 2468.35, 75.357, 2.42969, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544242
(9587190, 61709, 1030, 6144, 0, 0, 0, 0, 756.046, 2464, 82.5722, 0.415678, 7200, 3, 0, 1, 0, 1, 0, 0, 0), -- LoA 544243
(9587191, 62254, 1030, 6144, 0, 0, 46049, 0, 623.623, 2355.72, 63.3757, 1.55946, 7200, 0, 0, 0, 0, 2, 0, 0, 0), -- LoA 544762
(9587192, 62254, 1030, 6144, 0, 0, 46049, 0, 628.277, 2373, 63.3757, 4.75968, 7200, 0, 0, 0, 0, 2, 0, 0, 0), -- LoA 544764
(9587193, 61565, 1030, 6144, 0, 0, 42157, 0, 587.582, 2390.97, 67.7304, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0), -- LoA 544999
(9587194, 61565, 1030, 6144, 0, 0, 42157, 0, 587.868, 2317.09, 67.7304, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0); -- LoA 545155

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9587000 AND 9587038;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9587000, 211707, 1030, 6144, 0, 0, 818.747, 2384.63, 82.0471, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535648
(9587001, 212639, 1030, 6144, 0, 0, 802.133, 2419.66, 82.5722, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 0), -- LoA 535649
(9587002, 211707, 1030, 6144, 0, 0, 825.269, 2317.55, 81.9857, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535650
(9587003, 211709, 1030, 6144, 0, 0, 818.741, 2335.78, 81.9857, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535651
(9587004, 211712, 1030, 6144, 0, 0, 812.408, 2366.25, 81.9857, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535652
(9587005, 212637, 1030, 6144, 0, 0, 802.133, 2288.43, 82.5722, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 535653
(9587006, 212638, 1030, 6144, 0, 0, 639.444, 2353.95, 82.614, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 535654
(9587007, 211623, 1030, 6144, 0, 0, 825.398, 2348.29, 82.2648, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535655
(9587008, 212640, 1030, 6144, 0, 0, 751.756, 2353.95, 82.5722, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 535656
(9587009, 211623, 1030, 6144, 0, 0, 807.764, 2395.28, 82.2648, 2.37436, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535657
(9587010, 215128, 1030, 6144, 0, 0, 803.951, 2305.02, 82.9073, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535658
(9587011, 211709, 1030, 6144, 0, 0, 767.465, 2317.47, 81.9857, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535659
(9587012, 215128, 1030, 6144, 0, 0, 803.821, 2303.78, 82.7608, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535660
(9587013, 211623, 1030, 6144, 0, 0, 797.939, 2389.08, 82.2648, 0.861992, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535661
(9587014, 215128, 1030, 6144, 0, 0, 800.802, 2303.78, 82.7567, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535662
(9587015, 213251, 1030, 6144, 0, 0, 802.182, 2289.47, 82.5866, 4.70977, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535663
(9587016, 215128, 1030, 6144, 0, 0, 800.904, 2305.2, 82.831, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535664
(9587017, 215128, 1030, 6144, 0, 0, 802.596, 2305.13, 82.5722, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535665
(9587018, 211712, 1030, 6144, 0, 0, 743.003, 2347.53, 82.2914, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535666
(9587019, 211842, 1030, 6144, 0, 0, 784.059, 2443.32, 82.3341, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535667
(9587020, 213290, 1030, 6144, 0, 0, 615.522, 2354.07, 82.573, 0.017, 0, 0, 0.0132835, 0.999912, 7200, 0, 1), -- LoA 535668
(9587021, 211842, 1030, 6144, 0, 0, 814.094, 2461.52, 82.3341, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535669
(9587022, 211841, 1030, 6144, 0, 0, 796.137, 2479.67, 82.3792, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535670
(9587023, 214643, 1030, 6144, 0, 0, 700.708, 2467.41, 74.1977, 1.32638, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535671
(9587024, 211623, 1030, 6144, 0, 0, 698.413, 2452.22, 75.357, 0.861992, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535672
(9587025, 211623, 1030, 6144, 0, 0, 813.701, 2470.64, 82.5722, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535673
(9587026, 211707, 1030, 6144, 0, 0, 718.229, 2360.52, 82.2827, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535674
(9587027, 211709, 1030, 6144, 0, 0, 662.783, 2335.52, 82.2045, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535675
(9587028, 211707, 1030, 6144, 0, 0, 656.519, 2341.72, 82.35, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535676
(9587029, 211623, 1030, 6144, 0, 0, 710.248, 2453.88, 75.357, 0.861992, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535677
(9587030, 211843, 1030, 6144, 0, 0, 760.068, 2461.63, 82.3341, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535678
(9587031, 211623, 1030, 6144, 0, 0, 753.778, 2461.42, 82.5722, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535679
(9587032, 211623, 1030, 6144, 0, 0, 781.243, 2473.95, 82.5722, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535689
(9587033, 211623, 1030, 6144, 0, 0, 795.87, 2501.56, 88.5625, 0.861992, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535692
(9587034, 211995, 1030, 6144, 0, 0, 593.5, 2384.76, 67.3849, 4.70502, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535698
(9587035, 211995, 1030, 6144, 0, 0, 593.663, 2347.83, 67.3811, 4.7117, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535699
(9587036, 211709, 1030, 6144, 0, 0, 587.203, 2366.47, 67.3811, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535700
(9587037, 211995, 1030, 6144, 0, 0, 593.493, 2323.36, 67.3895, 6.27484, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535701
(9587038, 211712, 1030, 6144, 0, 0, 694.701, 2341.78, 82.335, 0, 0, 0, 0, 1, 7200, 255, 1); -- LoA 535702

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 9587000 AND 9587194;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(9587191, 95871910, 0, 0, 1, 0, NULL), -- LoA 544762
(9587192, 95871920, 0, 0, 1, 0, NULL); -- LoA 544764

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 95870000 AND 95871940 OR `id` BETWEEN 9587000 AND 9587194;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(95871910, 1, 623.339, 2330.67, 63.3757, 0, 0, 0, 0, 100, 0),
(95871910, 2, 623.328, 2329.67, 63.3757, 0, 0, 0, 0, 100, 0),
(95871910, 3, 623.492, 2344.1, 63.3757, 0, 0, 0, 0, 100, 0),
(95871910, 4, 623.701, 2362.6, 63.3757, 0, 0, 0, 0, 100, 0),
(95871910, 5, 623.701, 2362.6, 63.3757, 0, 0, 0, 0, 100, 0),
(95871920, 1, 628.04, 2378.01, 63.3757, 0, 0, 0, 0, 100, 0),
(95871920, 2, 627.993, 2379.01, 63.3757, 0, 0, 0, 0, 100, 0),
(95871920, 3, 628.945, 2358.91, 63.3757, 0, 0, 0, 0, 100, 0),
(95871920, 4, 628.945, 2358.91, 63.3757, 0, 0, 0, 0, 100, 0),
(9587009, 1, 700.777, 2354.05, 82.5723, 0, 0, 0, 0, 100, 0),
(9587009, 2, 650.384, 2354.09, 82.5723, 0, 0, 0, 0, 100, 0),
(9587041, 1, 799.14, 2446.2, 82.5726, 0, 0, 0, 0, 100, 0),
(9587041, 2, 793.173, 2452.45, 82.5726, 0, 0, 0, 0, 100, 0),
(9587158, 1, 805.102, 2440.14, 82.5726, 0, 0, 0, 0, 100, 0),
(9587158, 2, 799.158, 2452.37, 82.5726, 0, 0, 0, 0, 100, 0),
(9587191, 1, 623.339, 2330.67, 63.3757, 0, 0, 0, 0, 100, 0),
(9587191, 2, 623.328, 2329.67, 63.3757, 0, 0, 0, 0, 100, 0),
(9587191, 3, 623.492, 2344.1, 63.3757, 0, 0, 0, 0, 100, 0),
(9587191, 4, 623.701, 2362.6, 63.3757, 0, 0, 0, 0, 100, 0),
(9587191, 5, 623.701, 2362.6, 63.3757, 0, 0, 0, 0, 100, 0),
(9587192, 1, 628.04, 2378.01, 63.3757, 0, 0, 0, 0, 100, 0),
(9587192, 2, 627.993, 2379.01, 63.3757, 0, 0, 0, 0, 100, 0),
(9587192, 3, 628.945, 2358.91, 63.3757, 0, 0, 0, 0, 100, 0),
(9587192, 4, 628.945, 2358.91, 63.3757, 0, 0, 0, 0, 100, 0);

-- Arena of Annihilation (map 1031): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1031;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1031, 870, 'instance_arena_of_annihiliation', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_scar_shell' WHERE `entry` = 63311; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_jol_grum' WHERE `entry` = 63312; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_little_liuyang' WHERE `entry` = 63313; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_gurgthock' WHERE `entry` = 63315; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_assassin' WHERE `entry` = 63316; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_chagan_firehoof' WHERE `entry` = 63318; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_flame_wall' WHERE `entry` = 63534; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_flamecoaxing_spirit' WHERE `entry` = 63539; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_batu' WHERE `entry` = 63872; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_assassin' WHERE `entry` = 64280; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arena_of_annihiliation_assassin' WHERE `entry` = 64281; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_arena_of_annihiliation_gong' WHERE `entry` = 212974; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 123928 AND `ScriptName` = 'spell_arena_of_annihiliation_stone_spin';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123928, 'spell_arena_of_annihiliation_stone_spin');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123931 AND `ScriptName` = 'spell_arena_of_annihiliation_headbutt';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123931, 'spell_arena_of_annihiliation_headbutt');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123933 AND `ScriptName` = 'spell_arena_of_annihiliation_ill_tempered';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123933, 'spell_arena_of_annihiliation_ill_tempered');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123934 AND `ScriptName` = 'spell_arena_of_annihiliation_slam';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123934, 'spell_arena_of_annihiliation_slam');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123960 AND `ScriptName` = 'spell_arena_of_annihiliation_flame_line';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123960, 'spell_arena_of_annihiliation_flame_line');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123965 AND `ScriptName` = 'spell_arena_of_annihiliation_lava_pool';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123965, 'spell_arena_of_annihiliation_lava_pool');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123966 AND `ScriptName` = 'spell_arena_of_annihiliation_flame_wall';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123966, 'spell_arena_of_annihiliation_flame_wall');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123967 AND `ScriptName` = 'spell_arena_of_annihiliation_lava_pool';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123967, 'spell_arena_of_annihiliation_lava_pool');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123969 AND `ScriptName` = 'spell_arena_of_annihiliation_trailblaze';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123969, 'spell_arena_of_annihiliation_trailblaze');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125564 AND `ScriptName` = 'spell_arena_of_annihiliation_whirlpool';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125564, 'spell_arena_of_annihiliation_whirlpool');
DELETE FROM `spell_script_names` WHERE `spell_id` = 127806 AND `ScriptName` = 'spell_arena_of_annihiliation_serpent_kick';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (127806, 'spell_arena_of_annihiliation_serpent_kick');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 63315;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(63315, 0, 0, 'Welcome to our first officially-sanctioned combat event, the Arena of Annihilation!', 14, 0, 100, 0, 0, 0, ''),
(63315, 1, 0, 'Are you ready to display your martial prowess here, in the eye of The Tiger?', 14, 0, 100, 0, 0, 0, ''),
(63315, 2, 0, 'Then HIT THAT GONG, and show these monks what you\'re made of! ...one way or another, heh.', 14, 0, 100, 0, 0, 0, ''),
(63315, 3, 0, 'For our first show of skill and power we bring you SCAR-SHELL, mightiest of dragon turtles!', 14, 0, 100, 0, 0, 0, ''),
(63315, 4, 0, 'Whew, what a mess! Someone inform the monastery kitchens: We\'re having turtle soup, tonight!', 14, 0, 100, 0, 0, 0, ''),
(63315, 5, 0, 'Ready for the next fight? Ring that gong and GET! IT! ON!', 14, 0, 100, 0, 0, 0, ''),
(63315, 6, 0, 'It\'s time for the grummle-grubbing goliath, fifteen feet of furry fury, Kun-Lai Summit\'s own snow-stalking horror, JOL\'GRUM!', 14, 0, 100, 0, 0, 0, ''),
(63315, 7, 0, 'OUCH! Safe to say that Jol\'Grum wasn\'t quite yet-i ready for his battle with these three killing machines! Speaking of ready...', 14, 0, 100, 0, 0, 0, ''),
(63315, 8, 0, 'She\'s here to make new friends... and then set them on fire! It\'s Pandaria\'s prettiest little playful pyromaniac, Liuyang!', 14, 0, 100, 0, 0, 0, ''),
(63315, 9, 0, 'Snuffed out like a candle! Is there anyone these three can\'t beat?!', 14, 0, 100, 0, 0, 0, ''),
(63315, 10, 0, 'Did someone say Yak Attack?! It\'s ax-master Chagan Firehoof, wandering warrior of the Townlong Steppes!', 14, 0, 100, 0, 0, 0, ''),
(63315, 11, 0, 'What a battle! Our fine combatants served up Chagan a heaping helping of Yaungolian barbeque...', 14, 0, 100, 0, 0, 0, ''),
(63315, 12, 0, 'Flitting through the mists with death upon his fists comes the sinister and serene jinyu assassin: Satay Byu!', 14, 0, 100, 0, 0, 0, ''),
(63315, 13, 0, 'Ooo, that\'s one killer carp whose slaying days have come to a fishy end.', 14, 0, 100, 0, 0, 0, ''),
(63315, 14, 0, 'Everyone, please cheer for the NEW CHAMPIONS of the Arena of Annihilation!', 14, 0, 100, 0, 0, 0, '');

-- NOTE: instance_template map 1031 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `unit_flags` = 33554688 WHERE `entry` = 41206; -- World Invisible Trigger (flying)
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 61211; -- Tiger Temple Monk
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63311; -- Scar-Shell
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 4 WHERE `entry` = 63312; -- Jol\'Grum
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 8 WHERE `entry` = 63313; -- Little Liuyang
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 63314; -- Wodin the Troll-Servant
UPDATE `creature_template` SET `npcflag` = 3 WHERE `entry` = 63315; -- Gurgthock
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63316; -- Cloudbender Kobo
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63318; -- Chagan Firehoof
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 63334; -- Xuen
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63534; -- Flame Wall
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 8 WHERE `entry` = 63539; -- Flamecoaxing Spirit
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63544; -- Trailblaze
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `VehicleId` = 2046 WHERE `entry` = 63872; -- Batu
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 769638399 WHERE `entry` = 64280; -- Maki Waterblade
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 4 WHERE `entry` = 64281; -- Satay Byu
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 66991; -- Twister

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 63313;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63313, 0, 0, 0, 1, 0, '131658');
DELETE FROM `creature_template_addon` WHERE `entry` = 63316;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63316, 0, 0, 0, 1, 0, '124204');
DELETE FROM `creature_template_addon` WHERE `entry` = 63334;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63334, 0, 0, 1, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 63534;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63534, 0, 0, 0, 1, 0, '123961');
DELETE FROM `creature_template_addon` WHERE `entry` = 63539;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63539, 0, 0, 0, 1, 0, '131207');
DELETE FROM `creature_template_addon` WHERE `entry` = 64281;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64281, 0, 0, 0, 1, 0, '125495');

-- conditions

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `type` = 22, `name` = 'Tiger Temple Gong', `data0` = 123744, `data4` = 1, `data6` = 1, `flags` = 32 WHERE `entry` = 212974;

-- INFO gameobject entries LoA spawns on map 1031 and SkyFire does not: 210868 211668 211693 212974 213251

-- Arena of Annihilation (1031): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9589000-9589036, gameobject 9589000-9589005. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9589000 AND 9589036;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9589000, 63311, 1031, 4096, 0, 0, 0, 0, 3716.46, 543.201, 639.774, 6.16253, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544244
(9589001, 63312, 1031, 4096, 0, 0, 0, 0, 3710.94, 543.785, 639.774, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544245
(9589002, 63313, 1031, 4096, 0, 0, 0, 0, 3711.05, 543.835, 639.774, 6.16192, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544246
(9589003, 61211, 1031, 4096, 0, 0, 0, 0, 3748.35, 560.307, 658.951, 5.72301, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544247
(9589004, 61211, 1031, 4096, 0, 0, 0, 0, 3743.01, 519.017, 658.951, 0.360404, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544248
(9589005, 63318, 1031, 4096, 0, 0, 0, 0, 3707.79, 544.106, 639.774, 6.15064, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544263
(9589006, 63316, 1031, 4096, 0, 0, 0, 0, 3709.98, 543.859, 639.774, 6.18361, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544264
(9589007, 41206, 1031, 4096, 0, 0, 0, 0, 3754.85, 564.941, 647.643, 5.62701, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544265
(9589008, 63334, 1031, 4096, 0, 0, 0, 0, 3852.51, 526.398, 659.623, 3.00653, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544266
(9589009, 61211, 1031, 4096, 0, 0, 0, 0, 3778.76, 482.785, 658.951, 1.17148, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544267
(9589010, 41206, 1031, 4096, 0, 0, 0, 0, 3828.93, 559.354, 647.643, 3.82556, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544268
(9589011, 61211, 1031, 4096, 0, 0, 0, 0, 3830.22, 574.491, 658.951, 4.07931, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544269
(9589012, 61211, 1031, 4096, 0, 0, 0, 0, 3835.58, 497.998, 658.951, 2.28196, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544270
(9589013, 41206, 1031, 4096, 0, 0, 0, 0, 3784.21, 535.316, 651.693, 6.1594, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544271
(9589014, 41206, 1031, 4096, 0, 0, 0, 0, 3791.59, 485.885, 647.643, 1.46738, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544272
(9589015, 61211, 1031, 4096, 0, 0, 0, 0, 3754.69, 568.438, 658.951, 5.61272, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544273
(9589016, 41206, 1031, 4096, 0, 0, 0, 0, 3797.27, 545.717, 665.96, 4.55054, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544274
(9589017, 61211, 1031, 4096, 0, 0, 0, 0, 3798.78, 480.161, 658.951, 1.69089, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544275
(9589018, 41206, 1031, 4096, 0, 0, 0, 0, 3820.97, 499.604, 647.643, 2.2052, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544276
(9589019, 63314, 1031, 4096, 0, 0, 0, 0, 3845.19, 527.45, 645.106, 3.02743, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544277
(9589020, 30140, 1031, 4096, 0, 0, 0, 0, 3844.46, 523.785, 645.686, 3.54143, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544278
(9589021, 63315, 1031, 4096, 0, 0, 0, 0, 3845.54, 532.285, 639.774, 3.40633, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544279
(9589022, 41206, 1031, 4096, 0, 0, 0, 0, 3801.23, 578.684, 647.643, 4.6089, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544280
(9589023, 41206, 1031, 4096, 0, 0, 0, 0, 3758, 511.441, 647.643, 0.521981, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544281
(9589024, 61211, 1031, 4096, 0, 0, 0, 0, 3843.54, 556.946, 658.951, 3.58601, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544282
(9589025, 61211, 1031, 4096, 0, 0, 0, 0, 3760.42, 493.146, 658.951, 0.897843, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544283
(9589026, 61211, 1031, 4096, 0, 0, 0, 0, 3847.4, 520.113, 658.951, 2.84995, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544284
(9589027, 41206, 1031, 4096, 0, 0, 0, 0, 3808.4, 532.222, 651.693, 2.99757, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544285
(9589028, 61211, 1031, 4096, 0, 0, 0, 0, 3747.8, 510.026, 658.951, 0.520235, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544286
(9589029, 41206, 1031, 4096, 0, 0, 0, 0, 3841.55, 527.542, 647.643, 3.02337, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544287
(9589030, 61211, 1031, 4096, 0, 0, 0, 0, 3771.81, 581.625, 658.951, 5.2114, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544288
(9589031, 61211, 1031, 4096, 0, 0, 0, 0, 3848.77, 534.312, 658.951, 3.16523, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544289
(9589032, 41206, 1031, 4096, 0, 0, 0, 0, 3793.75, 521.585, 665.96, 1.42919, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544290
(9589033, 61211, 1031, 4096, 0, 0, 0, 0, 3791.92, 586.945, 658.951, 5.15757, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544291
(9589034, 61211, 1031, 4096, 0, 0, 0, 0, 3819.49, 485.908, 658.951, 1.90868, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544292
(9589035, 61211, 1031, 4096, 0, 0, 0, 0, 3812.77, 584.453, 658.951, 4.39486, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 544293
(9589036, 64281, 1031, 4096, 0, 0, 0, 0, 3716.46, 543.177, 639.774, 6.16253, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA 544294

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9589000 AND 9589005;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9589000, 210868, 1031, 4096, 0, 0, 3699.75, 545.34, 639.629, 3.01941, 0, 0, 0.998135, 0.0610487, 7200, 255, 1), -- LoA 535703
(9589001, 212974, 1031, 4096, 0, 0, 3845.35, 527.37, 639.691, 6.15804, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535704
(9589002, 211668, 1031, 4096, 0, 0, 3700.17, 362.705, 597.286, 2.83616, 0, 0, 0.988361, 0.152123, 7200, 255, 1), -- LoA 535705
(9589003, 211668, 1031, 4096, 0, 0, 3666.69, 637.745, 637.391, 4.33714, 0, 0, -0.82659, 0.562805, 7200, 255, 1), -- LoA 535706
(9589004, 213251, 1031, 4096, 0, 0, 3746.59, 539.93, 639.691, 6.15926, 0, 0, 0, 1, 7200, 255, 1), -- LoA 535707
(9589005, 211693, 1031, 4096, 0, 0, 3746.5, 539.929, 639.691, 3.0194, 0, 0, 0, 1, 7200, 255, 1); -- LoA 535710

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 9589000 AND 9589036;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(9589019, 0, 0, 0, 1, 424, NULL); -- LoA 544277

-- Brewmoon Festival (map 1051): world DB rows for the scenario scripts ported from Legends of Azeroth Pandaria 5.4.8
-- (GPL v2, world DB of 2024-07-22). Generated by skyfire_port_plan/tools/scenario_db.ps1. Safe to run twice.

-- instance_template
DELETE FROM `instance_template` WHERE `map` = 1051;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (1051, 870, 'instance_brewmoon_festival', 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_binan_villager' WHERE `entry` = 62784; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_assistant_kieu' WHERE `entry` = 62787; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_assistant_tart' WHERE `entry` = 62793; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_den_mother_moof' WHERE `entry` = 63518; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmoon_water_spirit' WHERE `entry` = 63519; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_li_te' WHERE `entry` = 63520; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_disturbed_saurok' WHERE `entry` = 63521; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bataari_flamecaller' WHERE `entry` = 63526; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bataari_yaungol' WHERE `entry` = 63527; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_warbringer_qobi' WHERE `entry` = 63528; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_karsar_bloodletter' WHERE `entry` = 63529; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_tarts_boat' WHERE `entry` = 63826; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmoon_fireworks_barrel' WHERE `entry` = 63940; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bataari_outrunner' WHERE `entry` = 64165; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bataari_war_yeti' WHERE `entry` = 64185; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmoon_fireline' WHERE `entry` = 64265; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaster_boof' WHERE `entry` = 64901; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 124378 AND `ScriptName` = 'spell_brewmoon_whirlwind';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124378, 'spell_brewmoon_whirlwind');
DELETE FROM `spell_script_names` WHERE `spell_id` = 124752 AND `ScriptName` = 'spell_burrow_cosmetic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124752, 'spell_burrow_cosmetic');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125302 AND `ScriptName` = 'spell_brewmoon_heroic_leap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125302, 'spell_brewmoon_heroic_leap');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125330 AND `ScriptName` = 'spell_brewmoon_heroic_leap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125330, 'spell_brewmoon_heroic_leap');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8554 AND `ScriptName` = 'AreaTrigger_at_brewmoon_festival';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8554, 'AreaTrigger_at_brewmoon_festival');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 62787;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62787, 0, 0, 'I\'m too young to die!', 14, 0, 100, 0, 0, 0, 'kieu intro'),
(62787, 1, 0, 'Thanks, $p! They were going to eat me!', 14, 0, 100, 0, 0, 0, 'kieu preevent'),
(62787, 2, 0, 'There\'s still more virmen in the silos! Can you scare them off for me, $p?', 14, 0, 100, 0, 0, 0, 'kieu virmens'),
(62787, 3, 0, 'It\'s the Den Mother! Look out, $p!', 14, 0, 100, 0, 0, 0, 'kieu den mother'),
(62787, 4, 0, 'That\'ll teach those virmen to try and eat me!', 14, 0, 100, 0, 0, 0, 'kieu den mother defeat'),
(62787, 5, 0, 'I need to get this to Brewmaster Boof before the festival starts. Thanks again for saving me, $p!', 14, 0, 100, 0, 0, 0, 'kieu breewing');
DELETE FROM `creature_text` WHERE `entry` = 62793;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62793, 0, 0, '$n, I need your help!', 14, 0, 100, 0, 0, 0, 'tart intro'),
(62793, 1, 0, 'Good work, $p! Now I can collect the pure water!', 14, 0, 100, 0, 0, 0, 'tart pure water'),
(62793, 2, 0, 'Thanks again, $p! I\'ll get this to Brewmaster Boof right away.', 14, 0, 100, 0, 0, 0, 'tart breewing');
DELETE FROM `creature_text` WHERE `entry` = 63520;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(63520, 0, 0, '|TInterface\\Icons\\creatureportrait_bubble.blp:20|t%s casts |cFFFF0000|Hspell:124653|h[Water Shell]|h|r! Use the Water Spouts to pop it!', 41, 0, 100, 0, 0, 0, 'lite shield');
DELETE FROM `creature_text` WHERE `entry` = 63528;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(63528, 0, 0, 'Warbring Qobi dropped his axes. Grab one!', 14, 0, 100, 0, 0, 0, 'qobi waraxe');
DELETE FROM `creature_text` WHERE `entry` = 64185;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64185, 0, 0, 'A Bataari War Yeti approaches from the Ancient Passage!', 14, 0, 100, 0, 0, 0, 'yeti passage'),
(64185, 1, 0, 'A Bataari War Yeti approaches from the Bridge!', 14, 0, 100, 0, 0, 0, 'yeti bridge'),
(64185, 2, 0, 'A Bataari War Yeti approaches from the west!', 14, 0, 100, 0, 0, 0, 'yeti west');
DELETE FROM `creature_text` WHERE `entry` = 64901;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64901, 0, 0, 'Good to see you, $n! Do you have a minute?', 14, 0, 100, 0, 0, 0, 'brewmaster intro'),
(64901, 1, 0, 'That\'s the last of the ingredients! Good work, $p! Now the festival can begin!', 14, 0, 100, 0, 0, 0, 'brewmaster breewing'),
(64901, 2, 0, 'Kieu, Tart, Buzaki toss the ingredients in!', 14, 0, 100, 0, 0, 0, 'brewmaster ingredients'),
(64901, 3, 0, 'Now comes the hard part. Everyone stand back, precision is the key to the perfect Kun-Lai Kicker!', 14, 0, 100, 0, 0, 0, 'brewmaster process'),
(64901, 4, 0, 'Yaungol!? Now!?', 14, 0, 100, 0, 0, 0, 'brewmaster yaungols'),
(64901, 5, 0, 'They must be after the Kun-Lai Kicker! $p, investigate these sightings and setup the village defenses! They won\'t get my brew without a fight!', 14, 0, 100, 0, 0, 0, 'brewmaster defence 2'),
(64901, 6, 0, 'I\'ll defend the brew until it\'s ready. Then we can use it against these Bataari raiders! Everyone else, get to safety!', 14, 0, 100, 0, 0, 0, 'brewmaster defence 3'),
(64901, 7, 0, 'The Kun-Lai Kicker is finished, $p! Now we can use it to kick some yaungol butt!', 14, 0, 100, 0, 0, 0, 'brewmaster done'),
(64901, 8, 0, 'Good work, $p, you saved the village. We are forever in your debt.', 14, 0, 100, 0, 0, 0, 'brewmaster end scenario');

-- NOTE: instance_template map 1051 missing in SkyFire DB

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `VehicleId` = 2347 WHERE `entry` = 62787; -- Assistant Kieu
UPDATE `creature_template` SET `VehicleId` = 2339 WHERE `entry` = 62793; -- Assistant Tart
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 62807; -- Hungry Virmen
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63518; -- Den Mother Moof
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `InhabitType` = 4 WHERE `entry` = 63519; -- Water Spirit
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `InhabitType` = 4 WHERE `entry` = 63520; -- Li Te
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63521; -- Disturbed Saurok
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771, `unit_class` = 2 WHERE `entry` = 63526; -- Bataari Flamecaller
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 63527; -- Bataari Yaungol
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 63528; -- Warbringer Qobi
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 63529; -- Karsar the Bloodletter
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `VehicleId` = 2327 WHERE `entry` = 63741; -- Burrow Vehicle
UPDATE `creature_template` SET `VehicleId` = 2336 WHERE `entry` = 63811; -- Assistant Buzaki
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 63813; -- Hozen Snot
UPDATE `creature_template` SET `npcflag` = 66177 WHERE `entry` = 63815; -- Puli the Even Handed
UPDATE `creature_template` SET `faction_A` = 2501, `faction_H` = 2501 WHERE `entry` = 63817; -- Binan Warrior
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_flags` = 33554432 WHERE `entry` = 63819; -- Fireworks Launcher
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_flags` = 33554432, `VehicleId` = 2337, `InhabitType` = 4 WHERE `entry` = 63826; -- Tart\'s Boat
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `flags_extra` = 128, `dmg_multiplier` = 3 WHERE `entry` = 63843; -- Pure Water Globe
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `flags_extra` = 128, `VehicleId` = 2342, `dmg_multiplier` = 3 WHERE `entry` = 63874; -- Spawn Burrowed
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 63929; -- Krasarang Wild Brew
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 63940; -- Fireworks Barrel
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 63941; -- Sack of Grain
UPDATE `creature_template` SET `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 64165; -- Bataari Outrunner
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 1771, `faction_H` = 1771 WHERE `entry` = 64185; -- Bataari War Yeti
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_flags` = 33554432, `VehicleId` = 2354, `InhabitType` = 4 WHERE `entry` = 64209; -- Yaungol Boat
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `flags_extra` = 128 WHERE `entry` = 64265; -- Fire Line
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 64271; -- Oil Slick
UPDATE `creature_template` SET `unit_flags2` = 0 WHERE `entry` = 64795; -- Tolai Hare
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `flags_extra` = 128 WHERE `entry` = 64893; -- Binan Village Roof Fire
UPDATE `creature_template` SET `npcflag` = 0 WHERE `entry` = 64901; -- Brewmaster Boof
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 64908; -- Tian Disciple

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 62783;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62783, 0, 0, 0, 1, 0, '124557');
DELETE FROM `creature_template_addon` WHERE `entry` = 63520;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63520, 0, 0, 50331648, 1, 0, '124428');
DELETE FROM `creature_template_addon` WHERE `entry` = 63529;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63529, 0, 0, 0, 1, 0, '126812');
DELETE FROM `creature_template_addon` WHERE `entry` = 63811;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63811, 0, 0, 0, 1, 0, '123956');
DELETE FROM `creature_template_addon` WHERE `entry` = 63817;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63817, 0, 0, 1, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 63826;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63826, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 63843;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63843, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 63922;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63922, 0, 0, 0, 1, 0, '124909');
DELETE FROM `creature_template_addon` WHERE `entry` = 63929;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63929, 0, 0, 0, 1, 0, '124853');
DELETE FROM `creature_template_addon` WHERE `entry` = 63940;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63940, 0, 0, 0, 1, 0, '124901');
DELETE FROM `creature_template_addon` WHERE `entry` = 63946;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (63946, 0, 0, 0, 1, 0, '126900');
DELETE FROM `creature_template_addon` WHERE `entry` = 64165;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64165, 0, 0, 0, 1, 0, '125298');
DELETE FROM `creature_template_addon` WHERE `entry` = 64209;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64209, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 64901;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64901, 0, 0, 0, 1, 0, '124926');
DELETE FROM `creature_template_addon` WHERE `entry` = 64908;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64908, 0, 0, 50331648, 1, 0, '');

-- conditions

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Great Door', `faction` = 114, `flags` = 32 WHERE `entry` = 213172;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 213259;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 213260;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 213261;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Campfire', `data0` = 4, `data1` = 10, `data2` = 2061 WHERE `entry` = 213262;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Anvil', `data0` = 1, `data1` = 10 WHERE `entry` = 213263;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Forge', `data0` = 3, `data1` = 10 WHERE `entry` = 213264;
UPDATE `gameobject_template` SET `name` = 'Mailbox', `faction` = 35 WHERE `entry` = 213265;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Buzaki\'s Boat', `data3` = 1, `faction` = 1375, `flags` = 32 WHERE `entry` = 213370;
UPDATE `gameobject_template` SET `name` = 'Great Wall', `faction` = 114, `flags` = 32 WHERE `entry` = 215760;
UPDATE `gameobject_template` SET `name` = 'Collision', `faction` = 114, `flags` = 32 WHERE `entry` = 215787;

-- INFO gameobject entries LoA spawns on map 1051 and SkyFire does not: 213172 213259 213260 213261 213262 213263 213264 213265 213370 214163 215391 215760 215787 216309

-- Brewmoon Festival (1051): spawns SkyFire lacks, copied from the Legends of Azeroth Pandaria 5.4.8 world DB (2024-07-22).
-- Generated by skyfire_port_plan/tools/SpawnImport.cs. New GUID blocks: creature 9591000-9591312, gameobject 9591000-9591013. The LoA GUID is noted per row.
-- Safe to run twice.

DELETE FROM `creature` WHERE `guid` BETWEEN 9591000 AND 9591312;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9591000, 63819, 1051, 4096, 0, 0, 0, 0, 1672.53, 340.307, 479.941, 6.22743, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545821
(9591001, 63819, 1051, 4096, 0, 0, 0, 0, 1775.25, 293.95, 506.713, 1.48231, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545822
(9591002, 64893, 1051, 4096, 0, 0, 0, 0, 1754.82, 338.031, 485.155, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545823
(9591003, 64893, 1051, 4096, 0, 0, 0, 0, 1737.43, 348.727, 494.696, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545824
(9591004, 63519, 1051, 4096, 0, 0, 0, 0, 1934.12, 312.069, 476.294, 0.8659, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545826
(9591005, 63985, 1051, 4096, 0, 0, 0, 0, 1762.18, 334.825, 478.249, 1.07849, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545827
(9591006, 63817, 1051, 4096, 0, 0, 0, 0, 1770.35, 322.736, 478.532, 0.472659, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545828
(9591007, 63819, 1051, 4096, 0, 0, 0, 0, 1760.08, 282.75, 491.901, 0.898102, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545829
(9591008, 63819, 1051, 4096, 0, 0, 0, 0, 1682.89, 358.377, 479.915, 5.19667, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545830
(9591009, 64893, 1051, 4096, 0, 0, 0, 0, 1725.05, 351.842, 495.592, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545831
(9591010, 64893, 1051, 4096, 0, 0, 0, 0, 1795.59, 362.681, 485.589, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545832
(9591011, 64893, 1051, 4096, 0, 0, 0, 0, 1831.3, 326.832, 495.139, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545833
(9591012, 62783, 1051, 4096, 0, 0, 0, 0, 1731.47, 344.469, 482.034, 2.83252, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545834
(9591013, 64189, 1051, 4096, 0, 0, 0, 0, 1781.12, 341.069, 479.022, 4.5608, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545839
(9591014, 64189, 1051, 4096, 0, 0, 0, 0, 1781.26, 336.26, 478.957, 5.87336, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545840
(9591015, 64793, 1051, 4096, 0, 0, 0, 0, 1668.99, 356.498, 480.546, 3.2886, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545841
(9591016, 64893, 1051, 4096, 0, 0, 0, 0, 1742.52, 362.259, 496.672, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545842
(9591017, 64893, 1051, 4096, 0, 0, 0, 0, 1777.36, 306.212, 491.348, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545843
(9591018, 62785, 1051, 4096, 0, 0, 0, 0, 1768.2, 293.63, 482.117, 3.60744, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545847
(9591019, 63819, 1051, 4096, 0, 0, 0, 0, 1785.2, 377.188, 486.542, 4.80201, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545851
(9591020, 63819, 1051, 4096, 0, 0, 0, 0, 1741.03, 349.411, 495.609, 1.35645, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545852
(9591021, 64089, 1051, 4096, 0, 0, 0, 0, 1804.64, 352.809, 478.138, 2.99587, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545853
(9591022, 64893, 1051, 4096, 0, 0, 0, 0, 1738.23, 372.243, 490.363, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545854
(9591023, 64893, 1051, 4096, 0, 0, 0, 0, 1785.54, 369.74, 486.356, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545855
(9591024, 64893, 1051, 4096, 0, 0, 0, 0, 1771.61, 317.371, 483.714, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545856
(9591025, 64893, 1051, 4096, 0, 0, 0, 0, 1754.1, 388.58, 492.935, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545857
(9591026, 63819, 1051, 4096, 0, 0, 0, 0, 1800.66, 365.212, 486.55, 4.78731, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545860
(9591027, 64901, 1051, 4096, 0, 0, 0, 0, 1746.36, 310.898, 477.713, 3.58132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545861
(9591028, 64893, 1051, 4096, 0, 0, 0, 0, 1763.29, 323.057, 489.48, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545862
(9591029, 64893, 1051, 4096, 0, 0, 0, 0, 1798.6, 378.283, 486.886, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545863
(9591030, 64893, 1051, 4096, 0, 0, 0, 0, 1759.26, 392.358, 502.855, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545864
(9591031, 65295, 1051, 4096, 0, 0, 0, 0, 1779.29, 339.014, 478.916, 0.350781, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545865
(9591032, 63819, 1051, 4096, 0, 0, 0, 0, 1767.5, 289.78, 500.66, 1.48231, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545868
(9591033, 63819, 1051, 4096, 0, 0, 0, 0, 1782.62, 299.04, 500.614, 1.5792, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545869
(9591034, 63813, 1051, 4096, 0, 0, 0, 0, 1581.52, 201.516, 475.85, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545870
(9591035, 64893, 1051, 4096, 0, 0, 0, 0, 1787.95, 364.943, 487.5, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545871
(9591036, 63819, 1051, 4096, 0, 0, 0, 0, 1819.71, 373.347, 501.188, 0.880229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545876
(9591037, 63946, 1051, 4096, 0, 0, 0, 0, 1708.56, 341.444, 480.203, 0.126551, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545877
(9591038, 64893, 1051, 4096, 0, 0, 0, 0, 1766.69, 306.165, 491.681, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545878
(9591039, 64793, 1051, 4096, 0, 0, 0, 0, 1786.71, 340.367, 479.114, 0.307545, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545879
(9591040, 64893, 1051, 4096, 0, 0, 0, 0, 1771.32, 309.052, 484.455, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545880
(9591041, 64893, 1051, 4096, 0, 0, 0, 0, 1784.45, 302.115, 493.142, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545881
(9591042, 63819, 1051, 4096, 0, 0, 0, 0, 1677.88, 320.358, 479.914, 0.786514, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545884
(9591043, 64089, 1051, 4096, 0, 0, 0, 0, 1701.91, 321.795, 479.695, 0.723261, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545886
(9591044, 64893, 1051, 4096, 0, 0, 0, 0, 1740.34, 351.521, 496.324, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545887
(9591045, 64893, 1051, 4096, 0, 0, 0, 0, 1740.4, 356.641, 497.078, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545888
(9591046, 64893, 1051, 4096, 0, 0, 0, 0, 1735.24, 358.608, 501.48, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545889
(9591047, 64893, 1051, 4096, 0, 0, 0, 0, 1790.93, 343.285, 488.565, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545890
(9591048, 63815, 1051, 4096, 0, 0, 0, 0, 1765.6, 291.938, 482.117, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545893
(9591049, 64893, 1051, 4096, 0, 0, 0, 0, 1791.47, 366.095, 490.616, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545895
(9591050, 64893, 1051, 4096, 0, 0, 0, 0, 1780.29, 351.139, 490.612, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545898
(9591051, 64893, 1051, 4096, 0, 0, 0, 0, 1794.56, 376.733, 490.172, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545899
(9591052, 63420, 1051, 4096, 0, 0, 0, 0, 1696.4, 332.521, 478.419, 4.48697, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545900
(9591053, 63819, 1051, 4096, 0, 0, 0, 0, 1788.97, 281.135, 491.974, 2.1962, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545901
(9591054, 63819, 1051, 4096, 0, 0, 0, 0, 1828.69, 331.75, 481.093, 2.63018, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545902
(9591055, 63812, 1051, 4096, 0, 0, 0, 0, 1794.87, 370.339, 478.266, 6.1782, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545903
(9591056, 63819, 1051, 4096, 0, 0, 0, 0, 1744.61, 363.752, 495.672, 4.46327, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545904
(9591057, 63819, 1051, 4096, 0, 0, 0, 0, 1789.98, 305.53, 492.186, 0.852812, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545905
(9591058, 63811, 1051, 4096, 0, 0, 0, 0, 1585.38, 195.5, 477.998, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545906
(9591059, 64893, 1051, 4096, 0, 0, 0, 0, 1787.29, 305.731, 491.353, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545907
(9591060, 64893, 1051, 4096, 0, 0, 0, 0, 1743.35, 354.474, 491.194, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545908
(9591061, 63519, 1051, 4096, 0, 0, 0, 0, 1930.61, 315.863, 476.471, 0.613373, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545912
(9591062, 63946, 1051, 4096, 0, 0, 0, 0, 1783.31, 380.028, 478.155, 0.627536, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545914
(9591063, 64893, 1051, 4096, 0, 0, 0, 0, 1826.04, 317.564, 495.827, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545915
(9591064, 64793, 1051, 4096, 0, 0, 0, 0, 1801.11, 344.684, 478.457, 0.322057, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545916
(9591065, 64893, 1051, 4096, 0, 0, 0, 0, 1774.52, 302.595, 493.147, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545917
(9591066, 63946, 1051, 4096, 0, 0, 0, 0, 1721.23, 324.085, 479.77, 0.660584, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545921
(9591067, 64089, 1051, 4096, 0, 0, 0, 0, 1801.23, 353.55, 478.147, 6.13044, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545923
(9591068, 64893, 1051, 4096, 0, 0, 0, 0, 1786.8, 308.49, 479.087, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545924
(9591069, 64893, 1051, 4096, 0, 0, 0, 0, 1782.45, 306.269, 492.176, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545925
(9591070, 64893, 1051, 4096, 0, 0, 0, 0, 1789.27, 296.892, 482.985, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545926
(9591071, 64893, 1051, 4096, 0, 0, 0, 0, 1795.06, 367.932, 490.751, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545927
(9591072, 64893, 1051, 4096, 0, 0, 0, 0, 1735.2, 348.519, 490.578, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545928
(9591073, 62783, 1051, 4096, 0, 0, 0, 0, 1730.24, 348.401, 483.3, 4.30281, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545929
(9591074, 63819, 1051, 4096, 0, 0, 0, 0, 1786.65, 364.408, 486.726, 4.7469, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545934
(9591075, 63819, 1051, 4096, 0, 0, 0, 0, 1761.45, 307.009, 492.423, 2.2126, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545935
(9591076, 64893, 1051, 4096, 0, 0, 0, 0, 1799, 366.059, 487.447, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545936
(9591077, 64893, 1051, 4096, 0, 0, 0, 0, 1754.13, 391.095, 487.334, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545937
(9591078, 64893, 1051, 4096, 0, 0, 0, 0, 1741.73, 346.722, 491.654, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545939
(9591079, 63941, 1051, 4096, 0, 0, 0, 0, 1756.7, 395.505, 482.352, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545941
(9591080, 63819, 1051, 4096, 0, 0, 0, 0, 1782.06, 288.785, 500.503, 1.53807, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545942
(9591081, 63819, 1051, 4096, 0, 0, 0, 0, 1799.2, 378.938, 486.65, 4.78731, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545943
(9591082, 64893, 1051, 4096, 0, 0, 0, 0, 1829.82, 321.3, 496.363, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545944
(9591083, 64893, 1051, 4096, 0, 0, 0, 0, 1790.65, 372.189, 490.407, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545945
(9591084, 64893, 1051, 4096, 0, 0, 0, 0, 1771.36, 306.271, 491.507, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545946
(9591085, 63819, 1051, 4096, 0, 0, 0, 0, 1720.8, 355.135, 495.701, 4.44053, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545948
(9591086, 64189, 1051, 4096, 0, 0, 0, 0, 1782.38, 338.469, 479.115, 2.52522, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545949
(9591087, 64189, 1051, 4096, 0, 0, 0, 0, 1784.43, 334.898, 478.951, 2.75551, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545950
(9591088, 64893, 1051, 4096, 0, 0, 0, 0, 1803.91, 359.792, 480.006, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545951
(9591089, 63420, 1051, 4096, 0, 0, 0, 0, 1781.3, 338.059, 479.05, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545955
(9591090, 63819, 1051, 4096, 0, 0, 0, 0, 1830.2, 365.274, 501.211, 0.987789, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545957
(9591091, 63819, 1051, 4096, 0, 0, 0, 0, 1675.12, 354.719, 479.919, 5.56029, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545959
(9591092, 63819, 1051, 4096, 0, 0, 0, 0, 1724.29, 369.109, 495.632, 4.46327, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545960
(9591093, 64089, 1051, 4096, 0, 0, 0, 0, 1704.29, 324.08, 479.823, 3.98745, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 545961
(9591094, 64893, 1051, 4096, 0, 0, 0, 0, 1755.98, 391.767, 500.491, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545962
(9591095, 64893, 1051, 4096, 0, 0, 0, 0, 1762.82, 394.349, 488.394, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545963
(9591096, 64893, 1051, 4096, 0, 0, 0, 0, 1736.75, 364.552, 501.517, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545964
(9591097, 64893, 1051, 4096, 0, 0, 0, 0, 1798.23, 371.943, 487.491, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545965
(9591098, 64893, 1051, 4096, 0, 0, 0, 0, 1743.78, 355.712, 495.28, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545966
(9591099, 64893, 1051, 4096, 0, 0, 0, 0, 1825.9, 308.632, 488.557, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545967
(9591100, 63819, 1051, 4096, 0, 0, 0, 0, 1768.02, 299.797, 500.638, 1.48231, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545971
(9591101, 63817, 1051, 4096, 0, 0, 0, 0, 1773.63, 318.667, 478.359, 0.519603, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545974
(9591102, 64893, 1051, 4096, 0, 0, 0, 0, 1745.56, 363.83, 491.309, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545976
(9591103, 64893, 1051, 4096, 0, 0, 0, 0, 1792.58, 305.479, 481.932, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545977
(9591104, 63420, 1051, 4096, 0, 0, 0, 0, 1789.75, 340.052, 479.266, 4.93691, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545980
(9591105, 64893, 1051, 4096, 0, 0, 0, 0, 1779.6, 302.653, 492.951, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545981
(9591106, 64893, 1051, 4096, 0, 0, 0, 0, 1734.14, 353.028, 501.135, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545982
(9591107, 64893, 1051, 4096, 0, 0, 0, 0, 1768.51, 302.655, 493.302, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545983
(9591108, 62784, 1051, 4096, 0, 0, 0, 0, 1688.13, 325.5, 479.914, 0.794375, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 545984
(9591109, 63519, 1051, 4096, 0, 0, 0, 0, 1929.74, 322.168, 476.471, 0.302588, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545985
(9591110, 63819, 1051, 4096, 0, 0, 0, 0, 1823.08, 324.181, 480.972, 2.31573, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545987
(9591111, 64893, 1051, 4096, 0, 0, 0, 0, 1786.01, 376.781, 486.962, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545988
(9591112, 64893, 1051, 4096, 0, 0, 0, 0, 1790.52, 301.646, 490.97, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545989
(9591113, 62783, 1051, 4096, 0, 0, 0, 0, 1814.81, 318.377, 481.229, 0.224834, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545990
(9591114, 62784, 1051, 4096, 0, 0, 0, 0, 1804.77, 330.057, 478.507, 0.707466, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545991
(9591115, 63946, 1051, 4096, 0, 0, 0, 0, 1806.11, 320.746, 479.213, 2.55658, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545993
(9591116, 63946, 1051, 4096, 0, 0, 0, 0, 1822.05, 344.894, 480.342, 1.67026, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545994
(9591117, 64793, 1051, 4096, 0, 0, 0, 0, 1678.67, 361.373, 479.955, 2.54007, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545995
(9591118, 64893, 1051, 4096, 0, 0, 0, 0, 1749.51, 389.854, 483.361, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545996
(9591119, 64893, 1051, 4096, 0, 0, 0, 0, 1827.02, 322.924, 489.884, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545997
(9591120, 64893, 1051, 4096, 0, 0, 0, 0, 1724.98, 351.161, 490.576, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545998
(9591121, 64893, 1051, 4096, 0, 0, 0, 0, 1763.55, 395.708, 492.933, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546004
(9591122, 64893, 1051, 4096, 0, 0, 0, 0, 1757.3, 318.663, 485.728, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546005
(9591123, 64893, 1051, 4096, 0, 0, 0, 0, 1818.41, 368.712, 487.63, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546008
(9591124, 64893, 1051, 4096, 0, 0, 0, 0, 1773.16, 404.545, 482.938, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546009
(9591125, 64893, 1051, 4096, 0, 0, 0, 0, 1774.98, 403.13, 493.665, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546010
(9591126, 64893, 1051, 4096, 0, 0, 0, 0, 1768.23, 402.635, 486.407, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546011
(9591127, 64893, 1051, 4096, 0, 0, 0, 0, 1826.98, 363.043, 488.189, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546012
(9591128, 63519, 1051, 4096, 0, 0, 0, 0, 1936.86, 334.354, 475.624, 5.71867, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546014
(9591129, 64893, 1051, 4096, 0, 0, 0, 0, 1836.01, 324.646, 498.614, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546015
(9591130, 62783, 1051, 4096, 0, 0, 0, 0, 1817.08, 370.995, 500.487, 4.0087, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546016
(9591131, 63874, 1051, 4096, 0, 0, 0, 0, 1769.52, 398.804, 482.184, 4.83798, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546017
(9591132, 64893, 1051, 4096, 0, 0, 0, 0, 1779.94, 401.601, 496.911, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546018
(9591133, 64893, 1051, 4096, 0, 0, 0, 0, 1833.28, 331.227, 490.105, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546019
(9591134, 63519, 1051, 4096, 0, 0, 0, 0, 1955.99, 313.703, 475.563, 2.1219, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546020
(9591135, 63519, 1051, 4096, 0, 0, 0, 0, 1945.32, 338.038, 475.624, 4.91038, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546021
(9591136, 64893, 1051, 4096, 0, 0, 0, 0, 1776.4, 408.358, 482.652, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546022
(9591137, 64893, 1051, 4096, 0, 0, 0, 0, 1777.38, 404.533, 500.447, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546023
(9591138, 64893, 1051, 4096, 0, 0, 0, 0, 1782.34, 405.7, 502.611, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546024
(9591139, 63520, 1051, 4096, 0, 0, 0, 0, 1945.81, 322.467, 485.355, 2.94296, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546025
(9591140, 63519, 1051, 4096, 0, 0, 0, 0, 1952.24, 310.559, 476.223, 1.8466, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546026
(9591141, 63519, 1051, 4096, 0, 0, 0, 0, 1941.23, 336.12, 475.624, 5.34325, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546027
(9591142, 64893, 1051, 4096, 0, 0, 0, 0, 1785.7, 404.26, 493.131, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546028
(9591143, 63817, 1051, 4096, 0, 0, 0, 0, 1832.53, 427.28, 489.442, 4.86505, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546029
(9591144, 63817, 1051, 4096, 0, 0, 0, 0, 1835.11, 425.701, 489.335, 3.46011, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546030
(9591145, 63817, 1051, 4096, 0, 0, 0, 0, 1834.86, 423.688, 489.195, 2.27238, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546031
(9591146, 63818, 1051, 4096, 0, 0, 0, 0, 1829.1, 432.443, 489.019, 5.84085, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546032
(9591147, 64792, 1051, 4096, 0, 0, 0, 0, 1789.63, 459.589, 492.096, 2.62511, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546033
(9591148, 64792, 1051, 4096, 0, 0, 0, 0, 1777.44, 467.718, 498.126, 2.56767, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546034
(9591149, 64792, 1051, 4096, 0, 0, 0, 0, 1777.2, 468.17, 498.538, 2.55429, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546035
(9591150, 64797, 1051, 4096, 0, 0, 0, 0, 1825.46, 459.219, 487.271, 3.00052, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546036
(9591151, 64797, 1051, 4096, 0, 0, 0, 0, 1854.17, 312.5, 475.166, 4.57484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546037
(9591152, 63519, 1051, 4096, 0, 0, 0, 0, 1958.18, 318.757, 475.882, 2.4504, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546038
(9591153, 63814, 1051, 4096, 0, 0, 0, 0, 1879.03, 342.227, 477.139, 5.93197, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546039
(9591154, 63817, 1051, 4096, 0, 0, 0, 0, 1871.2, 381.623, 483.339, 1.71076, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546040
(9591155, 63826, 1051, 4096, 0, 0, 0, 0, 1880.59, 332.413, 475.318, 6.02831, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546041
(9591156, 62793, 1051, 4096, 0, 0, 0, 0, 1878.18, 340.552, 476.952, 5.55015, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546042
(9591157, 63817, 1051, 4096, 0, 0, 0, 0, 1871.83, 385.469, 483.918, 4.02656, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546043
(9591158, 63817, 1051, 4096, 0, 0, 0, 0, 1868.82, 384.243, 483.849, 6.00946, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546044
(9591159, 64792, 1051, 4096, 0, 0, 0, 0, 1920.68, 432.276, 482.629, 3.78436, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546045
(9591160, 64792, 1051, 4096, 0, 0, 0, 0, 1921.76, 433.028, 482.156, 4.12171, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546046
(9591161, 64792, 1051, 4096, 0, 0, 0, 0, 1922.35, 432.129, 481.947, 3.86296, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546047
(9591162, 63843, 1051, 4096, 0, 0, 0, 0, 1945.79, 321.962, 475.393, 2.10923, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546048
(9591163, 63985, 1051, 4096, 0, 0, 0, 0, 1778.47, 294.611, 482.202, 1.51536, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546140
(9591164, 63985, 1051, 4096, 0, 0, 0, 0, 1817.08, 370.995, 500.487, 4.0087, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546144
(9591165, 64797, 1051, 4096, 0, 0, 0, 0, 1856.99, 332.931, 479.079, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546147
(9591166, 64792, 1051, 4096, 0, 0, 0, 0, 1790.43, 458.246, 492.126, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546148
(9591167, 63818, 1051, 4096, 0, 0, 0, 0, 1828.08, 432.775, 489.002, 2.83802, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546149
(9591168, 64792, 1051, 4096, 0, 0, 0, 0, 1789.45, 458.892, 492.266, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546150
(9591169, 64792, 1051, 4096, 0, 0, 0, 0, 1785.69, 459.21, 493.284, 3.72898, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546151
(9591170, 62784, 1051, 4096, 0, 0, 0, 0, 1768.22, 290.182, 482.117, 2.38514, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546152
(9591171, 64793, 1051, 4096, 0, 0, 0, 0, 1663.81, 355.142, 481.499, 0.291176, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546156
(9591172, 64797, 1051, 4096, 0, 0, 0, 0, 1842.71, 453.131, 487.944, 1.5708, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546160
(9591173, 64792, 1051, 4096, 0, 0, 0, 0, 1920.47, 432.641, 482.509, 3.76264, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546162
(9591174, 64792, 1051, 4096, 0, 0, 0, 0, 1921.31, 431.742, 482.323, 3.75072, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546163
(9591175, 64792, 1051, 4096, 0, 0, 0, 0, 1920.65, 432.319, 482.509, 3.73719, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546164
(9591176, 63817, 1051, 4096, 0, 0, 0, 0, 1804.77, 295.738, 479.694, 1.77861, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546166
(9591177, 63929, 1051, 4096, 0, 0, 0, 0, 1755.31, 320.429, 478.477, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546169
(9591178, 63929, 1051, 4096, 0, 0, 0, 0, 1753.81, 320.496, 478.315, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546170
(9591179, 63985, 1051, 4096, 0, 0, 0, 0, 1689.83, 344.905, 479.914, 5.31118, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546171
(9591180, 63929, 1051, 4096, 0, 0, 0, 0, 1697.5, 317.941, 479.438, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546178
(9591181, 63985, 1051, 4096, 0, 0, 0, 0, 1702.63, 343.498, 479.913, 1.74221, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546180
(9591182, 63521, 1051, 4096, 0, 0, 0, 0, 1619.43, 255.04, 476.996, 4.33386, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546182
(9591183, 63929, 1051, 4096, 0, 0, 0, 0, 1698.06, 319.311, 481.247, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546186
(9591184, 64793, 1051, 4096, 0, 0, 0, 0, 1672.08, 356.525, 480.265, 0.108932, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546193
(9591185, 63521, 1051, 4096, 0, 0, 0, 0, 1638.13, 222.789, 475.741, 2.82443, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546194
(9591186, 62807, 1051, 4096, 0, 0, 0, 0, 1756.41, 389.833, 482.129, 5.85216, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546199
(9591187, 63929, 1051, 4096, 0, 0, 0, 0, 1811.48, 319.931, 480.373, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546200
(9591188, 63929, 1051, 4096, 0, 0, 0, 0, 1811.77, 318.512, 480.337, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546202
(9591189, 63929, 1051, 4096, 0, 0, 0, 0, 1805.62, 358.727, 478.134, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546203
(9591190, 63929, 1051, 4096, 0, 0, 0, 0, 1806.32, 359.693, 478.13, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546204
(9591191, 63929, 1051, 4096, 0, 0, 0, 0, 1785.84, 379.099, 478.117, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546205
(9591192, 64793, 1051, 4096, 0, 0, 0, 0, 1786.1, 340.257, 479.155, 0.299447, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546206
(9591193, 63929, 1051, 4096, 0, 0, 0, 0, 1786.53, 380.064, 478.123, 4.87979, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546209
(9591194, 62784, 1051, 4096, 0, 0, 0, 0, 1784.46, 357.973, 478.031, 0.184387, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546210
(9591195, 64793, 1051, 4096, 0, 0, 0, 0, 1791.84, 340.669, 479.11, 0.180727, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546212
(9591196, 62807, 1051, 4096, 0, 0, 0, 0, 1772.77, 379.765, 479.309, 2.35831, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546218
(9591197, 64089, 1051, 4096, 0, 0, 0, 0, 1743.67, 354.852, 482.301, 3.08943, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546284
(9591198, 64795, 1051, 4096, 0, 0, 0, 0, 1836.07, 503.963, 489.82, 3.03632, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546285
(9591199, 62807, 1051, 4096, 0, 0, 0, 0, 1777.98, 408.172, 482.741, 1.55341, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546297
(9591200, 62807, 1051, 4096, 0, 0, 0, 0, 1771.35, 387.663, 481.044, 0.194008, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546304
(9591201, 64793, 1051, 4096, 0, 0, 0, 0, 1685.75, 357.602, 479.914, 3.26712, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546305
(9591202, 64793, 1051, 4096, 0, 0, 0, 0, 1785.94, 339.59, 479.227, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546307
(9591203, 63985, 1051, 4096, 0, 0, 0, 0, 1691.95, 332.75, 480.018, 0.321421, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546309
(9591204, 64793, 1051, 4096, 0, 0, 0, 0, 1785.28, 340.215, 479.22, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546310
(9591205, 62807, 1051, 4096, 0, 0, 0, 0, 1756.21, 398.559, 484.54, 5.52498, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546311
(9591206, 62807, 1051, 4096, 0, 0, 0, 0, 1757.96, 397.962, 483.504, 3.39942, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546314
(9591207, 63529, 1051, 4096, 0, 0, 0, 0, 1597.03, 199.309, 479.032, 1.39905, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546315
(9591208, 62807, 1051, 4096, 0, 0, 0, 0, 1779.86, 410.22, 483.403, 3.39942, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546321
(9591209, 62787, 1051, 4096, 0, 0, 0, 0, 1756.56, 378.373, 481.918, 5.92794, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546324
(9591210, 62807, 1051, 4096, 0, 0, 0, 0, 1776.51, 410.398, 483.72, 6.24425, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546325
(9591211, 64793, 1051, 4096, 0, 0, 0, 0, 1685.1, 358.227, 479.913, 2.80484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546326
(9591212, 62783, 1051, 4096, 0, 0, 0, 0, 1780.81, 289.163, 482.117, 2.86483, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546331
(9591213, 62783, 1051, 4096, 0, 0, 0, 0, 1765.05, 289.905, 490.648, 4.26291, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546339
(9591214, 64797, 1051, 4096, 0, 0, 0, 0, 1855.72, 322.334, 476.517, 4.67432, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546346
(9591215, 63818, 1051, 4096, 0, 0, 0, 0, 1838.47, 427.223, 488.777, 2.46677, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546347
(9591216, 64792, 1051, 4096, 0, 0, 0, 0, 1794.55, 460.33, 490.625, 0.274814, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546348
(9591217, 64792, 1051, 4096, 0, 0, 0, 0, 1789.15, 461.817, 491.399, 1.9803, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546349
(9591218, 64792, 1051, 4096, 0, 0, 0, 0, 1789.32, 460.64, 491.691, 1.98198, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546350
(9591219, 64797, 1051, 4096, 0, 0, 0, 0, 1823.12, 456.07, 487.99, 6.2025, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546351
(9591220, 64792, 1051, 4096, 0, 0, 0, 0, 1920.55, 432.699, 482.659, 3.75072, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546352
(9591221, 64792, 1051, 4096, 0, 0, 0, 0, 1919.96, 431.328, 482.801, 3.92492, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546353
(9591222, 64792, 1051, 4096, 0, 0, 0, 0, 1921.18, 431.894, 482.409, 3.58996, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546354
(9591223, 64795, 1051, 4096, 0, 0, 0, 0, 1841.7, 496.431, 490.426, 5.08938, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546356
(9591224, 64089, 1051, 4096, 0, 0, 0, 0, 1710.65, 324.345, 479.397, 0.405582, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546406
(9591225, 62784, 1051, 4096, 0, 0, 0, 0, 1698.2, 351.797, 479.929, 4.73736, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546419
(9591226, 63521, 1051, 4096, 0, 0, 0, 0, 1630.42, 254.972, 476.37, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546422
(9591227, 63521, 1051, 4096, 0, 0, 0, 0, 1593.43, 241.549, 476.741, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546423
(9591228, 63521, 1051, 4096, 0, 0, 0, 0, 1616.06, 217.682, 476.202, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546425
(9591229, 63985, 1051, 4096, 0, 0, 0, 0, 1684.68, 336.203, 479.914, 3.03195, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546426
(9591230, 63985, 1051, 4096, 0, 0, 0, 0, 1785.27, 299.358, 482.152, 5.09018, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546433
(9591231, 62784, 1051, 4096, 0, 0, 0, 0, 1681.54, 333.533, 479.945, 0.625521, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546434
(9591232, 63985, 1051, 4096, 0, 0, 0, 0, 1686.44, 349.323, 479.914, 2.06148, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546435
(9591233, 62784, 1051, 4096, 0, 0, 0, 0, 1699.85, 346.113, 479.914, 6.12024, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546440
(9591234, 62784, 1051, 4096, 0, 0, 0, 0, 1783.99, 278.996, 481.343, 4.61231, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546441
(9591235, 62784, 1051, 4096, 0, 0, 0, 0, 1678.68, 336.307, 479.933, 0.000606136, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546444
(9591236, 63985, 1051, 4096, 0, 0, 0, 0, 1777.28, 306.644, 481.989, 1.48578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546446
(9591237, 64792, 1051, 4096, 0, 0, 0, 0, 1790.03, 460.304, 491.87, 1.18141, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546448
(9591238, 64792, 1051, 4096, 0, 0, 0, 0, 1788.54, 460.786, 492.2, 2.63601, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546449
(9591239, 63818, 1051, 4096, 0, 0, 0, 0, 1822.34, 434.573, 488.892, 5.97961, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546450
(9591240, 64792, 1051, 4096, 0, 0, 0, 0, 1787.52, 458.902, 492.795, 3.11035, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546451
(9591241, 64797, 1051, 4096, 0, 0, 0, 0, 1858.06, 329.108, 477.757, 1.34715, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546452
(9591242, 64797, 1051, 4096, 0, 0, 0, 0, 1832.9, 455.941, 487.723, 2.7917, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546453
(9591243, 64792, 1051, 4096, 0, 0, 0, 0, 1911.46, 426.955, 484.51, 3.67698, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546455
(9591244, 64792, 1051, 4096, 0, 0, 0, 0, 1918.32, 422.197, 482.509, 4.49584, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546456
(9591245, 64792, 1051, 4096, 0, 0, 0, 0, 1917.68, 423.025, 482.592, 4.33533, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546457
(9591246, 64795, 1051, 4096, 0, 0, 0, 0, 1840.14, 502.571, 489.858, 5.49736, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546470
(9591247, 63922, 1051, 4096, 0, 0, 0, 0, 1790.2, 311.694, 478.114, 1.87289, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546529
(9591248, 63985, 1051, 4096, 0, 0, 0, 0, 1694.36, 355.45, 479.942, 4.14361, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546535
(9591249, 64797, 1051, 4096, 0, 0, 0, 0, 1853.82, 314.952, 475.669, 5.08763, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546544
(9591250, 63818, 1051, 4096, 0, 0, 0, 0, 1823.34, 434.259, 488.911, 5.97961, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546546
(9591251, 64792, 1051, 4096, 0, 0, 0, 0, 1777.5, 458.097, 495.232, 3.16307, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546547
(9591252, 64792, 1051, 4096, 0, 0, 0, 0, 1791.28, 467.841, 490.241, 0.785086, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546548
(9591253, 64792, 1051, 4096, 0, 0, 0, 0, 1787.19, 466.65, 491.976, 1.9015, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546549
(9591254, 64797, 1051, 4096, 0, 0, 0, 0, 1844.27, 450.522, 488.132, 5.86321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546550
(9591255, 64792, 1051, 4096, 0, 0, 0, 0, 1914.96, 428.905, 484.171, 3.69056, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546551
(9591256, 64792, 1051, 4096, 0, 0, 0, 0, 1916.21, 429.826, 483.81, 3.55149, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546552
(9591257, 64792, 1051, 4096, 0, 0, 0, 0, 1919, 428.439, 482.949, 1.87274, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546553
(9591258, 64792, 1051, 4096, 0, 0, 0, 0, 1791.77, 159.436, 494.328, 5.29698, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546556
(9591259, 64792, 1051, 4096, 0, 0, 0, 0, 1787.48, 161.861, 495.507, 2.97484, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546557
(9591260, 64792, 1051, 4096, 0, 0, 0, 0, 1788.24, 160.44, 495.521, 2.88477, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546558
(9591261, 64797, 1051, 4096, 0, 0, 0, 0, 1746.47, 190.53, 490.63, 0.0507872, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546559
(9591262, 64793, 1051, 4096, 0, 0, 0, 0, 1894.5, 173.933, 478.593, 3.37882, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546560
(9591263, 64089, 1051, 4096, 0, 0, 0, 0, 1775.51, 322.235, 478.183, 5.35589, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546613
(9591264, 62783, 1051, 4096, 0, 0, 0, 0, 1836.43, 320.474, 481.233, 2.53147, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546616
(9591265, 63985, 1051, 4096, 0, 0, 0, 0, 1757.2, 338.292, 479.218, 4.74257, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546618
(9591266, 63940, 1051, 4096, 0, 0, 0, 0, 1810.3, 318.932, 480.087, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546623
(9591267, 63940, 1051, 4096, 0, 0, 0, 0, 1699.23, 320.295, 479.738, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546625
(9591268, 63985, 1051, 4096, 0, 0, 0, 0, 1703.55, 347.613, 479.917, 4.1033, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546626
(9591269, 63940, 1051, 4096, 0, 0, 0, 0, 1780.59, 380.087, 478.205, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546627
(9591270, 63940, 1051, 4096, 0, 0, 0, 0, 1754.18, 318.653, 478.602, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546628
(9591271, 63940, 1051, 4096, 0, 0, 0, 0, 1807.01, 358.16, 478.163, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546629
(9591272, 62784, 1051, 4096, 0, 0, 0, 0, 1688.85, 341.689, 479.961, 0.0989375, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546630
(9591273, 63985, 1051, 4096, 0, 0, 0, 0, 1785.12, 290.212, 482.121, 2.36812, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546631
(9591274, 63985, 1051, 4096, 0, 0, 0, 0, 1807.59, 332.431, 478.701, 3.72777, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546633
(9591275, 62784, 1051, 4096, 0, 0, 0, 0, 1782.86, 290.613, 482.123, 0.702148, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546636
(9591276, 62783, 1051, 4096, 0, 0, 0, 0, 1790.8, 345.182, 479.013, 1.60274, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546637
(9591277, 63985, 1051, 4096, 0, 0, 0, 0, 1694.07, 348.335, 479.914, 4.76038, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546640
(9591278, 62784, 1051, 4096, 0, 0, 0, 0, 1785.3, 292.608, 482.127, 3.66319, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546641
(9591279, 62784, 1051, 4096, 0, 0, 0, 0, 1783.15, 292.941, 482.131, 5.46161, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546642
(9591280, 63985, 1051, 4096, 0, 0, 0, 0, 1764.13, 338.375, 478.266, 4.24015, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546645
(9591281, 64792, 1051, 4096, 0, 0, 0, 0, 1790.85, 458.211, 492.074, 2.68777, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546649
(9591282, 64792, 1051, 4096, 0, 0, 0, 0, 1789.05, 459.777, 492.131, 0.261286, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546650
(9591283, 63818, 1051, 4096, 0, 0, 0, 0, 1836.3, 428.96, 488.913, 5.60837, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546651
(9591284, 64792, 1051, 4096, 0, 0, 0, 0, 1790.39, 465.878, 491.025, 4.67237, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546652
(9591285, 64797, 1051, 4096, 0, 0, 0, 0, 1842.8, 450.34, 488.148, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546653
(9591286, 64792, 1051, 4096, 0, 0, 0, 0, 1914.01, 428.284, 484.031, 0.551143, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546654
(9591287, 64792, 1051, 4096, 0, 0, 0, 0, 1913.16, 430.17, 484.529, 0.260854, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546655
(9591288, 64792, 1051, 4096, 0, 0, 0, 0, 1913.87, 429.337, 484.254, 0.499035, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546656
(9591289, 63812, 1051, 4096, 0, 0, 0, 0, 1651.98, 267.018, 477.096, 3.6008, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546657
(9591290, 62784, 1051, 4096, 0, 0, 0, 0, 1774.32, 295.993, 482.08, 0.567958, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546709
(9591291, 62784, 1051, 4096, 0, 0, 0, 0, 1683.68, 354.005, 479.914, 5.05739, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546722
(9591292, 63985, 1051, 4096, 0, 0, 0, 0, 1682.7, 352.325, 479.914, 0.0160131, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546723
(9591293, 62784, 1051, 4096, 0, 0, 0, 0, 1782.53, 279.031, 481.441, 4.61231, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546728
(9591294, 62783, 1051, 4096, 0, 0, 0, 0, 1777.65, 289.451, 482.117, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546730
(9591295, 62783, 1051, 4096, 0, 0, 0, 0, 1727.91, 345.472, 481.896, 6.07835, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546731
(9591296, 62784, 1051, 4096, 0, 0, 0, 0, 1691.77, 351.727, 479.914, 1.32126, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546733
(9591297, 62784, 1051, 4096, 0, 0, 0, 0, 1787.83, 358.663, 478.114, 2.84405, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546735
(9591298, 62784, 1051, 4096, 0, 0, 0, 0, 1681.41, 339.031, 479.932, 5.67404, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546739
(9591299, 63985, 1051, 4096, 0, 0, 0, 0, 1693.22, 342.663, 480.464, 5.58697, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546740
(9591300, 62784, 1051, 4096, 0, 0, 0, 0, 1690.36, 355.55, 479.929, 4.96762, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546742
(9591301, 62784, 1051, 4096, 0, 0, 0, 0, 1684.26, 344.629, 479.914, 5.77584, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546744
(9591302, 63817, 1051, 4096, 0, 0, 0, 0, 1749.13, 322.701, 478.106, 3.934, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546747
(9591303, 64792, 1051, 4096, 0, 0, 0, 0, 1785.12, 465.5, 492.454, 3.67213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546748
(9591304, 64792, 1051, 4096, 0, 0, 0, 0, 1792.69, 457.669, 491.538, 5.44352, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546749
(9591305, 63818, 1051, 4096, 0, 0, 0, 0, 1840.21, 425.83, 488.668, 5.60837, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 546750
(9591306, 64792, 1051, 4096, 0, 0, 0, 0, 1790.29, 460.927, 491.55, 1.11588, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546751
(9591307, 64797, 1051, 4096, 0, 0, 0, 0, 1855.88, 317.266, 475.655, 1.49462, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546752
(9591308, 64792, 1051, 4096, 0, 0, 0, 0, 1922.6, 428.311, 481.924, 5.41688, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546753
(9591309, 64792, 1051, 4096, 0, 0, 0, 0, 1916.52, 430.321, 483.719, 3.69926, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546754
(9591310, 64792, 1051, 4096, 0, 0, 0, 0, 1921.03, 427.351, 482.167, 4.58336, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546755
(9591311, 64089, 1051, 4096, 0, 0, 0, 0, 1708.01, 322.428, 479.317, 0.628321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 546804
(9591312, 63985, 1051, 4096, 0, 0, 0, 0, 1782.01, 294.429, 482.136, 1.54899, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA 546806

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9591000 AND 9591013;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9591000, 213265, 1051, 4096, 0, 0, 1776.92, 311.262, 477.896, 3.15906, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536480
(9591001, 213264, 1051, 4096, 0, 0, 1773.88, 374.319, 478.061, 0.523598, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536481
(9591002, 216309, 1051, 4096, 0, 0, 1763.67, 292.014, 482.034, 3.08918, 0, 0, -0.725374, 0.688355, 7200, 255, 1), -- LoA 536482
(9591003, 215760, 1051, 4096, 0, 0, 1711.35, 1364.11, 457.522, 3.13286, 0, 0, 0.999991, 0.00436351, 7200, 255, 1), -- LoA 536483
(9591004, 215391, 1051, 4096, 0, 0, 2739.78, 367.303, 509.367, 5.48034, 0, 0, -0.390731, 0.920505, 7200, 255, 1), -- LoA 536484
(9591005, 213259, 1051, 4096, 0, 0, 1685.1, 352.135, 479.831, 3.22016, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536485
(9591006, 213262, 1051, 4096, 0, 0, 1778.13, 366.894, 478.076, 2.61799, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536486
(9591007, 215787, 1051, 4096, 0, 0, 1711.35, 1364.11, 457.522, 3.13286, 0, 0, 0.999991, 0.00436351, 7200, 255, 1), -- LoA 536487
(9591008, 213172, 1051, 4096, 0, 0, 1760.88, 1363.67, 468.469, 6.27446, 0, 0, 0.999991, 0.00436351, 7200, 255, 1), -- LoA 536488
(9591009, 213263, 1051, 4096, 0, 0, 1770.96, 370.913, 478.104, 3.89209, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536489
(9591010, 213370, 1051, 4096, 0, 0, 1579.9, 201.821, 475.333, 6.19862, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536490
(9591011, 214163, 1051, 4096, 0, 0, 1797.36, 369.526, 478.17, 6.03585, 0, 0, 0.746058, 0.665882, 7200, 255, 1), -- LoA 536491
(9591012, 213260, 1051, 4096, 0, 0, 1833.35, 425.227, 488.699, 3.14159, 0, 0, 0, 1, 7200, 255, 1), -- LoA 536492
(9591013, 213261, 1051, 4096, 0, 0, 1870.89, 383.453, 483.097, 2.32129, 0, 0, 0, 1, 7200, 255, 1); -- LoA 536493

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 9591000 AND 9591312;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(9591005, 0, 0, 0, 1, 378, NULL), -- LoA 545827
(9591043, 0, 0, 0, 1, 378, NULL), -- LoA 545886
(9591179, 0, 0, 0, 1, 461, NULL), -- LoA 546171
(9591181, 0, 0, 0, 1, 378, NULL), -- LoA 546180
(9591194, 0, 0, 0, 1, 378, NULL), -- LoA 546210
(9591203, 0, 0, 0, 1, 461, NULL), -- LoA 546309
(9591229, 0, 0, 0, 1, 378, NULL), -- LoA 546426
(9591231, 0, 0, 0, 1, 378, NULL), -- LoA 546434
(9591232, 0, 0, 0, 1, 378, NULL), -- LoA 546435
(9591233, 0, 0, 0, 1, 378, NULL), -- LoA 546440
(9591234, 0, 0, 0, 1, 415, NULL), -- LoA 546441
(9591235, 0, 0, 0, 1, 378, NULL), -- LoA 546444
(9591248, 0, 0, 0, 1, 378, NULL), -- LoA 546535
(9591268, 0, 0, 0, 1, 378, NULL), -- LoA 546626
(9591272, 0, 0, 0, 1, 461, NULL), -- LoA 546630
(9591277, 0, 0, 0, 1, 461, NULL), -- LoA 546640
(9591280, 0, 0, 0, 1, 378, NULL), -- LoA 546645
(9591291, 0, 0, 0, 1, 378, NULL), -- LoA 546722
(9591292, 0, 0, 0, 1, 378, NULL), -- LoA 546723
(9591293, 0, 0, 0, 1, 415, NULL), -- LoA 546728
(9591296, 0, 0, 0, 1, 378, NULL), -- LoA 546733
(9591297, 0, 0, 0, 1, 378, NULL), -- LoA 546735
(9591298, 0, 0, 0, 1, 378, NULL), -- LoA 546739
(9591299, 0, 0, 0, 1, 461, NULL), -- LoA 546740
(9591300, 0, 0, 0, 1, 378, NULL), -- LoA 546742
(9591301, 0, 0, 0, 1, 10, NULL); -- LoA 546744

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 95910000 AND 95913120 OR `id` BETWEEN 9591000 AND 9591312;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(9591209, 1, 1756, 380.752, 481.997, 0, 0, 1, 0, 100, 0),
(9591209, 2, 1756.47, 379.87, 481.997, 0, 0, 1, 0, 100, 0),
(9591209, 3, 1757.75, 377.484, 481.754, 0, 0, 1, 0, 100, 0),
(9591209, 4, 1760.61, 376.6, 481.129, 0, 0, 1, 0, 100, 0),
(9591209, 5, 1762.52, 376.01, 480.504, 0, 0, 1, 0, 100, 0),
(9591209, 6, 1765.15, 375.198, 479.785, 0, 0, 1, 0, 100, 0),
(9591209, 7, 1767.03, 375.881, 479.28, 0, 0, 1, 0, 100, 0),
(9591209, 8, 1772.66, 377.932, 478.53, 0, 0, 1, 0, 100, 0),
(9591209, 9, 1772.66, 377.932, 478.53, 0, 0, 1, 0, 100, 0);


-- Fixes for load errors seen after the first import on the dev realm
-- spell_areatrigger_template: sat_blanches_elexir
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 340;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (340, 0, 1, 3.5, 0, 0, 'sat_blanches_elexir');
-- spell_areatrigger_template: sat_bo_rejuvinating_mist
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 346;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (346, 0, 1, 5, 0, 0, 'sat_bo_rejuvinating_mist');
-- spell_areatrigger_template: sat_arena_of_annihiliation_whirlpool
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 385;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (385, 0, 1, 50, 0, 0, 'sat_arena_of_annihiliation_whirlpool');
