-- Bindings to scripts the core already has (D18). Each one was checked against the script source.
-- Safe to run twice.

-- Bosses that had no script at all
UPDATE `creature_template` SET `ScriptName` = 'boss_zum_rah' WHERE `entry` = 7271 AND `ScriptName` = '';  -- Witch Doctor Zum'rah (Zul'Farrak)
UPDATE `creature_template` SET `ScriptName` = 'boss_daakara' WHERE `entry` = 23863 AND `ScriptName` = ''; -- Daakara (Zul'Aman); sets the encounter state
UPDATE `creature_template` SET `ScriptName` = 'boss_thorim' WHERE `entry` = 32865 AND `ScriptName` = '';  -- Thorim (Ulduar); sets the encounter state

-- Trial of the Champion: the other Memories (14 of 25 were bound) and the third risen ghoul
UPDATE `creature_template` SET `ScriptName` = 'npc_memory' WHERE `ScriptName` = '' AND `entry` IN (34942,35032,35033,35036,35037,35041,35043,35044,35050,35051,35052);
UPDATE `creature_template` SET `ScriptName` = 'npc_risen_ghoul' WHERE `entry` = 35590 AND `ScriptName` = ''; -- Risen Champion

-- Spell scripts
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN ((25040,'spell_mark_of_nature'),(41055,'spell_gen_clone_weapon'),(57593,'spell_gen_clone_weapon'),
 (63416,'spell_gen_clone_weapon'),(69891,'spell_gen_clone_weapon'),(69892,'spell_gen_clone_weapon'),(61698,'spell_gen_ds_flush_knockback'),
 (64126,'spell_yogg_saron_squeeze'),(70914,'spell_dreamwalker_decay_periodic_timer'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25040,'spell_mark_of_nature'),               -- Mark of Nature (emerald dragons)
(41055,'spell_gen_clone_weapon'),             -- Copy Weapon
(57593,'spell_gen_clone_weapon'),
(63416,'spell_gen_clone_weapon'),
(69891,'spell_gen_clone_weapon'),
(69892,'spell_gen_clone_weapon'),             -- Copy Offhand Weapon
(61698,'spell_gen_ds_flush_knockback'),       -- Flush - Knockback effect (Dalaran sewers arena)
(64126,'spell_yogg_saron_squeeze'),           -- Squeeze, 25 player
(70914,'spell_dreamwalker_decay_periodic_timer'); -- Valithria: Column of Frost timer
