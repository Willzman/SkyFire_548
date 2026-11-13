-- Hunter class audit

-- Powershot; Glyph of Solace (Freezing Trap, Scatter Shot); Glyph of Distracting Shot; Glyph of Animal Bond.
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN
((109259,'spell_hun_powershot'),
 (3355,'spell_hun_glyph_of_solace'),(19503,'spell_hun_glyph_of_solace'),
 (20736,'spell_hun_distracting_shot'),
 (20895,'spell_hun_glyph_of_animal_bond'),(24529,'spell_hun_glyph_of_animal_bond_effect'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(109259, 'spell_hun_powershot'),
(3355, 'spell_hun_glyph_of_solace'),
(19503, 'spell_hun_glyph_of_solace'),
(20736, 'spell_hun_distracting_shot'),
(20895, 'spell_hun_glyph_of_animal_bond'),
(24529, 'spell_hun_glyph_of_animal_bond_effect');
