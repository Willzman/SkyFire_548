-- Shaman cosmetic minor glyphs (class audit, part 2)

-- Glyph of Rain of Frogs (147707) teaches Rain of Frogs (147709); the glyph aura itself is a dummy.
DELETE FROM `spell_learn_spell` WHERE (`entry`, `SpellID`) IN ((147707,147709));
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(147707, 147709, 1); -- Glyph of Rain of Frogs -> Rain of Frogs

-- Ghost Wolf while dead needs Glyph of Spirit Wolf; Far Sight indoors needs Glyph of Far Sight;
-- Astral Recall goes to the Earthshrine with Glyph of Astral Fixation.
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN
((2645,'spell_sha_glyph_of_spirit_wolf'),(6196,'spell_sha_far_sight'),(556,'spell_sha_astral_recall'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(2645, 'spell_sha_glyph_of_spirit_wolf'),
(6196, 'spell_sha_far_sight'),
(556, 'spell_sha_astral_recall');
