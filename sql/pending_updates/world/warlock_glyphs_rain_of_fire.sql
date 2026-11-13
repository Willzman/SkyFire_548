-- Warlock class audit, part 3

-- Glyph of Hand of Gul'dan (56248) teaches the ground-targeted Hand of Gul'dan (123194); the glyph itself is a dummy.
DELETE FROM `spell_learn_spell` WHERE (`entry`, `SpellID`) IN ((56248,123194));
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(56248, 123194, 1); -- Glyph of Hand of Gul'dan -> Hand of Gul'dan (location)

-- Rain of Fire: +50% damage on immolated targets. Felsteed / Dreadsteed: Glyph of Nightmares.
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN
((42223,'spell_warl_rain_of_fire_damage'),(104233,'spell_warl_rain_of_fire_damage'),
 (5784,'spell_warl_glyph_of_nightmares'),(23161,'spell_warl_glyph_of_nightmares'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(42223, 'spell_warl_rain_of_fire_damage'),
(104233, 'spell_warl_rain_of_fire_damage'),
(5784, 'spell_warl_glyph_of_nightmares'),
(23161, 'spell_warl_glyph_of_nightmares');
