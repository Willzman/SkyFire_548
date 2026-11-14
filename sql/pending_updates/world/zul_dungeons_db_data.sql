-- Instance DB audit (tools/InstanceAudit.pl in the port plan): data the LoA world DB has for these instances and
-- Development did not. SkyFire's own values are kept wherever it had any (see the PR text for the rules).

-- ==========================================================================
-- Zul'Gurub (map 859)
-- ==========================================================================
-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52053; -- Zanzil
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52054; -- Zanzili Berserker
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52059; -- High Priestess Kilnara
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432 WHERE `entry` = 52147; -- Wave of Agony
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52148; -- Jin\'do the Godbreaker
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52151; -- Bloodlord Mandokir
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52155; -- High Priest Venoxis
UPDATE `creature_template` SET `mechanic_immune_mask` = 545330067 WHERE `entry` = 52157; -- Ohgan
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `flags_extra` = 128 WHERE `entry` = 52160; -- Wave of Agony
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52167; -- Gurubashi Spirit Warrior
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 52197; -- Pool of Acrid Tears
UPDATE `creature_template` SET `unit_flags2` = 2048, `mechanic_immune_mask` = 617299967 WHERE `entry` = 52222; -- Spirit of Hakkar
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 617299967, `dmg_multiplier` = 95 WHERE `entry` = 52258; -- Gri\'lek
UPDATE `creature_template` SET `minlevel` = 86, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 617299967, `dmg_multiplier` = 95 WHERE `entry` = 52269; -- Renataki
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52271; -- Hazza\'rah
UPDATE `creature_template` SET `minlevel` = 84, `maxlevel` = 84, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 7 WHERE `entry` = 52284; -- Nightmare Illusion
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 617299967, `dmg_multiplier` = 95 WHERE `entry` = 52286; -- Wushoolay
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 52288; -- Venomous Effusion
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52311; -- Venomguard Destroyer
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52322; -- Witch Doctor Qu\'in
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 52331; -- Mutated Overgrowth
UPDATE `creature_template` SET `unit_flags2` = 2048, `flags_extra` = 2 WHERE `entry` = 52332; -- Toxic Venomspitter
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52340; -- Tiki Lord Mu\'Loa
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52348; -- Berserking Boulder Roller
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `VehicleId` = 1594 WHERE `entry` = 52351; -- Boulder
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `VehicleId` = 1594 WHERE `entry` = 52353; -- Boulder
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `VehicleId` = 1594 WHERE `entry` = 52354; -- Boulder
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52362; -- Tiki Lord Zim\'wae
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52364; -- Ritual Tiki Mask
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52380; -- Venomancer Mauri
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52381; -- Venomancer T\'Kulu
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 52400; -- Sundered Rift
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 52407; -- Broken Ground
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52414; -- Tor-Tun
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52418; -- Lost Offspring of Gahz\'ranka
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967, `flags_extra` = 130 WHERE `entry` = 52419; -- Tiki Torch
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52422; -- Kaulema the Mover
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52429; -- Zanza the Restless
UPDATE `creature_template` SET `mechanic_immune_mask` = 653213695 WHERE `entry` = 52430; -- Hakkar\'s Chains
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52438; -- Mortaxx
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52440; -- Gub
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52442; -- Florawing Hive Queen
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52449; -- Ancient Dwarven Artifact
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52451; -- Ancient Elven Artifact
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52453; -- Ancient Troll Artifact
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52455; -- Ancient Fossil
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 52525; -- Bloodvenom
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52606; -- Gurubashi Warmonger
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 52608; -- Twisted Shadow
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52730; -- Gurubashi Spirit
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52956; -- Zandalari Juggernaut
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52958; -- Zandalari Hierophant
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52962; -- Zandalari Archon
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 53023; -- Bloodslayer T\'ara
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 53024; -- Bloodslayer Zala
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 53025; -- Bloodslayer Vaena

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 52147;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52147, 0, 0, 0, 1, 0, '96532');
DELETE FROM `creature_template_addon` WHERE `entry` = 52288;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52288, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 52347;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52347, 0, 0, 0, 1, 0, '84119');
DELETE FROM `creature_template_addon` WHERE `entry` = 52351;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52351, 0, 0, 0, 1, 0, '96831');
DELETE FROM `creature_template_addon` WHERE `entry` = 52353;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52353, 0, 0, 0, 1, 0, '96831');
DELETE FROM `creature_template_addon` WHERE `entry` = 52354;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52354, 0, 0, 0, 1, 0, '96831');
DELETE FROM `creature_template_addon` WHERE `entry` = 52373;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52373, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52375;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52375, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52376;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52376, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52377;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52377, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52379;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52379, 0, 0, 50331648, 1, 0, '96912');
DELETE FROM `creature_template_addon` WHERE `entry` = 52400;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52400, 0, 0, 0, 1, 0, '97031 96970');
DELETE FROM `creature_template_addon` WHERE `entry` = 52407;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52407, 0, 0, 0, 1, 0, '96974');
DELETE FROM `creature_template_addon` WHERE `entry` = 52434;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52434, 0, 0, 0, 1, 0, '84186');
DELETE FROM `creature_template_addon` WHERE `entry` = 52436;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52436, 0, 0, 1, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52437;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52437, 0, 0, 1, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52442;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52442, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 53022;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (53022, 0, 0, 8, 1, 0, NULL);

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 96712;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 96712, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Zul\'Gurub - Wushoolay - Forked Lightning only targets players');

