-- C2: Vengeance for all five tank specs (spell_gen_vengeance, ported from LoA's spell_common_vengeance).
-- The passives come from the client's SpecializationSpells: Protection Paladin 84839, Guardian Druid 84840,
-- Protection Warrior 93098, Blood Death Knight 93099, Brewmaster Monk 120267.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_vengeance';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(84839, 'spell_gen_vengeance'),
(84840, 'spell_gen_vengeance'),
(93098, 'spell_gen_vengeance'),
(93099, 'spell_gen_vengeance'),
(120267, 'spell_gen_vengeance');

-- Proc on hits taken that land (hit, crit, block, absorb), as LoA (SkyFire only had the Monk row).
DELETE FROM `spell_proc_event` WHERE `entry` IN (84839, 84840, 93098, 93099, 120267);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(84839, 0, 0, 0, 0, 0, 0, 0, 1139, 0, 0, 0),
(84840, 0, 0, 0, 0, 0, 0, 0, 1139, 0, 0, 0),
(93098, 0, 0, 0, 0, 0, 0, 0, 1139, 0, 0, 0),
(93099, 0, 0, 0, 0, 0, 0, 0, 1139, 0, 0, 0),
(120267, 0, 0, 0, 0, 0, 0, 0, 1139, 0, 0, 0);
