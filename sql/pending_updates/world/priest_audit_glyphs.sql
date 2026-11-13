-- Priest class audit

-- Glyph of Confession (126152) teaches Confession (126123); the glyph itself is a dummy.
DELETE FROM `spell_learn_spell` WHERE (`entry`, `SpellID`) IN ((126152,126123));
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(126152, 126123, 1); -- Glyph of Confession -> Confession

DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN ((126123,'spell_pri_confession'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(126123, 'spell_pri_confession');