-- smart_scripts from the LoA world DB for creatures that had no script and no SmartAI rows
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `ScriptName` = '' AND `entry` IN (52076, 52077, 52079, 52085, 52086, 52087, 52167, 52311, 52323, 52325, 52327, 52340, 52345, 52348, 52362, 52373, 52375, 52376, 52377, 52379, 52380, 52381, 52392, 52405, 52413, 52414, 52418, 52422, 52434, 52436, 52438, 52440, 52442, 52598, 52606, 52956, 52958, 52962);

-- 52076 Gurubashi Cauldron-Mixer
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52076 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52076, 0, 0, 0, 0, 0, 100, 0, 3000, 4500, 12000, 13000, 0, 11, 96804, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Cauldron-Mixer - In Combat - Cast Bubbling Mixture'),
(52076, 0, 1, 0, 14, 0, 100, 0, 120000, 40, 15000, 18000, 0, 11, 97386, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Cauldron-Mixer - On Friendlies - Cast Crush Herbs'),
(52076, 0, 2, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 96488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Cauldron-Mixer - On Aggro - Cast Drain Blue Cauldron'),
(52076, 0, 3, 0, 0, 0, 100, 0, 6000, 8000, 15000, 18000, 0, 11, 96449, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Cauldron-Mixer - In Combat - Cast Frostburn Formula'),
(52076, 0, 4, 0, 0, 0, 100, 0, 5000, 11000, 10000, 22000, 0, 11, 96413, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Cauldron-Mixer - In Combat - Cast Gout of Flame');
-- 52077 Gurubashi Berserker
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52077 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52077, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 17000, 20000, 0, 11, 96341, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - In Combat - Cast Knock Away'),
(52077, 0, 1, 0, 9, 0, 100, 0, 0, 10, 13600, 14500, 0, 11, 96340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - On Close - Cast Thunderclap'),
(52077, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 22000, 26000, 0, 11, 96342, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Berserker - In Combat - Cast Pursuit');
-- 52079 Gurubashi Bloodrager
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52079 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52079, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 35570, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bloodrager - On Aggro - Cast Charge'),
(52079, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 12000, 15000, 0, 11, 77558, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Bloodrager - In Combat - Cast Bloody Strike');
-- 52085 Razzashi Adder
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52085 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52085, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 17000, 18000, 0, 11, 96415, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast Venom Spit'),
(52085, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 10000, 10500, 0, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razzashi Adder - In Combat - Cast Thrash');
-- 52086 Hakkari Witch Doctor
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52086 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52086, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 0, 11, 74919, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - On Spawn - Cast Dark Aura'),
(52086, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 0, 11, 96416, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast Shadow Bolt'),
(52086, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 28000, 28000, 0, 11, 97398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast Release Toads'),
(52086, 0, 3, 0, 0, 0, 100, 0, 5000, 6000, 15000, 17000, 0, 11, 97397, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast Shrink'),
(52086, 0, 4, 0, 0, 0, 100, 0, 12000, 12000, 30000, 30000, 0, 11, 24065, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hakkari Witch Doctor - In Combat - Cast Toad Explode');
-- 52087 Zanzil Mindslave
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52087 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52087, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 12000, 13500, 0, 11, 3234, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zanzil Mindslave - In Combat - Cast Disease Touch');
-- 52167 Gurubashi Spirit Warrior
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52167 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52167, 0, 0, 2, 0, 0, 100, 0, 8000, 9000, 19000, 20000, 0, 11, 97597, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Spirit Warrior - In Combat - Cast Spirit Warrior\'s Gaze'),
(52167, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 17000, 17500, 0, 11, 97088, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Spirit Warrior - In Combat - Cast Frenzy'),
(52167, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 97198, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Spirit Warrior - On Link - Cast Body Slam');
-- 52311 Venomguard Destroyer
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52311 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52311, 0, 0, 0, 0, 0, 100, 0, 8000, 9000, 22000, 26000, 0, 11, 96753, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomguard Destroyer - In Combat - Cast Breath of Hethiss'),
(52311, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 32000, 0, 11, 96754, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Venomguard Destroyer - In Combat - Cast Pool of Acrid Tears'),
(52311, 0, 2, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97337, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Venomguard Destroyer - On Death - Cast Cauldron Neutralizer');
-- 52323 Chosen of Hethiss
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52323 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52323, 0, 0, 0, 1, 0, 100, 0, 500, 1000, 60000, 65000, 0, 11, 97019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chosen of Hethiss - On Spawn - Cast Blessing of the Snake God'),
(52323, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 0, 11, 97017, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chosen of Hethiss - In Combat - Cast Poison Bolt'),
(52323, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 18000, 20000, 0, 11, 97018, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chosen of Hethiss - In Combat - Cast Poison Bolt Volley');
-- 52325 Gurubashi Blood Drinker
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52325 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52325, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 75998, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - At 30% HP - Cast Enrage'),
(52325, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - On Link - Say Text'),
(52325, 0, 2, 0, 9, 0, 100, 0, 0, 5, 12000, 14500, 0, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - On Close - Cast Mortal Strike'),
(52325, 0, 3, 0, 0, 0, 100, 0, 8000, 9000, 22000, 24000, 0, 11, 96764, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - In Combat - Cast Blood Leech');
-- 52327 Gurubashi Shadow Hunter
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52327 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52327, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 97239, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Shadow Hunter - In Combat - Cast Shoot'),
(52327, 0, 1, 0, 0, 0, 100, 0, 5000, 7000, 14000, 17500, 0, 11, 96767, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Shadow Hunter - In Combat - Cast Shadowed Shot');
-- 52340 Tiki Lord Mu\'Loa
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52340 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52340, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 15000, 18000, 0, 11, 96822, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tiki Lord Mu\'Loa - In Combat - Cast Tiki Torch');
-- 52345 Pride of Bethekk
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52345 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52345, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 12000, 14000, 0, 11, 97357, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Pride of Bethekk - In Combat - Cast Gaping Wound');
-- 52348 Berserking Boulder Roller
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52348 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52348, 0, 0, 0, 0, 0, 100, 0, 6000, 8000, 17000, 20000, 0, 11, 97616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Berserking Boulder Roller - In Combat - Cast Knock Away'),
(52348, 0, 1, 0, 1, 0, 100, 0, 500, 1000, 15000, 18000, 0, 11, 96826, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Berserking Boulder Roller - On Spawn - Cast Rolling Boulders'),
(52348, 0, 2, 0, 9, 0, 100, 0, 0, 10, 13600, 14500, 0, 11, 15588, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Berserking Boulder Roller - On Close - Cast Thunderclap');
-- 52362 Tiki Lord Zim\'wae
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52362 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52362, 0, 0, 0, 0, 0, 100, 0, 3500, 4500, 10000, 15000, 0, 11, 96871, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tiki Lord Zim\'wae - In Combat - Cast Bone Volley');
-- 52373 Florawing Needler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52373 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52373, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Florawing Needler - In Combat - Cast Venom Sting');
-- 52375 Florawing Needler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52375 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52375, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Florawing Needler - In Combat - Cast Venom Sting');
-- 52376 Florawing Needler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52376 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52376, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Florawing Needler - In Combat - Cast Venom Sting');
-- 52377 Florawing Needler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52377 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52377, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Florawing Needler - In Combat - Cast Venom Sting');
-- 52379 Venomtip Needler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52379 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52379, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomtip Needler - In Combat - Cast Venom Sting');
-- 52380 Venomancer Mauri
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52380 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52380, 0, 0, 0, 0, 0, 100, 0, 6000, 9000, 22000, 25000, 0, 11, 96466, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomancer Mauri - In Combat - Cast Whispers of Hethiss'),
(52380, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 0, 11, 96918, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomancer Mauri - In Combat - Cast Poison Bolt');
-- 52381 Venomancer T\'Kulu
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52381 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52381, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3400, 4700, 0, 11, 96918, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Venomancer T\'Kulu - In Combat - Cast Poison Bolt');
-- 52392 Gurubashi Master Chef
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52392 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52392, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 11000, 12000, 0, 11, 79554, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Master Chef - In Combat - Cast Fish Slap'),
(52392, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 18000, 22000, 0, 11, 81252, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Master Chef - In Combat - Cast Full of Meat'),
(52392, 0, 2, 0, 0, 0, 100, 0, 5000, 12000, 9000, 25000, 0, 11, 79175, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Master Chef - In Combat - Cast Slap & Chop');
-- 52405 Mor\'Lek the Dismantler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52405 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52405, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 81173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mor\'Lek the Dismantler - At 30% HP - Cast Frenzy'),
(52405, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mor\'Lek the Dismantler - On Link - Say Text');
-- 52413 Zulian Gnasher
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52413 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52413, 0, 0, 0, 9, 0, 100, 0, 0, 5, 12000, 12000, 0, 11, 13445, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zulian Gnasher - On Close - Cast Rend on Close'),
(52413, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 16000, 18000, 0, 11, 3604, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zulian Gnasher - In Combat - Cast Tendon Rip');
-- 52414 Tor-Tun
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52414 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52414, 0, 0, 0, 2, 0, 100, 1, 0, 45, 0, 0, 0, 11, 79840, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tor-Tun - At 45% HP - Cast Harden');
-- 52418 Lost Offspring of Gahz\'ranka
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52418 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52418, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 18000, 22000, 0, 11, 97226, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Lost Offspring of Gahz\'ranka - In Combat - Cast Frost Breath'),
(52418, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 10000, 10500, 0, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Lost Offspring of Gahz\'ranka - In Combat - Cast Thrash');
-- 52422 Kaulema the Mover
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52422 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52422, 0, 0, 0, 9, 0, 100, 0, 0, 5, 12000, 13000, 0, 11, 17547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Kaulema the Mover - On Close - Cast Mortal Strike');
-- 52434 Gurubashi Villager
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52434 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52434, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 12000, 14000, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Villager - In Combat - Cast Backhand'),
(52434, 0, 1, 0, 0, 0, 100, 0, 5500, 8000, 10000, 19000, 0, 11, 80382, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Villager - In Combat - Cast Dirt Toss');
-- 52436 Gurubashi Refugee
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52436 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52436, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 12000, 14000, 0, 11, 6253, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Refugee - In Combat - Cast Backhand'),
(52436, 0, 1, 0, 0, 0, 100, 0, 5500, 8000, 10000, 19000, 0, 11, 80382, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Refugee - In Combat - Cast Dirt Toss');
-- 52438 Mortaxx
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52438 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52438, 0, 0, 0, 0, 0, 100, 0, 4000, 4500, 12000, 14000, 0, 11, 17228, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Mortaxx - In Combat - Cast Shadow Bolt Volley'),
(52438, 0, 1, 0, 0, 0, 100, 0, 9000, 10000, 28000, 35000, 0, 11, 34322, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mortaxx - In Combat - Cast Psychic Scream');
-- 52440 Gub
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52440 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52440, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 81173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gub - At 30% HP - Cast Frenzy'),
(52440, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gub - On Link - Say Text');
-- 52442 Florawing Hive Queen
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52442 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52442, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 15000, 16000, 0, 11, 8257, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Florawing Hive Queen - In Combat - Cast Venom Sting'),
(52442, 0, 1, 0, 2, 0, 100, 0, 0, 40, 14000, 14500, 0, 11, 34392, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Florawing Hive Queen - At 40% HP - Cast Stinger Rage');
-- 52598 Gurubashi Soul-Eater
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52598 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52598, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 25000, 30000, 0, 11, 97250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Soul-Eater - In Combat - Cast Soul Shield'),
(52598, 0, 1, 0, 2, 0, 100, 0, 0, 40, 14000, 16000, 0, 11, 97248, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Soul-Eater - At 40% HP - Cast Consume Soul');
-- 52606 Gurubashi Warmonger
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52606 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52606, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 59697, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Warmonger - At 30% HP - Cast Enrage'),
(52606, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Warmonger - On Link - Say Text');
-- 52956 Zandalari Juggernaut
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52956 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52956, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Juggernaut - On Aggro - Say Text'),
(52956, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97977, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Juggernaut - On Link - Cast Blessing of Zandalar'),
(52956, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97972, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Juggernaut - On Link - Cast Glory of the Zandalari'),
(52956, 0, 3, 0, 2, 0, 100, 0, 0, 50, 25000, 27000, 0, 11, 98000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Juggernaut - At 50% HP - Cast Ancestral Call'),
(52956, 0, 4, 0, 0, 0, 100, 1, 5000, 5000, 0, 0, 0, 11, 97987, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Juggernaut - In Combat - Cast Tectonic Plating');
-- 52958 Zandalari Hierophant
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52958 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52958, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - On Aggro - Say Text'),
(52958, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97977, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - On Link - Cast Blessing of Zandalar'),
(52958, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97972, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - On Link - Cast Glory of the Zandalari'),
(52958, 0, 3, 0, 14, 0, 100, 0, 200000, 55, 25000, 28000, 0, 11, 97978, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - On Friendlies - Cast Ancient Guardian'),
(52958, 0, 4, 0, 2, 0, 100, 0, 0, 40, 22000, 25000, 0, 11, 97974, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - At 40% HP - Cast Sanctify'),
(52958, 0, 5, 0, 0, 0, 100, 0, 8000, 9000, 15000, 15000, 0, 11, 23979, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Hierophant - In Combat - Cast Ancient Power');
-- 52962 Zandalari Archon
DELETE FROM `smart_scripts` WHERE `entryorguid` = 52962 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(52962, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - On Aggro - Say Text'),
(52962, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97977, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - On Link - Cast Blessing of Zandalar'),
(52962, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97972, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - On Link - Cast Glory of the Zandalari'),
(52962, 0, 3, 0, 0, 0, 50, 0, 9000, 9000, 25000, 25000, 0, 11, 98018, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - In Combat - Cast Sigil of Death'),
(52962, 0, 4, 0, 0, 0, 50, 0, 9000, 9000, 25000, 25000, 0, 11, 98006, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - In Combat - Cast Sigil of Flame'),
(52962, 0, 5, 0, 0, 0, 50, 0, 9000, 9000, 25000, 25000, 0, 11, 98015, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Zandalari Archon - In Combat - Cast Sigil of Frost');

-- creature_text for the SAY actions above
DELETE FROM `creature_text` WHERE `entry` = 52325;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(52325, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 52405;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(52405, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 52440;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(52440, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, '');
DELETE FROM `creature_text` WHERE `entry` = 52606;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(52606, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, '');

-- ==========================================================================
-- Zul'Aman (map 568)
-- ==========================================================================
-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23542; -- Amani\'shi Axe Thrower
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23580; -- Amani\'shi Warbringer
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23581; -- Amani\'shi Medicine Man
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23582; -- Amani\'shi Tribesman
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23587; -- Amani\'shi Reinforcement
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23596; -- Amani\'shi Flame Caster
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23774; -- Amani\'shi Trainer
UPDATE `creature_template` SET `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 23807; -- Zul\'Aman - Bear God Invisman
UPDATE `creature_template` SET `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 23813; -- Zul\'Aman - Dragonhawk God Invisman
UPDATE `creature_template` SET `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 23814; -- Zul\'Aman - Eagle God Invisman
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 23834; -- Amani Dragonhawk
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 23877; -- Amani Lynx Spirit
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 23878; -- Amani Bear Spirit
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 23879; -- Amani Dragonhawk Spirit
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 23880; -- Amani Eagle Spirit
UPDATE `creature_template` SET `flags_extra` = 2 WHERE `entry` = 23897; -- Zungam
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 24043; -- Amani Lynx
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 24059; -- Amani\'shi Beast Tamer
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 24138; -- Tamed Amani Crocolisk
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 24217; -- Amani Bear Mount
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 24223; -- Eagle Trash Aggro Trigger
UPDATE `creature_template` SET `flags_extra` = 128, `InhabitType` = 4 WHERE `entry` = 24363; -- Hex Lord Malacrass
UPDATE `creature_template` SET `mechanic_immune_mask` = 1 WHERE `entry` = 24549; -- Amani\'shi Tempest
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 24551; -- Eagle Event Deactivation Trigger
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 1890, `faction_H` = 1890, `dmg_multiplier` = 7 WHERE `entry` = 52755; -- Refreshing Water Totem
UPDATE `creature_template` SET `minlevel` = 5, `maxlevel` = 5, `unit_flags` = 512 WHERE `entry` = 52909; -- Tyllan
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52924; -- Vol\'jin
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52939; -- Hazlek
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `exp` = 3, `unit_flags` = 33587456 WHERE `entry` = 52940; -- Hazlek\'s Corpse
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `exp` = 3, `unit_flags` = 33587456 WHERE `entry` = 52942; -- Bakkalzu\'s Corpse
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 52943; -- Norkani
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `unit_flags` = 33554432 WHERE `entry` = 52944; -- Norkani\'s Corpse
UPDATE `creature_template` SET `faction_A` = 7, `faction_H` = 7, `npcflag` = 1 WHERE `entry` = 52945; -- Kasha
UPDATE `creature_template` SET `minlevel` = 85, `maxlevel` = 85, `unit_flags` = 33554432 WHERE `entry` = 52946; -- Kasha\'s Corpse
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52956; -- Zandalari Juggernaut
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52958; -- Zandalari Hierophant
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299967 WHERE `entry` = 52962; -- Zandalari Archon

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 23542;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (23542, 0, 0, 0, 1, 0, '97848');
DELETE FROM `creature_template_addon` WHERE `entry` = 23580;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (23580, 0, 22467, 0, 1, 0, '97850');
DELETE FROM `creature_template_addon` WHERE `entry` = 23582;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (23582, 0, 0, 0, 1, 0, '97848');
DELETE FROM `creature_template_addon` WHERE `entry` = 52938;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52938, 0, 0, 1, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 52940;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52940, 0, 0, 7, 1, 0, '42726');
DELETE FROM `creature_template_addon` WHERE `entry` = 52942;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52942, 0, 0, 7, 1, 0, '42726');
DELETE FROM `creature_template_addon` WHERE `entry` = 52944;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52944, 0, 0, 7, 1, 0, '42726');
DELETE FROM `creature_template_addon` WHERE `entry` = 52946;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (52946, 0, 0, 7, 1, 0, '42726');
DELETE FROM `creature_template_addon` WHERE `entry` = 53021;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (53021, 0, 0, 1, 1, 0, NULL);

-- conditions

-- spell_target_position
DELETE FROM `spell_target_position` WHERE `id` = 43098 AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES (43098, 0, 568, -34.316, 1149.64, 19.155, 3.119);


-- smart_scripts from the LoA world DB for creatures that had no script and no SmartAI rows
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `ScriptName` = '' AND `entry` IN (23542, 23581, 23582, 23584, 23586, 23596, 23597, 23774, 23813, 23814, 23834, 23889, 24047, 24059, 24064, 24065, 24138, 24179, 24180, 24217, 24374, 24530);

-- 23542 Amani\'shi Axe Thrower
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23542 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23542, 0, 0, 0, 0, 0, 100, 0, 0, 0, 12000, 12000, 0, 11, 31566, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - In Combat - Cast \'Raptor Strike\''),
(23542, 0, 1, 0, 0, 0, 100, 0, 0, 0, 7400, 7400, 0, 11, 35011, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - In Combat - Cast \'Knockdown\''),
(23542, 0, 2, 0, 0, 0, 100, 0, 0, 0, 27000, 27000, 0, 11, 42359, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - In Combat - Cast \'Axe Volley\''),
(23542, 0, 3, 0, 0, 0, 100, 0, 0, 0, 18000, 18000, 0, 11, 42332, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - In Combat - Cast \'Throw Axe\'');
-- 23581 Amani\'shi Medicine Man
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23581 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23581, 0, 0, 0, 2, 0, 100, 0, 0, 30, 30000, 30000, 0, 11, 42477, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Between 0-30% Health - Cast \'Chain Heal\' (No Repeat)'),
(23581, 0, 1, 0, 2, 0, 100, 0, 0, 40, 50000, 50000, 0, 11, 42478, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Between 0-40% Health - Cast \'Protective Ward\' (No Repeat)'),
(23581, 0, 2, 0, 0, 0, 100, 0, 7000, 7000, 25000, 25000, 0, 11, 42376, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - In Combat - Cast \'Healing Ward\' (No Repeat)'),
(23581, 0, 3, 0, 0, 0, 100, 0, 1000, 1000, 16000, 16000, 0, 11, 45075, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - In Combat - Cast \'Lightning Bolt\' (No Repeat)');
-- 23582 Amani\'shi Tribesman
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23582 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23582, 0, 0, 0, 0, 0, 70, 0, 0, 0, 13000, 13000, 0, 11, 42495, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Tribesman - In Combat - Cast \'Cyclone Strike\' (No Repeat)'),
(23582, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 9000, 12000, 0, 11, 36033, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Tribesman - In Combat - Cast \'Kick\' (No Repeat)');
-- 23584 Amani Bear
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23584 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23584, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 28000, 28000, 0, 11, 42745, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear - In Combat - Cast \'Enrage\' (No Repeat)'),
(23584, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 20000, 20000, 0, 11, 42747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear - In Combat - Cast \'Crunch Armor\' (No Repeat)');
-- 23586 Amani\'shi Scout
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23586 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23586, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Scout - On Aggro - Say Line 0 (No Repeat) (Normal Dungeon)'),
(23586, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 42177, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Scout - On Aggro - Cast \'Alert Drums\' (No Repeat) (Normal Dungeon)'),
(23586, 0, 2, 0, 0, 0, 100, 0, 2000, 2000, 4000, 5000, 0, 11, 16496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Scout - In Combat - Cast \'Shoot\' (No Repeat) (Normal Dungeon)'),
(23586, 0, 3, 0, 0, 0, 100, 0, 6000, 6000, 20000, 24000, 0, 11, 43205, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Scout - In Combat - Cast \'Multi-Shot\' (No Repeat) (Normal Dungeon)');
-- 23596 Amani\'shi Flame Caster
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23596 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23596, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 0, 11, 43242, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - In Combat - Cast \'Haste\' (No Repeat) (Normal Dungeon)'),
(23596, 0, 1, 0, 0, 0, 100, 0, 0, 0, 18000, 18000, 0, 11, 43240, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - In Combat - Cast \'Fireball Volley\' (No Repeat) (Normal Dungeon)'),
(23596, 0, 2, 0, 0, 0, 100, 0, 0, 0, 9700, 9700, 0, 11, 43245, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - In Combat - Cast \'Fire Blast\' (No Repeat) (Normal Dungeon)');
-- 23597 Amani\'shi Guardian
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23597 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23597, 0, 0, 0, 0, 0, 100, 1, 0, 0, 1500, 1500, 0, 11, 43249, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - In Combat - Cast \'Startling Roar\' (No Repeat) (Normal Dungeon)'),
(23597, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 12000, 12000, 0, 11, 43246, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - In Combat - Cast \'Rend\' (No Repeat) (Normal Dungeon)'),
(23597, 0, 2, 0, 38, 0, 100, 0, 0, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - On Data Set 0 1 - Set Event Phase 1 (No Repeat) (Normal Dungeon)'),
(23597, 0, 3, 0, 38, 0, 100, 0, 0, 2, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - On Data Set 0 2 - Set Event Phase 2 (No Repeat) (Normal Dungeon)'),
(23597, 0, 4, 0, 1, 1, 100, 1, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Data 0 0 (No Repeat) (Normal Dungeon)'),
(23597, 0, 5, 0, 1, 1, 100, 1, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Run On (No Repeat) (Normal Dungeon)'),
(23597, 0, 6, 0, 1, 1, 100, 1, 2000, 2000, 2000, 2000, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 138.224, 1586.99, 43.5488, 0, 'Amani\'shi Guardian - Out of Combat - Move To Position (No Repeat) (Normal Dungeon)'),
(23597, 0, 7, 0, 1, 1, 100, 1, 3000, 3000, 3000, 3000, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 131.841, 1590.25, 43.6138, 0, 'Amani\'shi Guardian - Out of Combat - Move To Position (No Repeat) (Normal Dungeon)'),
(23597, 0, 8, 0, 1, 1, 100, 1, 4000, 4000, 4000, 4000, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.02458, 'Amani\'shi Guardian - Out of Combat - Set Orientation 2 (No Repeat) (Normal Dungeon)'),
(23597, 0, 9, 0, 1, 1, 100, 1, 5000, 5000, 5000, 5000, 0, 11, 43647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Cast \'Cosmetic - Spear Throw\' (No Repeat) (Normal Dungeon)'),
(23597, 0, 10, 0, 1, 1, 100, 1, 5200, 5200, 5200, 5200, 0, 71, 1, 1, 33979, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Change Equipment (No Repeat) (Normal Dungeon)'),
(23597, 0, 11, 0, 1, 1, 100, 1, 6000, 6000, 6000, 6000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Say Line 0 (No Repeat) (Normal Dungeon)'),
(23597, 0, 12, 0, 1, 1, 100, 1, 6200, 6200, 6200, 6200, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Remove Flag Immune To Players (No Repeat) (Normal Dungeon)'),
(23597, 0, 13, 0, 1, 1, 100, 1, 7000, 7000, 7000, 7000, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Start Attacking (No Repeat) (Normal Dungeon)'),
(23597, 0, 14, 0, 1, 2, 100, 1, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Data 0 0 (No Repeat) (Normal Dungeon)'),
(23597, 0, 15, 0, 1, 2, 100, 1, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Set Run On (No Repeat) (Normal Dungeon)'),
(23597, 0, 16, 0, 1, 2, 100, 1, 6000, 6000, 6000, 6000, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 107.791, 1586.5, 43.6161, 0, 'Amani\'shi Guardian - Out of Combat - Move To Position (No Repeat) (Normal Dungeon)'),
(23597, 0, 17, 0, 1, 2, 100, 1, 6800, 6800, 6800, 6800, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.0472, 'Amani\'shi Guardian - Out of Combat - Set Orientation 1 (No Repeat) (Normal Dungeon)'),
(23597, 0, 18, 0, 1, 2, 100, 1, 7600, 7600, 7600, 7600, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Remove Flag Immune To Players (No Repeat) (Normal Dungeon)'),
(23597, 0, 19, 0, 1, 2, 100, 1, 7800, 7800, 7800, 7800, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Out of Combat - Start Attacking (No Repeat) (Normal Dungeon)');
-- 23774 Amani\'shi Trainer
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23774 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23774, 0, 0, 0, 0, 0, 100, 0, 5000, 7000, 15000, 20000, 0, 11, 20989, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Trainer - In Combat - Cast Sleep'),
(23774, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 43292, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Trainer - At 30% HP - Cast Incite Rage');
-- 23813 Zul\'Aman - Dragonhawk God Invisman
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23813 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23813, 0, 0, 0, 10, 0, 100, 0, 1, 20, 2000, 2000, 0, 33, 23813, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Aman - Dragonhawk God Invisman - Within 1-20 Range Out of Combat LoS - Quest Credit \'X Marks... Your Doom!\'');
-- 23814 Zul\'Aman - Eagle God Invisman
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23814 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23814, 0, 0, 0, 10, 0, 100, 0, 1, 20, 2000, 2000, 0, 33, 23814, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Aman - Eagle God Invisman - Within 1-20 Range Out of Combat LoS - Quest Credit \'X Marks... Your Doom!\'');
-- 23834 Amani Dragonhawk
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23834 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23834, 0, 0, 0, 0, 0, 100, 0, 9000, 9000, 27500, 27500, 0, 11, 43294, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Dragonhawk - In Combat - Cast \'Flame Breath\'');
-- 23889 Amani\'shi Savage
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23889 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23889, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 10000, 10000, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - In Combat - Cast \'Hamstring\''),
(23889, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 25000, 30000, 0, 11, 12054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - In Combat - Cast \'Rend\''),
(23889, 0, 2, 0, 0, 0, 100, 0, 8000, 8000, 6000, 9000, 0, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - In Combat - Cast \'Sunder Armor\'');
-- 24047 Amani Crocolisk
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24047 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24047, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 13000, 13000, 0, 11, 43352, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Crocolisk - In Combat - Cast \'Tail Swipe\''),
(24047, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 24000, 24000, 0, 11, 43353, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Crocolisk - In Combat - Cast \'Infected Bite\'');
-- 24059 Amani\'shi Beast Tamer
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24059 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24059, 0, 0, 0, 0, 0, 100, 0, 2000, 4500, 16000, 16000, 0, 11, 43359, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - In Combat - Cast Call of the Beast'),
(24059, 0, 1, 0, 0, 0, 100, 0, 6000, 8000, 15000, 25000, 0, 11, 77616, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - In Combat - Cast Dark Simulacrum'),
(24059, 0, 2, 0, 0, 0, 100, 0, 9000, 10000, 27000, 32500, 0, 11, 43361, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - In Combat - Cast Domesticate');
-- 24064 Amani Lynx Cub
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24064 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24064, 0, 0, 0, 1, 0, 100, 1, 0, 0, 1000, 1000, 0, 11, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - Out of Combat - Cast \'Stealth\''),
(24064, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 28, 42943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Remove Aura \'Stealth\''),
(24064, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 43317, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - On Aggro - Cast \'Dash\''),
(24064, 0, 3, 0, 0, 0, 100, 0, 5000, 5000, 35000, 35000, 0, 11, 43358, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx Cub - In Combat - Cast \'Gut Rip\'');
-- 24065 Amani\'shi Handler
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24065 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24065, 0, 0, 0, 0, 0, 100, 0, 3000, 3000, 23200, 23200, 0, 11, 43364, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Handler - In Combat - Cast \'Tranquilizing Poison\''),
(24065, 0, 1, 0, 0, 0, 100, 0, 0, 0, 9000, 9000, 0, 11, 43362, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Handler - In Combat - Cast \'Electrified Net\'');
-- 24138 Tamed Amani Crocolisk
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24138 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24138, 0, 0, 0, 0, 0, 100, 0, 4000, 5000, 13000, 15000, 0, 11, 43352, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tamed Amani Crocolisk - In Combat - Cast Tail Swipe'),
(24138, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 12000, 18000, 0, 11, 43353, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tamed Amani Crocolisk - In Combat - Cast Infected Bite');
-- 24179 Amani\'shi Wind Walker
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24179 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24179, 0, 0, 0, 2, 0, 100, 0, 0, 30, 30000, 30000, 0, 11, 43527, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - Between 0-30% Health - Cast \'Chain Heal\''),
(24179, 0, 1, 0, 0, 0, 100, 0, 0, 0, 9000, 9000, 0, 11, 43524, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - In Combat - Cast \'Frost Shock\''),
(24179, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 17500, 17500, 0, 11, 43526, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - In Combat - Cast \'Lightning Bolt\'');
-- 24180 Amani\'shi Protector
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24180 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24180, 0, 0, 0, 9, 0, 100, 0, 0, 5, 8000, 11000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - On Close - Cast Cleave on Close'),
(24180, 0, 1, 0, 0, 0, 100, 0, 5000, 8000, 15000, 15000, 0, 11, 43529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - In Combat - Cast Mortal Strike'),
(24180, 0, 2, 0, 2, 0, 100, 0, 0, 55, 20000, 25000, 0, 11, 43530, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - At 55% HP- Cast Piercing Howl');
-- 24217 Amani Bear Mount
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24217 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24217, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 18000, 20000, 0, 11, 42747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - In Combat - Cast Crunch Armor'),
(24217, 0, 1, 0, 0, 0, 100, 0, 1000, 2000, 28000, 32000, 0, 11, 42745, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - In Combat - Cast Enrage');
-- 24374 Amani\'shi Berserker
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24374 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24374, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 28747, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - At 30% HP - Cast Frenzy'),
(24374, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - On Link - Say Text'),
(24374, 0, 2, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 97557, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - On Aggro - Cast Charge'),
(24374, 0, 3, 0, 0, 0, 100, 0, 5000, 7000, 12000, 14000, 0, 11, 43673, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - In Combat - Cast Mighty Blow');
-- 24530 Amani Elder Lynx
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24530 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24530, 0, 0, 0, 2, 0, 100, 0, 0, 30, 90000, 90000, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - Between 0-30% Health - Cast \'Frenzy\''),
(24530, 0, 1, 0, 2, 0, 100, 0, 0, 30, 90000, 90000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - Between 0-30% Health - Say Line 0'),
(24530, 0, 2, 0, 0, 0, 100, 0, 12000, 12000, 20000, 25000, 0, 11, 43357, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - In Combat - Cast \'Feral Swipe\''),
(24530, 0, 3, 0, 0, 0, 100, 0, 1500, 1500, 9000, 13000, 0, 11, 43356, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - In Combat - Cast \'Pounce\'');

-- creature_text for the SAY actions above
DELETE FROM `creature_text` WHERE `entry` = 24530;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(24530, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Amani Elder Lynx');
