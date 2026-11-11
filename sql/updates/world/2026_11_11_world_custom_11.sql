-- C2 Mage: Glyph of Ice Block (115723) - Frost Nova and a short immunity when Ice Block ends (as in LoA).
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_glyph_of_ice_block';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45438, 'spell_mage_glyph_of_ice_block');
