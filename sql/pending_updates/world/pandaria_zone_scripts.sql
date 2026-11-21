-- Section 2 (P7, P15): DB rows for the Pandaria zone, world boss and Timeless Isle scripts ported from Legends of
-- Azeroth Pandaria 5.4.8 (GPL v2, world DB of 2024-07-22): templates of creatures only the scripts summon, their loot,
-- ScriptName bindings, spell and areatrigger script bindings, creature texts. Safe to run twice.

-- Templates the scenario scripts need that SkyFire's DB lacks, copied from the Legends of Azeroth Pandaria
-- 5.4.8 world DB (GPL v2, 2024-07-22) by skyfire_port_plan/tools/TemplateImport.ps1. Safe to run twice.

-- creature_template (15)
DELETE FROM `creature_template` WHERE `entry` IN (68087,68088,68514,68515,68519,68741,68907,69072,69806,71869,71883,71990,72020,72059,73309);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Mana_mod_extra`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `faction_A`, `faction_H`, `npc_rank`) VALUES
(68087, 0, 0, 0, 0, 0, 33424, 0, 0, 0, 'Landing Boat', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1611661328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2593, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_horde_landing_boat', 14, 14, 0),
(68088, 0, 0, 0, 0, 0, 32904, 0, 0, 0, 'Garrosh Hellscream', 'Warchief', NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 51031, 11, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 7, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1200, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_garrosh_hellscream_krasarang_landing', 1734, 1734, 1),
(68514, 0, 0, 0, 0, 0, 28127, 0, 0, 0, 'King Varian Wrynn', 'King of Stormwind', NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 45299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 7, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1200, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 0, 0, 'npc_varian_wrynn_krasarang_landing', 1732, 1732, 1),
(68515, 0, 0, 0, 0, 0, 33424, 0, 0, 0, 'Landing Boat', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1611661328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2593, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_alliance_landing_boat', 1732, 1732, 0),
(68519, 0, 0, 0, 0, 0, 46413, 0, 0, 0, 'Hilda Hornswaggle', 'Explorer\'s League', NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_hilda_hornswaggle_krasarang_landing', 14, 14, 0),
(68741, 0, 0, 0, 0, 0, 47023, 0, 0, 0, 'Fennie Hornswaggle', 'Explorer\'s League', NULL, 15338, 90, 90, 4, 0, 1, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_the_bell_peaks_start', 1732, 1732, 0),
(68907, 0, 0, 0, 0, 0, 46976, 0, 0, 0, 'Varatus the Conqueror', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 6, 2147483648, 0, 68907, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 3, 30, 1, 1, 0, 93212, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_varatus_the_conqueror', 14, 14, 0),
(69072, 0, 0, 0, 0, 0, 33424, 0, 0, 0, 'Landing Boat', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 33555200, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1611661328, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2593, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_horde_landing_boat', 14, 14, 0),
(69806, 0, 0, 0, 0, 0, 47693, 0, 0, 0, 'Vengeful Spirit', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 70, 1, 142672401, 0, 'npc_vengeful_spirit', 14, 14, 1),
(71869, 0, 0, 0, 0, 0, 45629, 0, 0, 0, 'Zarhym', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 'npc_zarhym_2', 35, 35, 0),
(71883, 0, 0, 0, 0, 0, 39753, 0, 0, 0, 'Playful Water Spirit', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 0.5, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_playful_water_spirit', 16, 16, 6),
(71990, 0, 0, 0, 0, 0, 39553, 0, 0, 0, 'Child of Chi-Ji', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 131074, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 100, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 907, 1, 0, 0, 'npc_child_of_chi_ji', 16, 16, 0),
(72020, 0, 0, 0, 0, 0, 31174, 11686, 0, 0, 'Jadefire Wall', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 156, 1, 0, 128, 'npc_jadefire_wall', 14, 14, 0),
(72059, 0, 0, 0, 0, 0, 31174, 11686, 0, 0, 'Ancient Flame', NULL, NULL, 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 61, 1, 0, 128, 'npc_ordos_ancient_flame', 14, 14, 0),
(73309, 0, 0, 0, 0, 0, 46710, 0, 0, 0, 'Catch and Carry', '', '', 0, 90, 90, 4, 0, 0, 1, 1.14286, 1, 14666, 24933, 0, 42299, 1, 2000, 2000, 1, 33555200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1074790400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_catch_and_carry', 35, 35, 0);

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` IN (68741,71883,72020,73309);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(68741, 0, 0, 0, 1, 0, ''),
(71883, 0, 0, 0, 1, 0, ''),
(72020, 0, 0, 50331648, 1, 0, ''),
(73309, 0, 0, 0, 1, 0, '');

-- creature_model_info (models of the new templates)
DELETE FROM `creature_model_info` WHERE `modelid` IN (46976,47023,47693);
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES
(46976, 0, 0, 2, 0),
(47023, 0.347, 1.5, 0, 0),
(47693, 1.5, 1.5, 0, 0);

