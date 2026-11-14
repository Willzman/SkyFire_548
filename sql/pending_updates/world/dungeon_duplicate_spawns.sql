-- MoP dungeons: remove static spawns of creatures the boss and instance scripts summon themselves.
-- These rows are old sniffed copies of temporary summons (many stacked on one spot); with the scripts
-- in place they show up as extra, idle creatures. The Legends of Azeroth Pandaria world DB has none of them.
-- No creature_addon, creature_formations, linked_respawn or pool rows point at these spawns. Safe to run twice.

-- Gate of the Setting Sun (962): 179 Krik'thik Invaders (summoned by the Archer Target Spawners' aura 115141),
-- 69 Pandaren Cannoneers on 5 spots (summoned by the cannoneer event), 3 Krik'thik Strikers and
-- 2 Krik'thik Disruptors (summoned by Striker Ga'dok).
DELETE FROM `creature` WHERE `map` = 962 AND `id` IN (59892, 66905, 59778, 59794);

-- Shado-Pan Monastery (959): 24 Shado-Pan Novices, Fragrant Lotus and Flying Snow (summoned by Master Snowdrift),
-- the Azure Serpent (summoned by Gu Cloudstrike), 3 Ice Archers and 3 Fire Archers (summoned by the instance script).
DELETE FROM `creature` WHERE `map` = 959 AND `id` IN (56395, 56472, 56473, 56754, 56767, 64549);

-- Stormstout Brewery (961): 30 Fizzy Bubbles and 8 Yeasty Brew Alementals (summoned by Yan-Zhu),
-- 21 Hoplings, 11 Boppers and 17 Hoppers standing on and around Hoptallus (he summons his waves himself).
DELETE FROM `creature` WHERE `map` = 961 AND `id` IN (59799, 59494, 60208, 59551, 59464);

-- Temple of the Jade Serpent (960): 7 Consecration triggers spawned twice on exactly the same spot.
DELETE FROM `creature` WHERE `map` = 960 AND `id` = 43499 AND `guid` IN (4375, 4394, 4395, 4400, 4401, 4402, 4404);

-- Temple of the Jade Serpent: Haunting Sha had no AI (LoA SmartAI: casts Levitate 75333 out of combat)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `ScriptName` = '' AND `entry` IN (59555);

-- 59555 Haunting Sha
DELETE FROM `smart_scripts` WHERE `entryorguid` = 59555 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(59555, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 0, 11, 75333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Haunting Sha - Out of combat - Cast Levitate');
