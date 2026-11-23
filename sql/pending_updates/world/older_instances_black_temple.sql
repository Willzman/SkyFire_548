-- G7, Black Temple (564): SmartAI for six trash creatures, from the LoA world DB (GPL v2, 2024-07-22).
-- The fork's Black Temple boss scripts are kept (its Shade of Akama is newer than LoA's). Safe to run twice.

-- smart_scripts from the LoA world DB for creatures that had no script and no SmartAI rows
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `ScriptName` = '' AND `entry` IN (22844, 23172, 23049, 23196, 23239, 23237);

-- 22844 Ashtongue Battlelord
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22844 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22844, 0, 0, 0, 0, 0, 85, 0, 19000, 19000, 18000, 18000, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - In Combat - Cast \'Cleave\' (Phase 1) (No Repeat)'),
(22844, 0, 1, 0, 0, 0, 90, 0, 6000, 6000, 20000, 20000, 0, 11, 32588, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - In Combat - Cast \'Concussion Blow\' (Phase 1) (No Repeat)'),
(22844, 0, 2, 0, 0, 0, 85, 0, 15000, 15000, 22000, 22000, 0, 11, 41182, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - In Combat - Cast \'Concussive Throw\' (Phase 1) (No Repeat)'),
(22844, 0, 3, 4, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 34970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Between 0-30% Health - Cast \'Frenzy\' (No Repeat) (Normal Dungeon)'),
(22844, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashtongue Battlelord - Between 0-30% Health - Say Line 0 (No Repeat) (Normal Dungeon)');
-- 23172 Hand of Gorefiend
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23172 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23172, 0, 0, 0, 0, 0, 100, 0, 5000, 16000, 45000, 60000, 0, 11, 38166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Hand of Gorefiend - In Combat - Cast \'Enrage\'');
-- 23049 Shadowmoon Weapon Master
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23049 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23049, 0, 0, 1, 1, 0, 100, 1, 1000, 1000, 0, 0, 0, 11, 41099, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Out of Combat - Cast \'Battle Stance\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 41106, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Out of Combat - Cast \'Battle Aura\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 2, 3, 2, 0, 100, 1, 0, 70, 0, 0, 0, 11, 41101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-70% Health - Cast \'Defensive Stance\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 41105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-70% Health - Cast \'Defensive Aura\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 4, 5, 2, 0, 100, 1, 0, 40, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-40% Health - Say Line 0 (No Repeat) (Normal Dungeon)'),
(23049, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 41100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-40% Health - Cast \'Berserker Stance\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 41107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-40% Health - Cast \'Berserker Aura\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 7, 0, 2, 0, 100, 0, 0, 30, 25000, 30000, 0, 11, 41097, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - Between 0-30% Health - Cast \'Whirlwind\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 8, 0, 0, 0, 100, 0, 3000, 6000, 8000, 11000, 0, 11, 41103, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast \'Mutilate\' (No Repeat) (Normal Dungeon)'),
(23049, 0, 9, 0, 0, 0, 100, 0, 6000, 8000, 12000, 16000, 0, 11, 18813, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Weapon Master - In Combat - Cast \'Knock Away\' (No Repeat) (Normal Dungeon)');
-- 23196 Bonechewer Behemoth
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23196 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23196, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 25000, 45000, 0, 11, 41277, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - In Combat - Cast \'Fiery Comet\''),
(23196, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 30000, 40000, 0, 11, 41274, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - In Combat - Cast \'Fel Stomp\''),
(23196, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 40743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - Between 0-30% Health - Cast \'Frenzy\' (No Repeat) (Normal Dungeon)'),
(23196, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - Between 0-30% Health - Say Line 0 (No Repeat) (Normal Dungeon)'),
(23196, 0, 4, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 41272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Behemoth - On Aggro - Cast \'Behemoth Charge\' (No Repeat) (Normal Dungeon)');
-- 23239 Bonechewer Combatant
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23239 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23239, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Combatant - Between 0-30% Health - Cast \'Frenzy\' (No Repeat) (Normal Dungeon)'),
(23239, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Combatant - Between 0-30% Health - Say Line 0 (No Repeat) (Normal Dungeon)');
-- 23237 Bonechewer Blood Prophet
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23237 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23237, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 41230, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - On Aggro - Cast \'Prophecy of Blood\' (Normal Dungeon)'),
(23237, 0, 1, 0, 0, 0, 100, 0, 7500, 7500, 15000, 22500, 0, 11, 41229, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - In Combat - Cast \'Bloodbolt\' (Normal Dungeon)'),
(23237, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 41238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - Between 0-50% Health - Cast \'Blood Drain\' (Normal Dungeon)'),
(23237, 0, 3, 4, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - Between 0-30% Health - Cast \'Frenzy\' (No Repeat) (Normal Dungeon)'),
(23237, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Blood Prophet - Between 0-30% Health - Say Line 0 (No Repeat) (Normal Dungeon)');

-- creature_text for the SAY actions above
DELETE FROM `creature_text` WHERE `entry` = 22844;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(22844, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Ashtongue Battlelord');
DELETE FROM `creature_text` WHERE `entry` = 23049;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23049, 0, 0, 'Berserker Stance! Attack them recklessly!', 12, 0, 100, 0, 0, 0, 'Shadowmoon Weapon Master');
DELETE FROM `creature_text` WHERE `entry` = 23196;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23196, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Bonechewer Behemoth');
DELETE FROM `creature_text` WHERE `entry` = 23239;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23239, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Bonechewer Combatant');
DELETE FROM `creature_text` WHERE `entry` = 23237;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23237, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 'Bonechewer Blood Prophet');
