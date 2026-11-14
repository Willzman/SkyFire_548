-- Instance DB audit (tools/InstanceAudit.pl in the port plan): data the LoA world DB has for these instances and
-- Development did not. SkyFire's own values are kept wherever it had any (see the PR text for the rules).

-- ==========================================================================
-- Mogu'shan Vaults (map 1008)
-- ==========================================================================
UPDATE `instance_template` SET `allowMount` = 1 WHERE `map` = 1008;

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `dmg_multiplier` = 2 WHERE `entry` = 59915; -- Jasper Guardian
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 60009; -- Feng the Accursed
UPDATE `creature_template` SET `dmg_multiplier` = 2 WHERE `entry` = 60043; -- Jade Guardian
UPDATE `creature_template` SET `dmg_multiplier` = 2 WHERE `entry` = 60051; -- Cobalt Guardian
UPDATE `creature_template` SET `unit_flags` = 60081, `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 60089; -- Stone Guard Controller
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 60143; -- Gara\'jal the Spiritbinder
UPDATE `creature_template` SET `unit_class` = 1 WHERE `entry` = 60184; -- Shadowy Minion
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `npcflag` = 16777216 WHERE `entry` = 60304; -- Living Cobalt Crystal
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `npcflag` = 16777216 WHERE `entry` = 60306; -- Living Jade Crystal
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `npcflag` = 16777216 WHERE `entry` = 60307; -- Living Jasper Crystal
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `npcflag` = 16777216 WHERE `entry` = 60308; -- Living Amethyst Crystal
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `VehicleId` = 2145, `InhabitType` = 4 WHERE `entry` = 60384; -- Zandalari Pterror Wing
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 60385; -- Zandalari War Wyvern
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `dmg_multiplier` = 4 WHERE `entry` = 60386; -- Zandalari Terror Rider
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60388; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60389; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60390; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60391; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60392; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60393; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60394; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60395; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `dmg_multiplier` = 4 WHERE `entry` = 60396; -- Emperor\'s Rage
UPDATE `creature_template` SET `mechanic_immune_mask` = 769638399, `VehicleId` = 2165 WHERE `entry` = 60397; -- Emperor\'s Strength
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `faction_A` = 16, `faction_H` = 16, `unit_class` = 2, `flags_extra` = 1, `VehicleId` = 2504 WHERE `entry` = 60399; -- Qin-xi
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `faction_A` = 16, `faction_H` = 16, `unit_class` = 2, `flags_extra` = 1, `VehicleId` = 2158 WHERE `entry` = 60400; -- Jan-xi
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854271, `flags_extra` = 1 WHERE `entry` = 60410; -- Elegon
UPDATE `creature_template` SET `flags_extra` = 0, `InhabitType` = 4 WHERE `entry` = 60438; -- Wildfire Spark
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 60480; -- Titan Spark
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `VehicleId` = 2151 WHERE `entry` = 60512; -- Spirit Totem
UPDATE `creature_template` SET `minlevel` = 92, `faction_A` = 16, `faction_H` = 16, `unit_flags` = 256, `dmg_multiplier` = 3 WHERE `entry` = 60513; -- Spirit Totem
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 2 WHERE `entry` = 60575; -- Terracotta Boss
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `flags_extra` = 0 WHERE `entry` = 60627; -- Siphoning Shield
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 614, `faction_H` = 614 WHERE `entry` = 60644; -- Troll Explosives
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `faction_A` = 14, `faction_H` = 14, `flags_extra` = 128 WHERE `entry` = 60648; -- Ancient Mogu Machine
UPDATE `creature_template` SET `unit_class` = 4 WHERE `entry` = 60708; -- Meng the Demented
UPDATE `creature_template` SET `mechanic_immune_mask` = 769636351 WHERE `entry` = 60710; -- Subetai the Swift
UPDATE `creature_template` SET `minlevel` = 93, `maxlevel` = 93, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 60768; -- Emperor\'s Strength
UPDATE `creature_template` SET `mechanic_immune_mask` = 769638399 WHERE `entry` = 60776; -- Empyreal Focus
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60781; -- Soul Fragment
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60833; -- Frenzied Stone Quilen
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 60940; -- Shadowy Minion
UPDATE `creature_template` SET `unit_flags` = 0, `dmg_multiplier` = 3 WHERE `entry` = 60960; -- Core Target Stalker
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 60984; -- Controller
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 61124; -- Phase Controller
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624, `unit_class` = 8 WHERE `entry` = 61131; -- Mogu\'shan Secret-Keeper
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624, `unit_class` = 8 WHERE `entry` = 61139; -- Shan-xi Watershaper
UPDATE `creature_template` SET `dmg_multiplier` = 3 WHERE `entry` = 61172; -- Gate to the Spirit World
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61250; -- Sorcerer Mogu
UPDATE `creature_template` SET `unit_flags` = 0, `dmg_multiplier` = 3 WHERE `entry` = 61330; -- Energy Vortex Stalker
UPDATE `creature_template` SET `mechanic_immune_mask` = 646659967 WHERE `entry` = 61334; -- Cursed Mogu Sculpture
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61341; -- Mounted Mogu
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61345; -- Mogu Archer
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61347; -- Kingsguard
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 61352; -- Story Time
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61421; -- Zian of the Endless Shadow
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61423; -- Qiang the Merciless
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 61427; -- Subetai the Swift
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2 WHERE `entry` = 61429; -- Meng the Demented
UPDATE `creature_template` SET `unit_flags` = 33554432, `mechanic_immune_mask` = 646659967 WHERE `entry` = 61989; -- Cursed Mogu Sculpture
UPDATE `creature_template` SET `unit_flags` = 0, `dmg_multiplier` = 1 WHERE `entry` = 62004; -- Ghost Essence
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624 WHERE `entry` = 64061; -- Mogu\'shan Warden
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624 WHERE `entry` = 64063; -- Mogu\'shan Arcanist
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624 WHERE `entry` = 64068; -- Mogu\'shan Engine Keeper
UPDATE `creature_template` SET `npcflag` = 16777216, `flags_extra` = 0 WHERE `entry` = 64526; -- Ancient Mogu Artifact
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 64529; -- Mogu Runes (Horizontal Visual)
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 64825; -- Leng Windstaff
UPDATE `creature_template` SET `mechanic_immune_mask` = 8388624 WHERE `entry` = 64947; -- Mogu\'shan Warden
UPDATE `creature_template` SET `unit_flags` = 0, `dmg_multiplier` = 1, `InhabitType` = 4 WHERE `entry` = 65297; -- Invisible Stalker
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 65343; -- Bone Spider

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 60143;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60143, 0, 0, 0, 1, 0, '115964');
DELETE FROM `creature_template_addon` WHERE `entry` = 60375;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60375, 0, 0, 8, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60384;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60384, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60396;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60396, 0, 0, 0, 1, 0, '116535');
DELETE FROM `creature_template_addon` WHERE `entry` = 60397;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60397, 0, 0, 0, 1, 0, '118165');
DELETE FROM `creature_template_addon` WHERE `entry` = 60398;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60398, 0, 0, 0, 1, 0, '118165');
DELETE FROM `creature_template_addon` WHERE `entry` = 60399;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60399, 0, 0, 0, 1, 0, '118357');
DELETE FROM `creature_template_addon` WHERE `entry` = 60400;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60400, 0, 0, 0, 1, 0, '117193');
DELETE FROM `creature_template_addon` WHERE `entry` = 60410;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60410, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60512;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60512, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60575;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60575, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60576;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60576, 0, 0, 0, 1, 0, '117838');
DELETE FROM `creature_template_addon` WHERE `entry` = 60648;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60648, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 60701;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60701, 0, 0, 0, 1, 0, '118205');
DELETE FROM `creature_template_addon` WHERE `entry` = 60708;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60708, 0, 0, 0, 1, 0, '117707');
DELETE FROM `creature_template_addon` WHERE `entry` = 60709;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60709, 0, 0, 0, 1, 0, '117920');
DELETE FROM `creature_template_addon` WHERE `entry` = 60710;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60710, 0, 0, 0, 2, 0, '118205');
DELETE FROM `creature_template_addon` WHERE `entry` = 60768;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60768, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 60776;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60776, 0, 0, 0, 1, 0, '127303');
DELETE FROM `creature_template_addon` WHERE `entry` = 60847;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60847, 0, 0, 50331648, 1, 0, '117904');
DELETE FROM `creature_template_addon` WHERE `entry` = 60958;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60958, 0, 0, 0, 1, 0, '118141');
DELETE FROM `creature_template_addon` WHERE `entry` = 61124;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61124, 0, 0, 0, 1, 0, '105032');
DELETE FROM `creature_template_addon` WHERE `entry` = 61131;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61131, 0, 0, 0, 1, 0, '123585');
DELETE FROM `creature_template_addon` WHERE `entry` = 61250;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61250, 0, 0, 0, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61330;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61330, 0, 0, 0, 1, 0, '118983');
DELETE FROM `creature_template_addon` WHERE `entry` = 61334;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61334, 0, 0, 0, 1, 0, '120661 120613');
DELETE FROM `creature_template_addon` WHERE `entry` = 61341;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61341, 0, 41441, 0, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61345;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61345, 0, 0, 0, 2, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61347;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61347, 0, 0, 0, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61352;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61352, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 61421;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61421, 0, 0, 33554432, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61423;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61423, 0, 0, 33554432, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61427;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61427, 0, 0, 33554432, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 61429;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (61429, 0, 0, 33554432, 1, 0, '119310');
DELETE FROM `creature_template_addon` WHERE `entry` = 62004;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62004, 0, 0, 0, 1, 0, '120681');
DELETE FROM `creature_template_addon` WHERE `entry` = 62026;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62026, 0, 0, 0, 1, 0, '116579');
DELETE FROM `creature_template_addon` WHERE `entry` = 64061;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64061, 0, 0, 0, 1, 0, '128741');
DELETE FROM `creature_template_addon` WHERE `entry` = 64063;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64063, 0, 0, 0, 1, 0, '123585');
DELETE FROM `creature_template_addon` WHERE `entry` = 64068;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64068, 0, 0, 0, 1, 0, '123585');
DELETE FROM `creature_template_addon` WHERE `entry` = 64526;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64526, 0, 0, 0, 0, 0, '126038');
DELETE FROM `creature_template_addon` WHERE `entry` = 64947;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64947, 0, 0, 0, 1, 0, '128412');
DELETE FROM `creature_template_addon` WHERE `entry` = 65297;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (65297, 0, 0, 50331648, 1, 0, '');

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 116711;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 116711, 0, 0, 31, 0, 3, 60438, 0, 0, 0, 0, '', 'Puiser dans les flammes (mogushan vault)');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 126022;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 126022, 0, 0, 31, 0, 3, 64526, 0, 0, 0, 0, '', 'Activate Artifact - targeting Ancient Mogu Artifact');

-- spell_linked_spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 115730 AND `spell_effect` = -118302 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (115730, -118302, 0, 'Reversal: Lightning Fists - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 116922 AND `spell_effect` = -118307 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (116922, -118307, 0, 'Reversal: Wildfire Spark - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 116936 AND `spell_effect` = -118300 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (116936, -118300, 0, 'Reversal: Epicenter - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 116938 AND `spell_effect` = -118305 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (116938, -118305, 0, 'Reversal: Arcane Veolcity - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 118194 AND `spell_effect` = -118304 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (118194, -118304, 0, 'Reversal: Arcane Resonance - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 118197 AND `spell_effect` = -118308 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (118197, -118308, 0, 'Reversal: Flaming Spear - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 132292 AND `spell_effect` = -132296 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (132292, -132296, 0, 'Reversal: Shadowburn - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 132293 AND `spell_effect` = -132297 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (132293, -132297, 0, 'Reversal: Lightning Lash - remove button on cast');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 132294 AND `spell_effect` = -132298 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (132294, -132298, 0, 'Reversal: Arcane Shock - remove button on cast');

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 60304;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(60304, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 60306;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(60306, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 60307;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(60307, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 60308;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(60308, 46598, 1, 0);
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 64526;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(64526, 126022, 1, 0);

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Ancient Control Console', `data3` = 0 WHERE `entry` = 211584;
UPDATE `gameobject_template` SET `name` = 'Terracotta Army Door', `faction` = 114 WHERE `entry` = 211603;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Nullification Barrier', `data0` = 86, `data3` = 3000, `data5` = 1, `data10` = 115811, `data22` = 16311, `data23` = 1 WHERE `entry` = 211626;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Shroud of Reversal', `data0` = 86, `data3` = 3000, `data5` = 1, `data10` = 115972, `data22` = 16311, `data23` = 1 WHERE `entry` = 211628;
UPDATE `gameobject_template` SET `name` = 'Celestial Control Console', `flags` = 32 WHERE `entry` = 211650;
UPDATE `gameobject_template` SET `name` = 'Ancient Mogu Door', `data0` = 0, `faction` = 1375, `flags` = 32 WHERE `entry` = 213244;
UPDATE `gameobject_template` SET `name` = 'Doodad_Mogu_Statue_MoguShanVaults002', `faction` = 1375, `flags` = 32 WHERE `entry` = 213245;
UPDATE `gameobject_template` SET `name` = 'Doodad_Mogu_Statue_MoguShanVaults001', `faction` = 1375, `flags` = 32 WHERE `entry` = 213246;
UPDATE `gameobject_template` SET `name` = 'Doodad_Mogu_Statue_MoguShanVaults004', `faction` = 1375, `flags` = 33 WHERE `entry` = 213247;
UPDATE `gameobject_template` SET `name` = 'Doodad_Mogu_Statue_MoguShanVaults003', `faction` = 1375, `flags` = 32 WHERE `entry` = 213248;
UPDATE `gameobject_template` SET `name` = 'Ancient Mogu Door', `data0` = 0, `faction` = 1375, `flags` = 32 WHERE `entry` = 213258;
UPDATE `gameobject_template` SET `name` = 'Ancient Mogu Door', `faction` = 1375, `flags` = 48 WHERE `entry` = 213285;
UPDATE `gameobject_template` SET `name` = 'Mysterious Wall', `flags` = 48 WHERE `entry` = 213373;
UPDATE `gameobject_template` SET `name` = 'Titan Energy Discs', `flags` = 48 WHERE `entry` = 213506;
UPDATE `gameobject_template` SET `name` = 'Energy Platform' WHERE `entry` = 213526;
UPDATE `gameobject_template` SET `name` = 'Titan Energy Ring', `flags` = 48 WHERE `entry` = 213527;
UPDATE `gameobject_template` SET `name` = 'Titan Energy Ring', `flags` = 48 WHERE `entry` = 213528;
UPDATE `gameobject_template` SET `name` = 'Titan Energy Ring', `flags` = 48 WHERE `entry` = 213529;
UPDATE `gameobject_template` SET `name` = 'Mogu_Raised_Gate01', `data0` = 1, `faction` = 1375 WHERE `entry` = 213933;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213937;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213938;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213939;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213940;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213941;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213942;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213943;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213944;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213945;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213946;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213947;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213948;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213949;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213950;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213951;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213952;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 32 WHERE `entry` = 213953;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213954;
UPDATE `gameobject_template` SET `name` = 'Mogu Energy Rune', `flags` = 48 WHERE `entry` = 213955;
UPDATE `gameobject_template` SET `name` = 'Celestial Door', `flags` = 16 WHERE `entry` = 214412;
UPDATE `gameobject_template` SET `name` = 'Feng\'s Door', `data0` = 1, `data9` = 1, `faction` = 114, `flags` = 32 WHERE `entry` = 214452;
UPDATE `gameobject_template` SET `name` = 'Stone Guard Entrance Door', `data0` = 1, `faction` = 114, `flags` = 16 WHERE `entry` = 214497;
UPDATE `gameobject_template` SET `name` = 'Ancient Mogu Door', `faction` = 114, `flags` = 48 WHERE `entry` = 214526;
UPDATE `gameobject_template` SET `name` = 'Ancient Mogu Door', `faction` = 114, `flags` = 48 WHERE `entry` = 214696;
UPDATE `gameobject_template` SET `name` = 'Wind Wall', `data0` = 1, `data6` = 1, `flags` = 4 WHERE `entry` = 215114;

-- ==========================================================================
-- Terrace of Endless Spring (map 996)
-- ==========================================================================
UPDATE `instance_template` SET `allowMount` = 1 WHERE `map` = 996;

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60583; -- Protector Kaolan
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60585; -- Elder Regail
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60586; -- Elder Asani
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60788; -- Pure Light Terrace
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60957; -- Minion of Fear Controller
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 60999; -- Sha of Fear
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 61034; -- Terror Spawn
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 61038; -- Yang Guoshi
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 61042; -- Cheng Kang
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 61046; -- Jinlun Kun
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 62442; -- Tsulong
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 62969; -- Embodied Terror
UPDATE `creature_template` SET `minlevel` = 93 WHERE `entry` = 62983; -- Lei Shi
UPDATE `creature_template` SET `minlevel` = 92 WHERE `entry` = 62995; -- Animated Protector
UPDATE `creature_template` SET `minlevel` = 90 WHERE `entry` = 63275; -- Corrupted Protector
UPDATE `creature_template` SET `mechanic_immune_mask` = 667893759 WHERE `entry` = 63346; -- The Dark of Night
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 63823; -- Waterspout
UPDATE `creature_template` SET `minlevel` = 90 WHERE `entry` = 64368; -- Apparition of Fear
UPDATE `creature_template` SET `minlevel` = 91 WHERE `entry` = 66100; -- Apparition of Terror
UPDATE `creature_template` SET `minlevel` = 90 WHERE `entry` = 71095; -- Reflection of Lei Shi

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 60583;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60583, 0, 0, 0, 1, 0, '118221');
DELETE FROM `creature_template_addon` WHERE `entry` = 60585;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60585, 0, 0, 0, 1, 0, '118221');
DELETE FROM `creature_template_addon` WHERE `entry` = 60586;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60586, 0, 0, 0, 1, 0, '118221');
DELETE FROM `creature_template_addon` WHERE `entry` = 60788;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60788, 0, 0, 0, 1, 0, '117770');
DELETE FROM `creature_template_addon` WHERE `entry` = 60999;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60999, 0, 0, 0, 1, 0, '72242');
DELETE FROM `creature_template_addon` WHERE `entry` = 62442;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62442, 0, 0, 0, 1, 0, '64481 122452');
DELETE FROM `creature_template_addon` WHERE `entry` = 62983;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62983, 0, 0, 0, 1, 0, '123620');
DELETE FROM `creature_template_addon` WHERE `entry` = 62995;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (62995, 0, 0, 0, 1, 0, '123493');
DELETE FROM `creature_template_addon` WHERE `entry` = 71095;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (71095, 0, 0, 0, 1, 0, '123620');

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 117866;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 117866, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'wall of Light - target players');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 122928;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 122928, 0, 0, 31, 0, 3, 62442, 0, 0, 0, 0, '', 'Instability - target Tsulong');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 122952;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 122952, 0, 0, 31, 0, 3, 62962, 0, 0, 0, 0, '', 'Summon Unstable Sha - target Trigger');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 123012;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 123012, 0, 0, 31, 0, 3, 62442, 0, 0, 0, 0, '', 'Terrorize - target Tsulong');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 132363;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 132363, 0, 0, 31, 0, 3, 63099, 0, 0, 0, 0, '', 'Hide visual - target lei shi trigger');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 117866;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 117866, 0, 0, 22, 0, 996, 0, 0, 0, 0, 0, '0', 'Champion of the Light - Active only in Terrace of Endless Spring');

-- spell_target_position
DELETE FROM `spell_target_position` WHERE `id` = 117227 AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (117227, 0, 996, -1017.86, -3049.28, 12.823, 1.5197);
DELETE FROM `spell_target_position` WHERE `id` = 120191 AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (120191, 0, 996, -1730.42, -3839.9, -279.502, 6.144);
DELETE FROM `spell_target_position` WHERE `id` = 120192 AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (120192, 0, 996, -1659.16, -3783.51, -279.502, 3.546);
DELETE FROM `spell_target_position` WHERE `id` = 123441 AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (123441, 0, 996, -1017.96, -2911.15, 19.8185, 0);

-- spell_linked_spell
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -119985 AND `spell_effect` = -119983 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-119985, -119983, 0, 'Fear - Remove dread spray on fade');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 122855 AND `spell_effect` = 122858 AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (122855, 122858, 0, 'Sun Breath - Trigger Bathed in Light');

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 65736;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(65736, 118977, 3, 1);

