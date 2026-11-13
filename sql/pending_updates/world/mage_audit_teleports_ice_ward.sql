-- Mage class audit

-- Teleports that had no destination: Ironforge, Darnassus, Thunder Bluff, Theramore, Tol Barad (both factions),
-- Vale of Eternal Blossoms (both factions). Coordinates from Legends of Azeroth Pandaria 5.4.8.
DELETE FROM `spell_target_position` WHERE `id` IN (3562, 3565, 3566, 49359, 88342, 88344, 132621, 132627) AND `effIndex` = 0;
INSERT INTO `spell_target_position` (`id`, `effIndex`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(3562, 0, 0, -4613.62, -915.38, 501.062, 3.88),          -- Teleport: Ironforge
(3565, 0, 1, 9660.81, 2513.64, 1331.66, 3.06),           -- Teleport: Darnassus
(3566, 0, 1, -964.98, 283.433, 111.187, 3.02),           -- Teleport: Thunder Bluff
(49359, 0, 1, -3730.72, -4422.21, 30.4836, 0.810732),    -- Teleport: Theramore
(88342, 0, 732, -344.6, 1043.8, 21.5, 1.5),              -- Teleport: Tol Barad
(88344, 0, 732, -601.4, 1382.03, 21.9, 1.5),             -- Teleport: Tol Barad
(132621, 0, 870, 821.5, 253.2, 503.919, 0.719747),       -- Teleport: Vale of Eternal Blossoms
(132627, 0, 870, 1678.73, 931.493, 471.5, 3.276);        -- Teleport: Vale of Eternal Blossoms

-- Ice Ward; Glyph of Remove Curse.
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN
((111264,'spell_mage_ice_ward'),(475,'spell_mage_glyph_of_remove_curse'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(111264, 'spell_mage_ice_ward'),
(475, 'spell_mage_glyph_of_remove_curse');
