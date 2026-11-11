-- C2 Priest: Mindbender (62982) returns mana like the Shadowfiend.
-- Its Mana Leech aura (123050) was never applied (no addon row) and had no script.
DELETE FROM `creature_template_addon` WHERE `entry` = 62982;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(62982, 0, 0, 0, 0, 0, '123050');

DELETE FROM `spell_script_names` WHERE `spell_id` = 123050 AND `ScriptName` = 'spell_pri_mana_leech';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(123050, 'spell_pri_mana_leech');

-- Same proc row as the Shadowfiend's 28305: every melee hit returns mana.
DELETE FROM `spell_proc_event` WHERE `entry` = 123050;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(123050, 0, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);