-- gameobject_template (1)
DELETE FROM `gameobject_template` WHERE `entry` IN (211112);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `data24`, `data25`, `data26`, `data27`, `data28`, `data29`, `data30`, `data31`, `unkInt32`, `AIName`, `ScriptName`) VALUES
(211112, 25, 6527, 'Mysterious Whirlpool', '', '', '', 3, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_mysterious_whirlpool');

-- creature_loot_template for the new templates (LoA rows, lootmode 1)
DELETE FROM `creature_loot_template` WHERE `entry` IN (68907);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(68907, 81205, 87, 1, 0, 1, 1),
(68907, 81216, 5.5, 1, 0, 1, 1),
(68907, 82194, 10, 1, 0, 1, 1),
(68907, 82237, 12, 1, 0, 1, 1),
(68907, 89112, 10, 1, 0, 1, 1),
(68907, 93212, -100, 1, 0, 1, 1);

-- Generated by skyfire_port_plan/tools/bindsql.ps1 from the LoA world dump (2024-07-22). Safe to run twice.

-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'npc_sha_of_anger_bunny' WHERE `entry` = 35114; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_go_kan' WHERE `entry` = 50331; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_korda_torros' WHERE `entry` = 50332; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lon_the_bull' WHERE `entry` = 50333; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dak_the_breaker' WHERE `entry` = 50334; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_yorik_sharpeye' WHERE `entry` = 50336; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kang_the_soul_thief' WHERE `entry` = 50340; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_borginn_darkfist' WHERE `entry` = 50341; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_norlaxx' WHERE `entry` = 50344; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kang_the_soul_thief' WHERE `entry` = 50349; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_torik_ethis' WHERE `entry` = 50388; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ski_thik' WHERE `entry` = 50733; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lith_ik' WHERE `entry` = 50734; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_gar_lok' WHERE `entry` = 50739; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_sele_na' WHERE `entry` = 50766; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zai_the_outcast' WHERE `entry` = 50769; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_eshelon' WHERE `entry` = 50772; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_nalash_verdantis' WHERE `entry` = 50776; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_arness_the_scale' WHERE `entry` = 50787; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_nessos_the_oracle' WHERE `entry` = 50789; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_siltriss_sharpener' WHERE `entry` = 50791; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_yul_wildpaw' WHERE `entry` = 50820; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ai_li_skymirror' WHERE `entry` = 50821; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bonobos' WHERE `entry` = 50828; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scritch' WHERE `entry` = 50831; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_the_yowler' WHERE `entry` = 50832; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_ik_the_nimble' WHERE `entry` = 50836; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_blackhoof' WHERE `entry` = 51059; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_na_lek' WHERE `entry` = 55597; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_liang_thunderfoot' WHERE `entry` = 56205; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_francis_the_shepherd_boy' WHERE `entry` = 56208; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_adolescent_mushan' WHERE `entry` = 56239; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_wyrmhorn_turtle' WHERE `entry` = 56256; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_lupello' WHERE `entry` = 56357; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_snagtooth_hooligan' WHERE `entry` = 56462; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_frenzyhop' WHERE `entry` = 56514; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_orange_painted_turnip' WHERE `entry` = 56539; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_warrior' WHERE `entry` = 56722; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_ik_thik_wing_commander' WHERE `entry` = 56723; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_hornbill_strider' WHERE `entry` = 56753; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57120; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57121; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57122; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57123; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57124; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57126; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57127; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_q29982' WHERE `entry` = 57134; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_grainhunter_hawk' WHERE `entry` = 57215; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_grainhunter_hawk' WHERE `entry` = 57216; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_springtail_gnasher' WHERE `entry` = 57413; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_mothfighter' WHERE `entry` = 57648; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_weeping_horror' WHERE `entry` = 57649; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_unbarreled_pandaren' WHERE `entry` = 57681; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dojani_surveyor' WHERE `entry` = 58068; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dojani_reclaimer' WHERE `entry` = 58117; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dojani_dominator' WHERE `entry` = 58165; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_wildscale_herbalist' WHERE `entry` = 58216; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_groundbreaker_brojai' WHERE `entry` = 58224; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_riverblade_slayer' WHERE `entry` = 58273; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_ikthik_vanguard' WHERE `entry` = 58368; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_krasari_tormentor' WHERE `entry` = 58377; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_darkhide' WHERE `entry` = 58435; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_thundermaw' WHERE `entry` = 58456; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bloodtip' WHERE `entry` = 58474; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dojani_reclaimer' WHERE `entry` = 58614; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_krasarang_wilds_sunwalker_dezco_reclaimer' WHERE `entry` = 58666; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_krasarang_wilds_lyalia' WHERE `entry` = 58670; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ancient_mogu_spirit' WHERE `entry` = 58671; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lorekeeper_vaeldrin' WHERE `entry` = 58745; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_quid' WHERE `entry` = 58771; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_aetha' WHERE `entry` = 58778; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_sunwalker_scout' WHERE `entry` = 58850; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_viceclaw_scuttler' WHERE `entry` = 58881; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shao_tien_fist' WHERE `entry` = 58927; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shao_tien_antiquator' WHERE `entry` = 58928; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_elder_seadragon' WHERE `entry` = 58940; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_stoneplow_envoy' WHERE `entry` = 58955; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_krasarang_wilds_lyalia' WHERE `entry` = 58976; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_veb_shado_pan_trainee' WHERE `entry` = 58992; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zhus_watch_courier' WHERE `entry` = 59151; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_barrel_of_fireworks' WHERE `entry` = 59284; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hungry_yeti' WHERE `entry` = 59540; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordo_overseer' WHERE `entry` = 59580; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_sha_of_despair' WHERE `entry` = 59651; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_echo_of_despair' WHERE `entry` = 59687; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_mischievous_snow_sprite' WHERE `entry` = 59693; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_mogujia_soul_caller' WHERE `entry` = 59797; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_manifestation_of_fear' WHERE `entry` = 59874; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dagou' WHERE `entry` = 59977; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kunlai_old_poof_poof' WHERE `entry` = 60015; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_explosives_barrel' WHERE `entry` = 60095; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_nahassa' WHERE `entry` = 60203; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_mogu_jade_guardian' WHERE `entry` = 60296; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_frenzied_reef_shark' WHERE `entry` = 60408; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_terracotta_gladiator' WHERE `entry` = 60569; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_terracotta_defender' WHERE `entry` = 60573; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_student_of_chi_ji' WHERE `entry` = 60601; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_child_of_chi_ji_krasarang' WHERE `entry` = 60616; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_osul_mist_shaman' WHERE `entry` = 60697; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_longying_ranger' WHERE `entry` = 60730; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_broketooth_leaper' WHERE `entry` = 60742; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_broketooth_leaper' WHERE `entry` = 60744; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_silverback_piker' WHERE `entry` = 60746; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ooking_shaman' WHERE `entry` = 60752; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kota_kon' WHERE `entry` = 60754; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lorewalker_cho_bashon' WHERE `entry` = 60795; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lin_silentstrike' WHERE `entry` = 60899; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_tomb_guardian' WHERE `entry` = 60912; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_waterspeaker_gorai' WHERE `entry` = 60973; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_seething_hatred' WHERE `entry` = 61054; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_suna_silentstrike' WHERE `entry` = 61055; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_seething_hatred' WHERE `entry` = 61092; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_seething_flashripper' WHERE `entry` = 61299; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_relcaimer_zuan_pets' WHERE `entry` = 61305; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_relcaimer_zuan_pets' WHERE `entry` = 61306; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_relcaimer_zuan_pets' WHERE `entry` = 61307; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lorewalker_cho_bashon_summoned' WHERE `entry` = 61315; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_korthik_timberhusk' WHERE `entry` = 61355; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_townlong_gunpowder_cask' WHERE `entry` = 61362; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_inkgill_dissenter' WHERE `entry` = 61566; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_wounded_niuzao_sentinel' WHERE `entry` = 61570; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_longshadow_mushan' WHERE `entry` = 61618; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_terracotta_gladiator' WHERE `entry` = 61813; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zandalari_warrior' WHERE `entry` = 61842; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_mistblade_reapper' WHERE `entry` = 61970; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_coldbite_matriarch' WHERE `entry` = 62008; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shado_pan_sentinel' WHERE `entry` = 62220; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_adjunct_kree_zot' WHERE `entry` = 62301; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_galion' WHERE `entry` = 62346; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_salyin_skrimisher' WHERE `entry` = 62350; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_salyin_warmonger' WHERE `entry` = 62351; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_darkwoods_faerie' WHERE `entry` = 62522; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kilruk_wind_reaver' WHERE `entry` = 62538; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hulking_kor_thik_fleshrender' WHERE `entry` = 62686; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_waster_dread_lurker' WHERE `entry` = 62751; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_clutch_guard' WHERE `entry` = 62754; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_deadtalker_crusher' WHERE `entry` = 62844; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_gochao_the_iron_fist' WHERE `entry` = 62880; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_general_temuja' WHERE `entry` = 63101; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_wulon' WHERE `entry` = 63510; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shao_tien_dominator' WHERE `entry` = 63610; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shao_tien_soul_caller' WHERE `entry` = 63611; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_amberstinger' WHERE `entry` = 63728; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_amber_tap' WHERE `entry` = 63740; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hei_feng' WHERE `entry` = 63920; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_quilen_stonemaw' WHERE `entry` = 64014; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_just_a_folk_story_quest' WHERE `entry` = 64312; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_just_a_folk_story_quest' WHERE `entry` = 64313; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_just_a_folk_story_quest' WHERE `entry` = 64315; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_just_a_folk_story_quest' WHERE `entry` = 64327; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_fish_fellreed' WHERE `entry` = 64347; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_vfw_krungko_fingerlicker' WHERE `entry` = 64389; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_alani' WHERE `entry` = 64403; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_aetha_tornado' WHERE `entry` = 64525; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_xuen_celestial_experience' WHERE `entry` = 64528; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shekzeer_clutch_keeper' WHERE `entry` = 64559; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hisek_the_swarmkeeper' WHERE `entry` = 64569; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_whisperer' WHERE `entry` = 64622; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_wake_of_horror' WHERE `entry` = 64626; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'celestial_experience_sha' WHERE `entry` = 64656; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hisek_the_swarmkeeper_2' WHERE `entry` = 64672; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'celestial_experience_sha' WHERE `entry` = 64684; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hisek_the_swarmkeeper_summon' WHERE `entry` = 64705; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_kunchong' WHERE `entry` = 64717; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_karanosh' WHERE `entry` = 64724; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'celestial_experience_sha' WHERE `entry` = 64742; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'celestial_experience_sha' WHERE `entry` = 64744; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lorewalker_cho_wanderers_festival' WHERE `entry` = 64950; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_milau' WHERE `entry` = 64965; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kypa_rak' WHERE `entry` = 65229; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_elder_spindlegrin' WHERE `entry` = 65391; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_overgrown_seacarp' WHERE `entry` = 65394; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_fearbringer' WHERE `entry` = 65496; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_warlord_gurthan' WHERE `entry` = 65502; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_kunchong' WHERE `entry` = 65582; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_krasari_runekeeper' WHERE `entry` = 65598; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dojani_enforcer' WHERE `entry` = 65626; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_upland_raven' WHERE `entry` = 65629; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_terrorclaw' WHERE `entry` = 65632; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_klaxxiva_ik' WHERE `entry` = 65767; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_source_of_despair' WHERE `entry` = 65873; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_waster_nagging_dreadling' WHERE `entry` = 65996; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_matriarch' WHERE `entry` = 66187; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_granary_vandal' WHERE `entry` = 66205; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_master_hight' WHERE `entry` = 66260; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_rankbite_ancient' WHERE `entry` = 66462; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ik_thik_clutch_guard' WHERE `entry` = 66465; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_gnathus' WHERE `entry` = 66467; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_malik_the_unscathed_quest_empress_gambit' WHERE `entry` = 66776; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shox_tik' WHERE `entry` = 66784; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_manifestation_of_terror' WHERE `entry` = 66785; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_grand_vizier_zorlok_quest_empress_gambit' WHERE `entry` = 66791; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_malik_the_unscathed_quest_empress_gambit_trigger' WHERE `entry` = 66797; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kilruk_quest_shadow_of_empire' WHERE `entry` = 66800; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_initiate_chuang_summoned' WHERE `entry` = 66844; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shieldwall_footman' WHERE `entry` = 67304; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_warlord_bloodhilt' WHERE `entry` = 67461; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dominance_grunt' WHERE `entry` = 67598; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_high_marshal_twinbraid' WHERE `entry` = 67801; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_mercurial_guardian' WHERE `entry` = 67833; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bilgewater_sapper' WHERE `entry` = 67929; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_the_bell_peaks_start' WHERE `entry` = 68681; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_oondasta' WHERE `entry` = 69161; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zandalari_dinomancer_2' WHERE `entry` = 69925; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn' WHERE `entry` = 69983; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_young_primal_devilsaur' WHERE `entry` = 69993; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_young_primal_devilsaur' WHERE `entry` = 70004; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_young_primal_devilsaur' WHERE `entry` = 70005; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_young_primal_devilsaur' WHERE `entry` = 70006; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_young_primal_devilsaur' WHERE `entry` = 70007; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn_hatchling' WHERE `entry` = 70013; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn_hatchling' WHERE `entry` = 70014; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn_hatchling' WHERE `entry` = 70015; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn' WHERE `entry` = 70016; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn' WHERE `entry` = 70017; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn' WHERE `entry` = 70018; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_primal_direhorn' WHERE `entry` = 70019; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_pterrorwing_skyscreamer' WHERE `entry` = 70020; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_kun_lai_grandpa_grumplefloot' WHERE `entry` = 71082; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cranes' WHERE `entry` = 71143; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_nice_sprite' WHERE `entry` = 71823; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_damp_shamblers' WHERE `entry` = 71864; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zarhym_1' WHERE `entry` = 71876; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_elementals' WHERE `entry` = 71919; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 71939; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 71940; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_chi_ji' WHERE `entry` = 71952; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_xuen' WHERE `entry` = 71953; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_niuzao' WHERE `entry` = 71954; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_yu_lon' WHERE `entry` = 71955; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cove_shark' WHERE `entry` = 71986; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_spectral_pirate' WHERE `entry` = 71987; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_turtles' WHERE `entry` = 72045; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_rattleskew' WHERE `entry` = 72048; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_cranegnasher' WHERE `entry` = 72049; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_ordos' WHERE `entry` = 72057; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cranes' WHERE `entry` = 72095; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_fin_longpaw' WHERE `entry` = 72151; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_karkanos' WHERE `entry` = 72193; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zesqua' WHERE `entry` = 72245; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cranes' WHERE `entry` = 72762; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_turtles' WHERE `entry` = 72763; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_turtles' WHERE `entry` = 72764; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_turtles' WHERE `entry` = 72765; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_crabs' WHERE `entry` = 72766; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_jademist_dancer' WHERE `entry` = 72767; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_spirits' WHERE `entry` = 72769; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_damp_shamblers' WHERE `entry` = 72771; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_frogs' WHERE `entry` = 72775; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_frogs' WHERE `entry` = 72777; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cats' WHERE `entry` = 72805; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cats' WHERE `entry` = 72807; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cats' WHERE `entry` = 72808; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_giants' WHERE `entry` = 72809; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_adders' WHERE `entry` = 72841; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_yaks' WHERE `entry` = 72842; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_yaks' WHERE `entry` = 72843; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_yaks' WHERE `entry` = 72844; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordon_candlekeeper' WHERE `entry` = 72875; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_dragons' WHERE `entry` = 72876; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_leaf_sprites' WHERE `entry` = 72877; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_molten_guards' WHERE `entry` = 72888; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordon_guards' WHERE `entry` = 72892; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordon_watchers' WHERE `entry` = 72894; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_warriors' WHERE `entry` = 72895; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 72896; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 72897; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 72898; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_silkworms' WHERE `entry` = 72908; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_silkworms' WHERE `entry` = 72909; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_giants' WHERE `entry` = 72970; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_spectrals' WHERE `entry` = 73018; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_spectrals' WHERE `entry` = 73021; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_spectrals' WHERE `entry` = 73025; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_damp_shamblers' WHERE `entry` = 73157; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_cranes' WHERE `entry` = 73158; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_yaks' WHERE `entry` = 73160; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_turtles' WHERE `entry` = 73161; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_spirits' WHERE `entry` = 73162; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_adders' WHERE `entry` = 73163; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_crabs' WHERE `entry` = 73166; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_dragons' WHERE `entry` = 73167; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordon_guards' WHERE `entry` = 73169; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordon_watchers' WHERE `entry` = 73170; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_warriors' WHERE `entry` = 73171; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 73172; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 73173; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 73174; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_molten_guards' WHERE `entry` = 73175; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_leaf_sprites' WHERE `entry` = 73277; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_evermaw' WHERE `entry` = 73279; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_dread_ship_vazuvius' WHERE `entry` = 73281; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_garnia' WHERE `entry` = 73282; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_emperor_shaohao' WHERE `entry` = 73303; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 73343; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 73361; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 73362; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 73385; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_timeless_faction_sentries' WHERE `entry` = 73386; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_eternal_kiln' WHERE `entry` = 73528; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_highwind_albatross' WHERE `entry` = 73531; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_senior_historian_evelyna' WHERE `entry` = 73570; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_hopswift' WHERE `entry` = 73629; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_ordos_minions' WHERE `entry` = 73666; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_stinkbraid' WHERE `entry` = 73704; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_southsea_lookout' WHERE `entry` = 73718; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_yaungol_banner' WHERE `entry` = 210933; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_drywood_cage' WHERE `entry` = 211511; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_silent_beacon' WHERE `entry` = 213250; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_full_crab_pot' WHERE `entry` = 213508; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_guo_lai_treasure_cache' WHERE `entry` = 214388; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_sikthik_cage' WHERE `entry` = 214734; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_neverending_spritewood' WHERE `entry` = 220807; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220819; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220832; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220901; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220902; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_gleaming_crane_statue_ti' WHERE `entry` = 220903; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220908; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220986; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220994; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220995; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220996; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220997; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220998; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 220999; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221000; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221001; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221002; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221003; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221004; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221005; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221006; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221007; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221008; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221009; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221010; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221013; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221014; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221015; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221016; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221017; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221018; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221019; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221020; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221021; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221023; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221024; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221026; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_conspicuously_empty_shell' WHERE `entry` = 221027; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221036; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221617; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221670; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221671; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221672; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 221673; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 222684; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_crane_nest' WHERE `entry` = 222685; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 222686; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 222687; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 222688; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 222689; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_zarhyms_body' WHERE `entry` = 222768; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_time_lost_shrine_ti' WHERE `entry` = 222776; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223084; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223085; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223086; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223087; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223088; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223089; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223090; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223091; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223092; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223093; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223094; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223095; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223096; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223097; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223098; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223099; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223100; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223101; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223102; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223103; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223104; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223105; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223106; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223107; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223108; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223109; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223110; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223111; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223112; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223113; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223114; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223115; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223116; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223117; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223118; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223119; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_cursed_grave' WHERE `entry` = 223132; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_challengers_stone' WHERE `entry` = 223203; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_timeless_chest' WHERE `entry` = 223204; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 26013 AND `ScriptName` = 'spell_timeless_isle_crane_wings';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (26013, 'spell_timeless_isle_crane_wings');
DELETE FROM `spell_script_names` WHERE `spell_id` = 104300 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (104300, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 104303 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (104303, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 104306 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (104306, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 104309 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (104309, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 104312 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (104312, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 106284 AND `ScriptName` = 'spell_gen_gather_muddy_water_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (106284, 'spell_gen_gather_muddy_water_aura');
DELETE FROM `spell_script_names` WHERE `spell_id` = 106309 AND `ScriptName` = 'spell_gen_gather_muddy_water';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (106309, 'spell_gen_gather_muddy_water');
DELETE FROM `spell_script_names` WHERE `spell_id` = 108817 AND `ScriptName` = 'spell_vfw_breaking_barrel';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (108817, 'spell_vfw_breaking_barrel');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114457 AND `ScriptName` = 'spell_suspicious_footprint_identified';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114457, 'spell_suspicious_footprint_identified');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114668 AND `ScriptName` = 'spell_four_wind_pick_up_chicken';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114668, 'spell_four_wind_pick_up_chicken');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114850 AND `ScriptName` = 'spell_call_of_despair_missle';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114850, 'spell_call_of_despair_missle');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114856 AND `ScriptName` = 'spell_call_of_despair_target_picker';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114856, 'spell_call_of_despair_target_picker');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115092 AND `ScriptName` = 'spell_vfw_apply_mask';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115092, 'spell_vfw_apply_mask');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115226 AND `ScriptName` = 'spell_vfw_disoriented';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115226, 'spell_vfw_disoriented');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115452 AND `ScriptName` = 'spell_kunlai_release_old_poot_poot';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115452, 'spell_kunlai_release_old_poot_poot');
DELETE FROM `spell_script_names` WHERE `spell_id` = 117901 AND `ScriptName` = 'spell_gather_steam';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (117901, 'spell_gather_steam');
DELETE FROM `spell_script_names` WHERE `spell_id` = 118103 AND `ScriptName` = 'spell_item_shado_pan_torch';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (118103, 'spell_item_shado_pan_torch');
DELETE FROM `spell_script_names` WHERE `spell_id` = 118953 AND `ScriptName` = 'spell_summ_lorewalker_cho_bashon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (118953, 'spell_summ_lorewalker_cho_bashon');
DELETE FROM `spell_script_names` WHERE `spell_id` = 119391 AND `ScriptName` = 'spell_townlong_shado_pan_spike_trap_eff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (119391, 'spell_townlong_shado_pan_spike_trap_eff');
DELETE FROM `spell_script_names` WHERE `spell_id` = 119626 AND `ScriptName` = 'spell_sha_of_anger_aggressive_behaviour';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (119626, 'spell_sha_of_anger_aggressive_behaviour');
DELETE FROM `spell_script_names` WHERE `spell_id` = 119743 AND `ScriptName` = 'spell_q30959';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (119743, 'spell_q30959');
DELETE FROM `spell_script_names` WHERE `spell_id` = 120573 AND `ScriptName` = 'spell_item_cintron_infused_bandage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (120573, 'spell_item_cintron_infused_bandage');
DELETE FROM `spell_script_names` WHERE `spell_id` = 121673 AND `ScriptName` = 'spell_galleon_fire_shot';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (121673, 'spell_galleon_fire_shot');
DELETE FROM `spell_script_names` WHERE `spell_id` = 122721 AND `ScriptName` = 'spell_dread_waster_gather_shade';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (122721, 'spell_dread_waster_gather_shade');
DELETE FROM `spell_script_names` WHERE `spell_id` = 122723 AND `ScriptName` = 'spell_dread_waster_gather_shade';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (122723, 'spell_dread_waster_gather_shade');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123498 AND `ScriptName` = 'spell_item_living_amber';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123498, 'spell_item_living_amber');
DELETE FROM `spell_script_names` WHERE `spell_id` = 123803 AND `ScriptName` = 'spell_q31182';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (123803, 'spell_q31182');
DELETE FROM `spell_script_names` WHERE `spell_id` = 124054 AND `ScriptName` = 'spell_to_be_a_master_food_coocking';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124054, 'spell_to_be_a_master_food_coocking');
DELETE FROM `spell_script_names` WHERE `spell_id` = 124344 AND `ScriptName` = 'spell_q31233';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124344, 'spell_q31233');
DELETE FROM `spell_script_names` WHERE `spell_id` = 124364 AND `ScriptName` = 'spell_q31233';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124364, 'spell_q31233');
DELETE FROM `spell_script_names` WHERE `spell_id` = 124729 AND `ScriptName` = 'spell_dread_waster_sonic_emission';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (124729, 'spell_dread_waster_sonic_emission');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125753 AND `ScriptName` = 'spell_vfw_krungko_timer';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125753, 'spell_vfw_krungko_timer');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126182 AND `ScriptName` = 'spell_alani_remove_protections';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126182, 'spell_alani_remove_protections');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126188 AND `ScriptName` = 'spell_nimbus_shroud';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126188, 'spell_nimbus_shroud');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126455 AND `ScriptName` = 'spell_crush_uprising';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126455, 'spell_crush_uprising');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126631 AND `ScriptName` = 'spell_celestial_experience_devastation';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126631, 'spell_celestial_experience_devastation');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126633 AND `ScriptName` = 'spell_celestial_experience_whirlwind_of_anger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126633, 'spell_celestial_experience_whirlwind_of_anger');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126825 AND `ScriptName` = 'spell_q31487';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126825, 'spell_q31487');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126903 AND `ScriptName` = 'spell_devastating_leap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126903, 'spell_devastating_leap');
DELETE FROM `spell_script_names` WHERE `spell_id` = 127463 AND `ScriptName` = 'spell_icy_destruction';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (127463, 'spell_icy_destruction');
DELETE FROM `spell_script_names` WHERE `spell_id` = 129356 AND `ScriptName` = 'spell_sha_of_anger_overcome_by_anger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (129356, 'spell_sha_of_anger_overcome_by_anger');
DELETE FROM `spell_script_names` WHERE `spell_id` = 129496 AND `ScriptName` = 'spell_vfw_prey_pounce';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (129496, 'spell_vfw_prey_pounce');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130061 AND `ScriptName` = 'spell_zet_uk_sha_eruption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130061, 'spell_zet_uk_sha_eruption');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130063 AND `ScriptName` = 'spell_zet_uk_sha_eruption_periodic_summon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130063, 'spell_zet_uk_sha_eruption_periodic_summon');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130212 AND `ScriptName` = 'spell_throw_grain';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130212, 'spell_throw_grain');
DELETE FROM `spell_script_names` WHERE `spell_id` = 130728 AND `ScriptName` = 'spell_protective_shell';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (130728, 'spell_protective_shell');
DELETE FROM `spell_script_names` WHERE `spell_id` = 131196 AND `ScriptName` = 'spell_empress_gambit_quest';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (131196, 'spell_empress_gambit_quest');
DELETE FROM `spell_script_names` WHERE `spell_id` = 131201 AND `ScriptName` = 'spell_zorlok_shout';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (131201, 'spell_zorlok_shout');
DELETE FROM `spell_script_names` WHERE `spell_id` = 134653 AND `ScriptName` = 'spell_krasarang_landing_cinematic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (134653, 'spell_krasarang_landing_cinematic');
DELETE FROM `spell_script_names` WHERE `spell_id` = 135154 AND `ScriptName` = 'spell_cannonball_spin';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (135154, 'spell_cannonball_spin');
DELETE FROM `spell_script_names` WHERE `spell_id` = 135417 AND `ScriptName` = 'spell_chaingun';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (135417, 'spell_chaingun');
DELETE FROM `spell_script_names` WHERE `spell_id` = 135421 AND `ScriptName` = 'spell_bloodhilt_brutal_charge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (135421, 'spell_bloodhilt_brutal_charge');
DELETE FROM `spell_script_names` WHERE `spell_id` = 135954 AND `ScriptName` = 'spell_krasarang_landing_cinematic';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (135954, 'spell_krasarang_landing_cinematic');
DELETE FROM `spell_script_names` WHERE `spell_id` = 138390 AND `ScriptName` = 'spell_alpha_male_eff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (138390, 'spell_alpha_male_eff');
DELETE FROM `spell_script_names` WHERE `spell_id` = 138769 AND `ScriptName` = 'spell_trihorn_charge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (138769, 'spell_trihorn_charge');
DELETE FROM `spell_script_names` WHERE `spell_id` = 138859 AND `ScriptName` = 'spell_kill_dohaman';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (138859, 'spell_kill_dohaman');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144145 AND `ScriptName` = 'spell_spirit_world';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144145, 'spell_spirit_world');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144385 AND `ScriptName` = 'spell_timeless_isle_crane_wings';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144385, 'spell_timeless_isle_crane_wings');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144470 AND `ScriptName` = 'spell_chi_ji_crane_rush';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144470, 'spell_chi_ji_crane_rush');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144475 AND `ScriptName` = 'spell_chi_ji_beacon_of_hope';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144475, 'spell_chi_ji_beacon_of_hope');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144545 AND `ScriptName` = 'spell_yulon_jadefire_bolt_selector';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144545, 'spell_yulon_jadefire_bolt_selector');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144608 AND `ScriptName` = 'spell_niuzao_charge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144608, 'spell_niuzao_charge');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144610 AND `ScriptName` = 'spell_niuzao_headbutt';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144610, 'spell_niuzao_headbutt');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144634 AND `ScriptName` = 'spell_xuen_ti_crackling_lightning';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144634, 'spell_xuen_ti_crackling_lightning');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144642 AND `ScriptName` = 'spell_xuen_ti_chi_barrage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144642, 'spell_xuen_ti_chi_barrage');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144688 AND `ScriptName` = 'spell_ordos_magma_crush';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144688, 'spell_ordos_magma_crush');
DELETE FROM `spell_script_names` WHERE `spell_id` = 144689 AND `ScriptName` = 'spell_ordos_burning_soul';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144689, 'spell_ordos_burning_soul');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146236 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146236, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146237 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146237, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146238 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146238, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146239 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146239, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146240 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146240, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146241 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146241, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146242 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146242, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146243 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146243, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146244 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146244, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146246 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146246, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146259 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146259, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146260 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146260, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146261 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146261, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146263 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146263, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146264 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146264, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146265 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146265, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146266 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146266, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146267 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146267, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146268 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146268, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146269 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146269, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146270 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146270, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146271 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146271, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146272 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146272, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146273 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146273, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146274 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146274, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146275 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146275, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146276 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146276, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146277 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146277, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146278 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146278, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146279 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146279, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146280 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146280, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146281 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146281, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146282 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146282, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146283 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146283, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 146349 AND `ScriptName` = 'spell_catch_grain';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (146349, 'spell_catch_grain');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147226 AND `ScriptName` = 'spell_book_of_the_ages';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147226, 'spell_book_of_the_ages');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147597 AND `ScriptName` = 'spell_create_timeless_item_from_cache';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147597, 'spell_create_timeless_item_from_cache');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147649 AND `ScriptName` = 'spell_timelesscat_pounce';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147649, 'spell_timelesscat_pounce');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147650 AND `ScriptName` = 'spell_cat_defensive_leap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147650, 'spell_cat_defensive_leap');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147655 AND `ScriptName` = 'spell_gulp_frog_toxin';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147655, 'spell_gulp_frog_toxin');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147678 AND `ScriptName` = 'spell_eternitys_embrace';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147678, 'spell_eternitys_embrace');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147703 AND `ScriptName` = 'spell_timeless_isle_burning_fury';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147703, 'spell_timeless_isle_burning_fury');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147812 AND `ScriptName` = 'spell_evermaw_time_portals';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147812, 'spell_evermaw_time_portals');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147841 AND `ScriptName` = 'spell_evermaw_time_portals';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147841, 'spell_evermaw_time_portals');
DELETE FROM `spell_script_names` WHERE `spell_id` = 147997 AND `ScriptName` = 'spell_timeless_isle_cauterize';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (147997, 'spell_timeless_isle_cauterize');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148099 AND `ScriptName` = 'spell_create_timeless_item_from_cache';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148099, 'spell_create_timeless_item_from_cache');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148103 AND `ScriptName` = 'spell_create_timeless_item_from_cache';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148103, 'spell_create_timeless_item_from_cache');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148104 AND `ScriptName` = 'spell_create_timeless_item_from_cache';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148104, 'spell_create_timeless_item_from_cache');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148385 AND `ScriptName` = 'spell_bloody_coin_proc';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148385, 'spell_bloody_coin_proc');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148385 AND `ScriptName` = 'spell_censer_of_eternal_agony';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148385, 'spell_censer_of_eternal_agony');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148429 AND `ScriptName` = 'spell_bloody_coin_proc';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148429, 'spell_bloody_coin_proc');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148740 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148740, 'spell_create_timeless_item');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148746 AND `ScriptName` = 'spell_create_timeless_item';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148746, 'spell_create_timeless_item');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 7503 AND `ScriptName` = 'at_the_arcanic_oubliette';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (7503, 'at_the_arcanic_oubliette');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8080 AND `ScriptName` = 'AreaTrigger_q31087';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8080, 'AreaTrigger_q31087');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8123 AND `ScriptName` = 'at_q_wood_and_shade';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8123, 'at_q_wood_and_shade');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8124 AND `ScriptName` = 'at_q_wood_and_shade';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8124, 'at_q_wood_and_shade');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8169 AND `ScriptName` = 'AreaTrigger_q31185';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8169, 'AreaTrigger_q31185');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8230 AND `ScriptName` = 'AreaTrigger_q31185';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8230, 'AreaTrigger_q31185');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8231 AND `ScriptName` = 'AreaTrigger_q31185';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8231, 'AreaTrigger_q31185');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8262 AND `ScriptName` = 'AreaTrigger_cavern_of_endless_echoes';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8262, 'AreaTrigger_cavern_of_endless_echoes');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8263 AND `ScriptName` = 'AreaTrigger_cavern_of_endless_echoes';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8263, 'AreaTrigger_cavern_of_endless_echoes');
DELETE FROM `areatrigger_scripts` WHERE `entry` = 9509 AND `ScriptName` = 'at_path_to_ordos';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (9509, 'at_path_to_ordos');

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 50332;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50332, 0, 0, 'I am seeing red!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50333;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50333, 0, 0, 'You have woken the bull, now face the horns!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50336;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50336, 0, 0, 'You! What are you doing here?', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50341;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50341, 0, 0, 'Feel the fist of darkness!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50344;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50344, 0, 0, 'Your end is near.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50791;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50791, 0, 0, 'I will wear your skin as a hat!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50820;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50820, 0, 0, 'I must give in to the anger! It is the only way!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50831;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50831, 0, 0, 'Gonna hit you in the wikket!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 50832;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(50832, 0, 0, 'You has ook for brains!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 55597;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(55597, 0, 0, 'Na Lek imbues $p with gratitude and returns to the waters of the pool.', 16, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 56723;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(56723, 0, 0, 'Where are we? We were... swarming?!', 12, 0, 100, 0, 0, 0, ''),
(56723, 0, 1, 'What is happening? Why do we swarm so soon?', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 57120;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(57120, 0, 0, 'Oh, I don\'t know. I am old, and I have always...', 12, 0, 100, 0, 0, 0, ''),
(57120, 1, 0, 'Look out! Mantid!', 14, 0, 100, 0, 0, 0, ''),
(57120, 2, 0, 'I\'ve reconsidered... it\'s too dangerous to stay here. No piece of land is worth losing your life over. Let me see those evacuation orders.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 57121;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(57121, 0, 0, 'That\'s right. Now please, $r, leave and let us defend our property.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 57122;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(57122, 0, 0, 'Pshh... outsiders. You know nothing about the Stoneplow way.', 12, 0, 100, 0, 0, 0, ''),
(57122, 1, 0, 'We\'re proud. We\'re strong. We are descended from the blood of the Tiller himself... and we don\'t run from trouble.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 57681;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(57681, 0, 0, 'You have no idea how long I was in there.', 12, 0, 100, 0, 0, 0, ''),
(57681, 0, 1, 'Thanks!', 12, 0, 100, 0, 0, 0, ''),
(57681, 0, 2, 'Better get out of here before he comes by again!', 12, 0, 100, 0, 0, 0, ''),
(57681, 0, 3, 'I suppose there are worse fates than being stuck forever inside a beer barrel.', 12, 0, 100, 0, 0, 0, ''),
(57681, 0, 4, 'Ach! The light... it hurts our eyes...', 12, 0, 100, 0, 0, 0, ''),
(57681, 0, 5, 'Finally!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 58224;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58224, 0, 0, 'You fail to bend the knee to our power? Then die like the vermin you are.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 58666;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58666, 0, 0, 'KOR! NOOOOOOOO!', 14, 0, 100, 0, 0, 0, ''),
(58666, 1, 0, 'I think we have both lost enough today, old elf. See to your dead.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 58745;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58745, 0, 0, 'And now for the moment of truth.', 12, 0, 100, 0, 0, 0, ''),
(58745, 1, 0, 'Aaaaaaaaahhh!', 14, 0, 100, 0, 0, 0, ''),
(58745, 2, 0, 'That... hurt...', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 58955;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58955, 0, 0, 'The mogu ambushed us while we were trying to retreat from the mantid.', 12, 0, 100, 0, 0, 0, ''),
(58955, 0, 1, 'I must get to Stoneplow! The mantid will attack soon.', 12, 0, 100, 0, 0, 0, ''),
(58955, 0, 2, 'Thank you, hero.', 12, 0, 100, 0, 0, 0, ''),
(58955, 0, 3, 'Thank you, stranger.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 60408;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(60408, 0, 0, 'She is trying to throw you off, hold on tight!$b$b|TInterface\\Icons\\inv_misc_desecrated_leatherglove.blp:32|t Hold On', 42, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 60491;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(60491, 0, 0, 'My fury is UNLEASHED!', 14, 0, 100, 0, 0, 29011, 'Sha of anger 1'),
(60491, 1, 0, 'Feed me with your ANGER!', 14, 0, 100, 0, 0, 29010, 'Sha of anger 2'),
(60491, 2, 0, 'Feel your rage!', 14, 0, 100, 0, 0, 29003, 'Sha of anger 3'),
(60491, 3, 0, 'Give in to your anger!', 14, 0, 100, 0, 0, 29005, 'Sha of anger 4'),
(60491, 4, 0, 'Extinguished!', 14, 0, 100, 0, 0, 29001, 'sha of anger 5'),
(60491, 5, 0, 'Yes, YES! Bring your rage to bear! Try to strike me down!', 14, 0, 100, 0, 0, 28999, 'sha of anger 6');
DELETE FROM `creature_text` WHERE `entry` = 61055;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61055, 0, 0, 'Your pitiful rituals are meaningless! I will not be saved!', 14, 0, 100, 0, 0, 31309, ''),
(61055, 1, 0, 'Has Ban sent you to kill me, then? Just like he killed my husband?', 12, 0, 100, 0, 0, 31308, ''),
(61055, 2, 0, 'I see now... my hatred... consumed me. Tell Ban... all is... forgiven.', 12, 0, 100, 0, 0, 31311, '');
DELETE FROM `creature_text` WHERE `entry` = 61305;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61305, 0, 0, 'LOREWALKER! You have something of mine.', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 61315;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(61315, 0, 0, 'The binding should only take a moment, but I\'ll be completely entranced.', 12, 0, 100, 0, 0, 0, ''),
(61315, 1, 0, 'Watch my back - I trust you can handle any interruptions.', 12, 0, 100, 0, 0, 0, ''),
(61315, 2, 0, 'All done. Did I miss anything?', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 62220;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(62220, 0, 0, 'Demand?! You DEMAND?!', 14, 0, 100, 0, 0, 0, ''),
(62220, 1, 0, 'Who are YOU to make demands of the SHADO-PAN?', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64312;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64312, 0, 0, 'Hmmm, I reckon I don\'t know, $r. All I can understand is the part about the valley - that\'s right here! The Valley of the Four Winds!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64313;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64313, 0, 0, 'The maiden, eh? Hmm, I remember that\'s what my father used to call that river to the north. Other than that, I wouldn\'t have the slightest clue.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64315;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64315, 0, 0, 'Oh, I HAVE heard of the ancestors\' stair. That\'s what some folks call those mountains to the north.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64327;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64327, 0, 0, 'What echoes and what\'s dark? It\'s simple! A cave!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64347;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64347, 0, 0, 'Wow! I never knew this was back here.', 12, 0, 100, 0, 0, 0, ''),
(64347, 1, 0, 'Jumping jackhoppers! We found it! We really found it! It\'s Old Man Thistle\'s hidden treasure! Oh boy oh boy oh boy!!!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64389;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64389, 0, 0, 'Mmmmm! I smell a delicious sheep!', 14, 0, 100, 0, 0, 0, ''),
(64389, 1, 0, 'Time to munch on some mutton!', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 64528;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64528, 0, 0, 'Ah, another stranger from beyond the mists.', 12, 0, 100, 396, 0, 29030, ''),
(64528, 1, 0, 'Ten thousand years ago, the last Pandaren Emperor came seeking my advice. He, too, was filled with conflict. Let us see if you are correct, Taran. Let us see how this stranger deals with turmoil of the soul.', 12, 0, 100, 396, 0, 29031, ''),
(64528, 2, 0, 'We can agree it is noble to fight for a righteous cause: to defend home or family. But what of vengeance? What of anger? I sense these emotions run deep in this one.', 12, 0, 100, 396, 0, 29033, ''),
(64528, 3, 0, 'Well spoken, Zhi. The strangers from beyond the mists have no shortage of passions, but let us see if they indeed control them. Beyond anger lies hatred, the wellspring of all misery. What is this? Your hatred has a face!', 12, 0, 100, 396, 0, 29035, ''),
(64528, 4, 0, 'This one has indeed proven mastery over anger. Between the young cub\'s words and the actions of this hero, I think I understand. Those from beyond the mists are hardened by battle. They are scarred, yes, but they have learned much. I trust them.', 12, 0, 100, 396, 0, 29037, '');
DELETE FROM `creature_text` WHERE `entry` = 66260;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(66260, 0, 0, 'My assistant will show you to Master Cheng.  Good Luck!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 66791;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(66791, 0, 0, 'Treasonous Klaxxi... her magnificence was right about you.', 14, 0, 100, 1, 0, 29295, ''),
(66791, 1, 0, 'Grand Vizier Zor\'lok, voice of the Empress.', 14, 0, 100, 6, 0, 29296, ''),
(66791, 2, 0, 'The Klaxxi are to be disbanded, by the will of the Empress.', 14, 0, 100, 0, 0, 29297, ''),
(66791, 3, 0, 'The desperate Klaxxi have resorted to digging up fossils. Very well: let us finish this.', 14, 0, 100, 1, 0, 29298, ''),
(66791, 4, 0, '\"Unscathed,\" indeed.', 14, 0, 100, 1, 0, 29299, ''),
(66791, 5, 0, 'Forward! The Klaxxi reveal themselves as traitors. Decimate them, and leave nothing behind.', 14, 0, 100, 1, 0, 29300, '');
DELETE FROM `creature_text` WHERE `entry` = 66797;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(66797, 0, 0, 'Who holds this swarm? Show yourself! Answer to the Klaxxi.', 14, 0, 100, 6, 0, 30910, ''),
(66797, 1, 0, 'Speak your name puppet, that our annals will be complete.', 14, 0, 100, 396, 0, 30911, ''),
(66797, 2, 0, 'Your \"Empress\" has fallen. The Klaxxi have pronounced judgment. Stand aside or be brushed away.', 14, 0, 100, 0, 0, 30912, ''),
(66797, 3, 0, 'Blaspheme!', 14, 0, 100, 0, 0, 30913, '');
DELETE FROM `creature_text` WHERE `entry` = 66800;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(66800, 0, 0, 'Wakener, your deeds have earned you the trust of the Klaxxi.', 12, 0, 100, 0, 0, 30312, ''),
(66800, 1, 0, 'You are to be rewarded. Walk with me.', 12, 0, 100, 0, 0, 30313, ''),
(66800, 2, 0, 'We mantid are an elder race. The pandaren you associate with - they are but children. They have their role to play.', 12, 0, 100, 0, 0, 30314, ''),
(66800, 3, 0, 'Each cycle, our young swarm their walls. The pandaren slay the weak. The strong return.', 12, 0, 100, 0, 0, 30315, ''),
(66800, 4, 0, 'With each generation, we grow ever stronger.', 12, 0, 100, 0, 0, 30316, ''),
(66800, 5, 0, 'Before your history began, our empire was vast. We shared this world with our sister kingdoms, Ahn\'Qiraj and Azjol-Nerub.', 12, 0, 100, 0, 0, 30317, ''),
(66800, 6, 0, 'Our Gods were many, and powerful. We mantid worshipped the seven heads of Y\'shaarj.', 12, 0, 100, 0, 0, 30318, ''),
(66800, 7, 0, 'Great was the Old One, and terrible was His wrath. He consumed hope and begat despair; He inhaled courage and breathed fear.', 12, 0, 100, 0, 0, 30319, ''),
(66800, 8, 0, 'When the usurpers came - the ones you call \"Titans\" - Y\'shaarj was destroyed.', 12, 0, 100, 0, 0, 30320, ''),
(66800, 9, 0, 'His last terrible breath has haunted this land ever since, but the shadows he left behind are mere whispers of his former glory.', 12, 0, 100, 0, 0, 30321, ''),
(66800, 10, 0, 'I tell you now, because you have earned this warning.', 12, 0, 100, 0, 0, 30322, ''),
(66800, 11, 0, 'Your gods are not our gods, outsider.', 12, 0, 100, 0, 0, 30323, ''),
(66800, 12, 0, 'If the Old Ones ever return, we mantid will once again stand by their side.', 12, 0, 100, 0, 0, 30324, ''),
(66800, 13, 0, 'The wisest among you will do the same.', 12, 0, 100, 0, 0, 30325, '');
DELETE FROM `creature_text` WHERE `entry` = 66844;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(66844, 0, 0, 'Follow me and I will show you around the Peak of Serenity.', 12, 0, 100, 0, 0, 0, ''),
(66844, 1, 0, 'Don\'t forget to take it all in while you\'re here.  The Peak of Serenity has a wonderful view of beautiful Kun-Lai summit.', 12, 0, 100, 0, 0, 0, ''),
(66844, 2, 0, 'Here, you\'ll find several of us who have mastered the art of various crafts.  If you need any supplies along your journey, they can probably help.', 12, 0, 100, 0, 0, 0, ''),
(66844, 3, 0, 'This is the Training Ground, where most of your training will take place.  Come, I will introduce you to the masters who will be teaching you.', 12, 0, 100, 0, 0, 0, ''),
(66844, 4, 0, 'This is Master Kistane, she is a master in the art of channeling the mists to assist her and her allies.', 12, 0, 100, 0, 0, 0, ''),
(66844, 5, 0, 'This is Master Woo.  She specializes in defense against persistent attacks.', 12, 0, 100, 0, 0, 0, ''),
(66844, 6, 0, 'This is Master Yoon.  He is practiced in using powerful, focused healing to maintain himself in battle.', 12, 0, 100, 0, 0, 0, ''),
(66844, 7, 0, 'This is Master Cheng.  She has mastered the art of fighting on the move.', 12, 0, 100, 0, 0, 0, ''),
(66844, 8, 0, 'This is Master Tsang.  He is a master of meditation and the ability to sense what is happening around him.', 12, 0, 100, 0, 0, 0, ''),
(66844, 9, 0, 'This is Master Hsu.  He specializes in using all kinds of weaponry and is masterfully proficient with nearly any weapon under the sun.', 12, 0, 100, 0, 0, 0, ''),
(66844, 10, 0, 'And finally, this is Master Cheng.  Master Cheng focuses on reflex and swift motion and will help you begin your training.', 12, 0, 100, 0, 0, 0, ''),
(66844, 11, 0, 'And with that, I must depart.  Good luck with your training.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 67801;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(67801, 0, 0, 'CANNONBALL!!', 12, 0, 100, 0, 0, 0, ''),
(67801, 1, 0, 'For Theramore!', 12, 0, 100, 0, 0, 0, ''),
(67801, 2, 0, 'Monsters... all of yeh... *sputter*', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 67833;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(67833, 0, 0, 'The Mercurial Guardian comes to life!', 41, 0, 100, 0, 0, 0, ''),
(67833, 1, 0, 'The Mercurial Guardian\'s skin becomes as hard as silver!', 41, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 67834;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(67834, 0, 0, 'If I am correct, $n, then this... Divine Bell... is exactly the type of weapon that Garrosh is looking for. Return to your other duties for now. I will bring this information to the Warchief myself.', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 68088;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(68088, 0, 0, 'Here! Stop the boats here.', 14, 0, 100, 0, 0, 34241, ''),
(68088, 1, 0, 'This island will make a perfect coastal stronghold. Rokla! When the peons arrive, clear these trees and begin construction of the docks.', 12, 0, 100, 1, 0, 34242, ''),
(68088, 2, 0, 'Champion, you have been here for many weeks, and know this land well. Come with me.', 12, 0, 100, 25, 0, 34243, '');
DELETE FROM `creature_text` WHERE `entry` = 68514;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(68514, 0, 0, 'There\'s my survey team. Bring us in.', 14, 0, 100, 0, 0, 34681, ''),
(68514, 1, 0, 'What\'s the situation?', 12, 0, 100, 547, 0, 34682, ''),
(68514, 2, 0, 'The Horde?', 12, 0, 100, 6, 0, 34683, ''),
(68514, 3, 0, 'Hmm... Troteman may have gotten himself in over his head. We\'ll split up.', 12, 0, 100, 396, 0, 34684, ''),
(68514, 4, 0, 'Lynna, stay here and establish a camp. Your first priority should be medical tents and shelters. When the peasants arrive, see that they begin construction of the docks.', 12, 0, 100, 397, 0, 34685, ''),
(68514, 5, 0, 'Hornswaggle, notify the rest of the survey team. Quarry and mining operations will begin as soon as the fleet arrives.', 12, 0, 100, 396, 0, 34686, ''),
(68514, 6, 0, 'Champion, you know this land better than anyone. You\'re with me. Let\'s go find Troteman.', 12, 0, 100, 396, 0, 34687, '');
DELETE FROM `creature_text` WHERE `entry` = 68519;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(68519, 0, 0, 'Yer Highness! This site has everything we need. Lumber, stone and-', 12, 0, 100, 396, 0, 34244, ''),
(68519, 1, 0, 'Marshal Troteman and a handful o\' scouts pursued a Horde warband up the beach. They haven\'t come back.', 12, 0, 100, 396, 0, 34245, ''),
(68519, 2, 0, 'Yes, Yer Majesty!', 12, 0, 100, 113, 0, 34246, '');
DELETE FROM `creature_text` WHERE `entry` = 71869;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71869, 0, 0, 'Good deal. Welcome to the spirit world. Kinda. Let\'s check out the chests for any goodies, and see if you can find my body somewhere!', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 0, 'I thought about askin\' her out but I didn\'t have the guts.', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 1, 'What kind of spirit haunts a chicken coop? A poultry geist!', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 2, 'I\'m not THAT snarky, am I?', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 3, 'Want to hear somethin\' funny? Coccyx.', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 4, 'Sorry for ribbin\' ya so much.', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 5, 'Sticks and stones may break my bones...', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 6, 'Who just called me a numbskull?', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 7, 'I love you wit\' every bone in my body!', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 8, 'I\'m not sure I have the stomach for this...', 12, 0, 100, 0, 0, 0, ''),
(71869, 1, 9, 'I know my jokes ain\'t so good... I lost my funny bone!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 71876;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71876, 0, 0, 'Hey, meat sack! If you got five minutes, come talk to me! I got no body!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 71952;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71952, 0, 0, 'Then let us begin.', 14, 0, 100, 0, 0, 38024, ''),
(71952, 1, 0, 'When faced with challenges the like you have never seen, what do you hope for? What is the future you seek?', 14, 0, 100, 0, 0, 38026, ''),
(71952, 2, 0, 'Your hope shines brightly, and even more brightly when you work together to overcome. It will ever light your way in even the darkest of places.', 14, 0, 100, 0, 0, 38025, ''),
(71952, 3, 0, 'Do not give up on yourself!', 14, 0, 100, 0, 0, 38027, ''),
(71952, 4, 0, 'Believe in one another, and let others carry hope for you!', 14, 0, 100, 0, 0, 38028, ''),
(71952, 5, 0, 'Without hope, there is no brightness in the future!', 14, 0, 100, 0, 0, 38029, ''),
(71952, 6, 0, 'Create the destiny you seek!', 14, 0, 100, 0, 0, 38030, '');
DELETE FROM `creature_text` WHERE `entry` = 71953;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71953, 0, 0, 'Ha ha! The trial commences!', 14, 0, 100, 0, 0, 38211, ''),
(71953, 1, 0, 'Strength. It is far more than simple physical prowess. When you are truly tested, will you be able to tell the difference between strength and power?', 14, 0, 100, 0, 0, 38213, ''),
(71953, 2, 0, 'You are strong, stronger even than you realize. Carry this thought with you into the darkness ahead, and let it shield you.', 14, 0, 100, 0, 0, 38212, ''),
(71953, 3, 0, 'Return twice as powerful!', 14, 0, 100, 0, 0, 38214, ''),
(71953, 4, 0, 'Believe in your strength!', 14, 0, 100, 0, 0, 38215, ''),
(71953, 5, 0, 'You have the power to change your destiny!', 14, 0, 100, 0, 0, 38216, ''),
(71953, 6, 0, 'Do not mistake the power that darkness offers for true strength!', 14, 0, 100, 0, 0, 38217, '');
DELETE FROM `creature_text` WHERE `entry` = 71954;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71954, 0, 0, 'Today, you will face many trainers, who have honed their skills and proven themselves.  Will your pets tell the same story about you?  We shall see!  Good luck!', 14, 0, 100, 0, 0, 38032, ''),
(71954, 1, 0, 'Can you stand on the tallest peak, winds and sleet buffeting your skin, until the trees wither and the mountains fall into the sea?', 14, 0, 100, 0, 0, 38757, ''),
(71954, 2, 0, 'Though you will be surrounded by foes greater than you can imagine, your fortitude shall allow you to endure. Remember this in the times ahead.', 14, 0, 100, 0, 0, 38756, ''),
(71954, 3, 0, 'You must persevere!', 14, 0, 100, 0, 0, 38758, ''),
(71954, 4, 0, 'The winds may be strong, and the sleet may sting.', 14, 0, 100, 0, 0, 38759, ''),
(71954, 5, 0, 'You are the mountain, unmovable by all but time.', 14, 0, 100, 0, 0, 38760, ''),
(71954, 6, 0, 'Be vigilent in your stand, or you will never achieve your goals.', 14, 0, 100, 0, 0, 38761, '');
DELETE FROM `creature_text` WHERE `entry` = 71955;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71955, 0, 0, 'The trial begins!', 14, 0, 100, 0, 0, 38222, ''),
(71955, 1, 0, 'The lesson of true wisdom lies within you dear heroes, and in the choices you make. When faced with overwhelming darkness, will you make the right decisions?', 14, 0, 100, 0, 0, 38224, ''),
(71955, 2, 0, 'Your wisdom has seen you through this trial. May it ever light your way out of dark places.', 14, 0, 100, 0, 0, 38223, ''),
(71955, 3, 0, 'Learn from your mistakes!', 14, 0, 100, 0, 0, 38225, ''),
(71955, 4, 0, 'Listen to your inner voice, and seek out the truth!', 14, 0, 100, 0, 0, 38226, ''),
(71955, 5, 0, 'Do not let your judgement be clouded in trying times!', 14, 0, 100, 0, 0, 38227, ''),
(71955, 6, 0, 'Always consider the consequences of your actions!', 14, 0, 100, 0, 0, 38228, '');
DELETE FROM `creature_text` WHERE `entry` = 71987;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(71987, 0, 0, 'Ooo oOOo ooOoO', 12, 0, 100, 0, 0, 0, ''),
(71987, 0, 1, 'ooo OoOooO oo', 12, 0, 100, 0, 0, 0, ''),
(71987, 0, 2, 'o OOooO OoooO', 12, 0, 100, 0, 0, 0, ''),
(71987, 0, 3, 'oOO OOooO', 12, 0, 100, 0, 0, 0, '');
-- 72057 : replaces SkyFire's 7 rows (different groups) with LoA's 10
DELETE FROM `creature_text` WHERE `entry` = 72057;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(72057, 0, 0, 'You will take my place on the eternal brazier.', 14, 0, 100, 0, 0, 38971, 'Ordos Aggro'),
(72057, 1, 0, 'My pain... is endless...', 14, 0, 100, 0, 0, 38974, 'Ordos Intro 2'),
(72057, 2, 0, 'The flames... never cease...', 14, 0, 100, 0, 0, 38975, 'Ordos Intro 3'),
(72057, 3, 0, 'I burn... for all time...', 14, 0, 100, 0, 0, 38976, 'Ordos Intro 4'),
(72057, 4, 0, 'The eternal fire will never be extinguished.', 14, 0, 100, 0, 0, 38972, 'Ordos Death'),
(72057, 5, 0, 'Up in smoke.', 14, 0, 100, 0, 0, 38977, 'Ordos Kill'),
(72057, 6, 0, 'You will feel but a fraction of my agony.', 14, 0, 100, 0, 0, 38980, 'Ordos - Pool of Fire'),
(72057, 7, 0, 'Your flesh will melt.', 14, 0, 100, 0, 0, 38978, 'Ordos - Ancient Flame'),
(72057, 8, 0, 'Burn!', 14, 0, 100, 0, 0, 38981, 'Ordos - Burning Soul'),
(72057, 9, 0, 'Your pain will be endless.', 14, 0, 100, 0, 0, 38979, 'Ordos - Eternal Agony');
DELETE FROM `creature_text` WHERE `entry` = 72151;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(72151, 0, 0, 'Almost... got... it...', 12, 0, 100, 0, 0, 0, ''),
(72151, 1, 0, 'Well that was unexpected!', 12, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 72970;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(72970, 0, 0, 'The eons have awakened me.', 14, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 73303;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(73303, 0, 0, 'Long ago, the Jade Serpent instructed me to purify my spirit and become one with the land, my doubts were vanquished.', 14, 0, 100, 0, 0, 38036, 'Emperor Shaohao - Yulon Intro'),
(73303, 1, 0, 'When my journey began, I was reckless in my strength. The White Tiger taught me control. My hatred, anger, and violence were vanquished.', 14, 0, 100, 0, 0, 38037, 'Emperor Shaohao - Xuen Intro'),
(73303, 2, 0, 'The Red Crane saw hope in me, and instructed me to look inward. Despite my visage of despair, I found this hope, and the despair was vanquished.', 14, 0, 100, 0, 0, 38038, 'Emperor Shaohao - Chi-Ji'),
(73303, 3, 0, 'In the face of great fear, the Black Ox taught me fortitude. Through terror and darkness it persevered. The fear was vanquished.', 14, 0, 100, 0, 0, 38039, 'Emperor Shaohao - Niuzao'),
(73303, 4, 0, 'You have walked the trial of wisdom, and learned of the path of the Jade Serpent. May you learn from this lesson, as I did.', 14, 0, 100, 0, 0, 38040, 'Emperor Shaohao - Yulon Outro'),
(73303, 5, 0, 'You have walked the trial of strength, and learned of the path of the White Tiger. May you remember this lesson, always.', 14, 0, 100, 0, 0, 38041, 'Emperor Shaohao - Xuen Outro'),
(73303, 6, 0, 'You have walked the trial of hope, and learned of the path of the Red Crane. May it guide your footsteps through time.', 14, 0, 100, 0, 0, 38042, 'Emperor Shaohao - Red Crane Outro'),
(73303, 7, 0, 'You have walked the trial of fortitude, and learned of the path of the Black Ox. May it bless your passage.', 14, 0, 100, 0, 0, 38043, 'Emperor Shaohao - Niuzao Outro'),
(73303, 8, 0, 'Welcome to a very special trial!  The wisdom of a leader is reflected in the greatness of his followers. Let us see if your training has truly inspired those you lead...', 14, 0, 100, 0, 0, 38044, 'Emperor Shaohao - Intro');
DELETE FROM `creature_text` WHERE `entry` = 73666;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(73666, 0, 0, 'Your challenge has been answered, outsider. Ordon, claim this area in the name of the Burning God!', 14, 0, 100, 0, 0, 0, '');

-- Spell area triggers and scenes the scripts register (LoA rows)
-- spell_areatrigger_template: sat_vfw_ground_and_pound
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 426;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (426, 0, 1, 2, 0, 0, 'sat_vfw_ground_and_pound');
-- spell_areatrigger_template: sat_gift_of_chi_ji
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 453;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (453, 0, 1, 4, 4, 4, 'sat_gift_of_chi_ji');
-- spell_areatrigger_template: sat_yulon_jadefire_wall
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1087;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1087, 0, 1, 15, 0, 0, 'sat_yulon_jadefire_wall');
-- spell_areatrigger_template: sat_ordos_pool_of_fire
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1090;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1090, 0, 1, 15, 0, 0, 'sat_ordos_pool_of_fire');
-- spell_areatrigger_template: sat_sprite_ward
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1232;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1232, 0, 0, 15, 15, 15, 'sat_sprite_ward');
-- spell_areatrigger_template: sat_evermaw_time_lock
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1305;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1305, 0, 1, 3, 0, 0, 'sat_evermaw_time_lock');
-- spell_areatrigger_template: sat_fire_blossom
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1306;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1306, 0, 1, 11, 0, 0, 'sat_fire_blossom');
-- spell_areatrigger_template: sat_storm_blossom
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1307;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1307, 0, 1, 11, 0, 0, 'sat_storm_blossom');
-- spell_areatrigger_template: sat_evermaw_time_rift
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1311;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1311, 0, 1, 3, 0, 0, 'sat_evermaw_time_rift');
-- spell_areatrigger_template: sat_evermaw_devour
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1312;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1312, 0, 1, 60, 0, 0, 'sat_evermaw_devour');
-- spell_areatrigger_template: sat_burning_pitch
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 1320;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES (1320, 0, 0, 3.5, 5, 5, 'sat_burning_pitch');
-- scene_template: scene_lorewalker_stories
DELETE FROM `scene_template` WHERE `SceneId` = 28;
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`, `ScriptName`) VALUES (28, 0, 179, 'scene_lorewalker_stories');
-- scene_template: scene_klaxxi_head_explosion
DELETE FROM `scene_template` WHERE `SceneId` = 72;
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`, `ScriptName`) VALUES (72, 0, 212, 'scene_klaxxi_head_explosion');
-- scene_template: scene_memory_wine
DELETE FROM `scene_template` WHERE `SceneId` = 137;
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`, `ScriptName`) VALUES (137, 0, 300, 'scene_memory_wine');
-- scene_template: scene_why_do_we_fight
DELETE FROM `scene_template` WHERE `SceneId` = 244;
INSERT INTO `scene_template` (`SceneId`, `Flags`, `ScriptPackageID`, `ScriptName`) VALUES (244, 25, 524, 'scene_why_do_we_fight');

-- Crane Wings (144385, Gleaming Crane Statue): its feather-fall aura script is spell_crane_wings (rewards the
-- Mist-Covered Treasure Chest quest on removal). LoA binds 144385 and 26013 to spell_timeless_isle_crane_wings, whose
-- stun hooks match neither spell, so the core never ran it.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_timeless_isle_crane_wings', 'spell_crane_wings');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (144385, 'spell_crane_wings');

-- Sha of Anger: #129 (D19) cleared this binding while the script did not exist; boss_sha_of_anger.cpp now registers it.
UPDATE `creature_template` SET `ScriptName` = 'boss_sha_of_anger' WHERE `entry` = 60491;

-- Townlong Steppes: LoA's condition for spell 122523 (burn the mantid corpse), checked by cond_burn_mantid_corpse
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 122523 AND `ConditionTypeOrReference` = 29 AND `ScriptName` = 'cond_burn_mantid_corpse';
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (17,0,122523,0,0,29,0,62128,7,0,1,0,0,'cond_burn_mantid_corpse',NULL);
