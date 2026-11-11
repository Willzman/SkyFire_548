-- P1b: binding fixes.
--
-- 1. Restore the 12 bindings that 2026_11_11_world_custom_01.sql (PR #25) removed by mistake. Their scripts are in
--    SkyFire's core, registered with the RegisterSpellScript/RegisterAuraScript/RegisterCreatureAI macros
--    (spell_monk.cpp, zone_durotar.cpp), which the cleanup's name scan missed.
--
-- 2. Shu (55558) is the follower copy that SkyFire's npc_shu_dailo (on Shu 55556) summons for "Wake up Wugou" (29774).
--    Its npc_water_spirit_dailo binding names a Torghast script that would rerun that gossip and event on the
--    follower, so it is cleared instead of ported.
--
-- Safe to run twice.

-- Injured Razor Hill Grunt (Durotar)
UPDATE `creature_template` SET `ScriptName` = 'npc_injured_razor_hill_grunt' WHERE `entry` = 39270 AND `ScriptName` = '';

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 73141 AND `ScriptName` = 'spell_q25027_bramblestaff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (73141, 'spell_q25027_bramblestaff');
DELETE FROM `spell_script_names` WHERE `spell_id` = 73705 AND `ScriptName` = 'spell_injured_razor_hill_grunt_cancel_feign_death';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (73705, 'spell_injured_razor_hill_grunt_cancel_feign_death');
DELETE FROM `spell_script_names` WHERE `spell_id` = 107270 AND `ScriptName` = 'spell_monk_spinning_crane_kick_energize';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (107270, 'spell_monk_spinning_crane_kick_energize');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115070 AND `ScriptName` = 'spell_monk_stance_of_the_wise_serpent';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115070, 'spell_monk_stance_of_the_wise_serpent');
DELETE FROM `spell_script_names` WHERE `spell_id` = 116346 AND `ScriptName` = 'spell_monk_soothing_mist_trigger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (116346, 'spell_monk_soothing_mist_trigger');
DELETE FROM `spell_script_names` WHERE `spell_id` = 117640 AND `ScriptName` = 'spell_monk_spinning_crane_kick_energize';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (117640, 'spell_monk_spinning_crane_kick_energize');
DELETE FROM `spell_script_names` WHERE `spell_id` = 119031 AND `ScriptName` = 'spell_monk_gift_of_the_serpent_summon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (119031, 'spell_monk_gift_of_the_serpent_summon');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125967 AND `ScriptName` = 'spell_monk_glyph_of_leer_of_the_ox';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125967, 'spell_monk_glyph_of_leer_of_the_ox');
DELETE FROM `spell_script_names` WHERE `spell_id` = 126119 AND `ScriptName` = 'spell_monk_sanctuary_of_the_ox';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (126119, 'spell_monk_sanctuary_of_the_ox');
DELETE FROM `spell_script_names` WHERE `spell_id` = 134563 AND `ScriptName` = 'spell_monk_healing_elixirs_active';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (134563, 'spell_monk_healing_elixirs_active');
DELETE FROM `spell_script_names` WHERE `spell_id` = 148187 AND `ScriptName` = 'spell_monk_spinning_crane_kick_energize';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (148187, 'spell_monk_spinning_crane_kick_energize');

-- Shu (follower copy): leftover Torghast binding
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 55558 AND `ScriptName` = 'npc_water_spirit_dailo';
