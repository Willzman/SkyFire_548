-- Druid class audit

-- Glyph of Charm Woodland Creature (57855) teaches Charm Woodland Creature (127757); the glyph itself is a dummy.
DELETE FROM `spell_learn_spell` WHERE (`entry`, `SpellID`) IN ((57855,127757));
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(57855, 127757, 1); -- Glyph of Charm Woodland Creature -> Charm Woodland Creature
