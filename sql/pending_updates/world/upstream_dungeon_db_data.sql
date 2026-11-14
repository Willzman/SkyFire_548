-- Instance DB audit (tools/InstanceAudit.pl in the port plan): data the LoA world DB has for these instances and
-- Development did not. SkyFire's own values are kept wherever it had any (see the PR text for the rules).

-- ==========================================================================
-- Scarlet Halls (map 1001)
-- ==========================================================================
-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `mechanic_immune_mask` = 769638399, `flags_extra` = 1 WHERE `entry` = 58632; -- Armsmaster Harlan
UPDATE `creature_template` SET `VehicleId` = 2022 WHERE `entry` = 58674; -- Angry Hound
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 58725; -- Scarlet Cannons
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 58726; -- Scarlet Cannon
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 58727; -- Chained Dog Target
UPDATE `creature_template` SET `mechanic_immune_mask` = 769638399, `flags_extra` = 1 WHERE `entry` = 59150; -- Flameweaver Koegler
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59198; -- Dragon Breath Target
UPDATE `creature_template` SET `mechanic_immune_mask` = 769638399, `flags_extra` = 1 WHERE `entry` = 59303; -- Houndmaster Braun
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59683; -- Exploding Shot Stalker
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 66091; -- Referee

-- creature_template_addon

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 113366;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 113366, 0, 0, 31, 0, 3, 59155, 0, 0, 0, 0, '', 'Book Burner Cosmetic');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 126642;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 126642, 0, 0, 31, 0, 3, 59198, 0, 0, 0, 0, '', 'Dragon Breath Cosmetic');

-- gameobject_template ('unk name' stubs and chests without a loot id)


-- ==========================================================================
-- Stormstout Brewery (map 961)
-- ==========================================================================
-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `mechanic_immune_mask` = 80429055, `flags_extra` = 1 WHERE `entry` = 56637; -- Ook-Ook
UPDATE `creature_template` SET `mechanic_immune_mask` = 80429055, `flags_extra` = 1 WHERE `entry` = 56717; -- Hoptallus
UPDATE `creature_template` SET `VehicleId` = 2059 WHERE `entry` = 56718; -- Hopper
UPDATE `creature_template` SET `unit_flags` = 33024 WHERE `entry` = 56783; -- Hozen Hollerer
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 56865; -- Aqua Dancer
UPDATE `creature_template` SET `unit_flags` = 32768 WHERE `entry` = 56867; -- Fiery Trickster
UPDATE `creature_template` SET `mechanic_immune_mask` = 8390721 WHERE `entry` = 56924; -- Inflamed Hozen Brawler
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59018; -- Tracking Carrot
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 59394; -- General Purpose Bunny JMF (Ground)
UPDATE `creature_template` SET `mechanic_immune_mask` = 80429055, `flags_extra` = 1, `VehicleId` = 2067 WHERE `entry` = 59479; -- Yan-Zhu the Uncasked
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 59482; -- Bloated Stalker
UPDATE `creature_template` SET `mechanic_immune_mask` = 2048 WHERE `entry` = 59512; -- Wall of Suds
UPDATE `creature_template` SET `mechanic_immune_mask` = 80429055 WHERE `entry` = 59518; -- Bloated Brew Alemental
UPDATE `creature_template` SET `mechanic_immune_mask` = 80429055 WHERE `entry` = 59519; -- Stout Brew Alemental
UPDATE `creature_template` SET `mechanic_immune_mask` = 8390721 WHERE `entry` = 59520; -- Fizzy Brew Alemental
UPDATE `creature_template` SET `VehicleId` = 584 WHERE `entry` = 59521; -- Bubbling Brew Alemental
UPDATE `creature_template` SET `mechanic_immune_mask` = 8390721 WHERE `entry` = 59522; -- Sudsy Brew Alemental
UPDATE `creature_template` SET `mechanic_immune_mask` = 8390721 WHERE `entry` = 59605; -- Sodden Hozen Brawler
UPDATE `creature_template` SET `npcflag` = 16777216 WHERE `entry` = 59799; -- Fizzy Bubble
UPDATE `creature_template` SET `unit_flags` = 131072, `InhabitType` = 4 WHERE `entry` = 60276; -- Hozen Clinger
UPDATE `creature_template` SET `VehicleId` = 2086 WHERE `entry` = 65392; -- Nibbler
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 65522; -- Bubble Shield

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 59479;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59479, 0, 0, 50331648, 1, 0, '114929');
DELETE FROM `creature_template_addon` WHERE `entry` = 59494;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59494, 0, 0, 50331648, 1, 0, '116259');
DELETE FROM `creature_template_addon` WHERE `entry` = 59512;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59512, 0, 0, 50331648, 1, 0, '114467');
DELETE FROM `creature_template_addon` WHERE `entry` = 59518;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59518, 0, 0, 50331648, 1, 0, '114929 116259');
DELETE FROM `creature_template_addon` WHERE `entry` = 59522;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59522, 0, 0, 50331648, 1, 0, '116259 119418');
DELETE FROM `creature_template_addon` WHERE `entry` = 59799;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59799, 0, 0, 50331648, 1, 0, '');

-- conditions

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 59799;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(59799, 114459, 3, 0);

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Barrel Door', `data10` = 1, `faction` = 114, `flags` = 32 WHERE `entry` = 211127;

-- ==========================================================================
-- Gate of the Setting Sun (map 962)
-- ==========================================================================
-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 56484; -- Serpent\'s Spine Marksman
UPDATE `creature_template` SET `mechanic_immune_mask` = 786120703, `flags_extra` = 1 WHERE `entry` = 56589; -- Striker Ga\'dok
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 56636; -- Commander Ri\'mok
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 56877; -- Raigonn
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 56879; -- Krik\'thik Glider
UPDATE `creature_template` SET `faction_A` = 2137, `faction_H` = 2137 WHERE `entry` = 56895; -- Weak Spot
UPDATE `creature_template` SET `unit_flags` = 33554944 WHERE `entry` = 56896; -- Volatile Munitions
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 56906; -- Saboteur Kip\'tilak
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 56911; -- Mantid Munitions
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 56918; -- Mantid Munitions
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 56919; -- Mantid Munitions
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 56920; -- Mantid Munitions
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59205; -- Mantid Munitions
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59206; -- Mantid Munitions
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 59207; -- Mantid Munitions
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 59723; -- Great Wall Explosion Caster Stalker
UPDATE `creature_template` SET `unit_flags` = 512 WHERE `entry` = 59835; -- Krik\'thik Swarmer
UPDATE `creature_template` SET `faction_A` = 2244, `faction_H` = 2244 WHERE `entry` = 60502; -- Pandaren Disciple
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 63992; -- Great Wall Explosion Target Stalker 1
UPDATE `creature_template` SET `unit_flags2` = 37750784 WHERE `entry` = 64467; -- Bowmistress Li
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 64710; -- Rope
UPDATE `creature_template` SET `unit_flags` = 33554432, `InhabitType` = 4 WHERE `entry` = 64740; -- Rope Seat
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 65400; -- Krik\'thik Glider

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 59778;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59778, 0, 0, 50331648, 1, 0, '138393 132441');
DELETE FROM `creature_template_addon` WHERE `entry` = 59794;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59794, 0, 0, 50331648, 1, 0, '132441');
DELETE FROM `creature_template_addon` WHERE `entry` = 64740;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64740, 0, 0, 50331648, 1, 0, '');

-- conditions

