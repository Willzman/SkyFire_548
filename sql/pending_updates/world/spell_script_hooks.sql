-- Spell script bindings that could never run, and two that sat on the wrong spell. Safe to run twice.

-- The fixate target is picked by the spell the aura triggers (123742, an area effect), not by the aura (123740, on the caster)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (123740,123742) AND `ScriptName` = 'spell_dark_of_night_fixate';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (123742,'spell_dark_of_night_fixate');

-- Bombard: the aura is 120559, the area filter of the same script belongs to the spell it triggers (120202)
DELETE FROM `spell_script_names` WHERE `spell_id` = 120202 AND `ScriptName` = 'spell_rimok_saboteur_bombard';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (120202,'spell_rimok_saboteur_bombard');

-- Bindings with no hook that fits the spell (each logged "did not match dbc effect data" at every start):
-- Titan Gas 116779 is the periodic trigger; both scripts act on the spells it triggers (116803, 118327)
DELETE FROM `spell_script_names` WHERE `spell_id` = 116779 AND `ScriptName` IN ('spell_titan_gas','spell_titan_gas2');
-- Dart: 119311 is a cone, 119338 an aura on the caster, 120142 the damage (its own script); the filter is for the six trigger spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (119311,119338,120142) AND `ScriptName` = 'spell_dart';
-- Apparitions: 111698 is the periodic trigger, the absorb is 112060
DELETE FROM `spell_script_names` WHERE `spell_id` = 111698 AND `ScriptName` = 'spell_shadopan_apparitions';
-- Seaforium Blast: the achievement credit spell 60937 no longer exists, so the script fails its own check
DELETE FROM `spell_script_names` WHERE `spell_id` = 52408 AND `ScriptName` = 'spell_gen_seaforium_blast';
