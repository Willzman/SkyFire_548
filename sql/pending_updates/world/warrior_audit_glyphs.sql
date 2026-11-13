-- Warrior class audit

-- Glyph of Gag Order (Pummel, Heroic Throw); Glyph of the Executor (Execute); Glyph of the Raging Whirlwind (Whirlwind).
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN
((6552,'spell_warr_glyph_of_gag_order'),(57755,'spell_warr_glyph_of_gag_order'),
 (5308,'spell_warr_glyph_of_the_executor'),
 (1680,'spell_warr_glyph_of_the_raging_whirlwind'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(6552, 'spell_warr_glyph_of_gag_order'),
(57755, 'spell_warr_glyph_of_gag_order'),
(5308, 'spell_warr_glyph_of_the_executor'),
(1680, 'spell_warr_glyph_of_the_raging_whirlwind');
