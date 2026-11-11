-- C3: MoP spell-power coefficients.
-- The core now falls back to the SpellEffect.dbc coefficient (EffectBonusMultiplier) instead of the WotLK
-- cast-time formula, so WotLK rows that override it are removed and LoA's MoP values are taken for the rest.
-- SkyFire meaning of the SP columns (unchanged): -1 = use the DBC coefficient, 0 = no spell-power bonus.
-- LoA's rows use the opposite convention (0 = DBC, -1 = none) and were translated.
-- Checked against the 5.4.8 client (SpellEffect.dbc): 76 of the 80 removed rows have a MoP coefficient on their
-- damage or heal effect; Desperate Prayer and Entangling Roots have no damage or heal, and Unstable Affliction's
-- dispel damage already includes spell power. Prayer of Mending's heal keeps a row (see below).

-- 1. WotLK leftovers that override the DBC coefficient (SP only, no AP part)
DELETE FROM `spell_bonus_data` WHERE `entry` IN (116, 120, 133, 139, 331, 339, 348, 403, 421, 585, 589, 596, 603, 635, 686, 980, 1064, 1449, 1949, 2060, 2061, 2120, 2136, 2912, 2944, 2948, 3606, 5176, 5185, 5857, 6353, 7268, 8004, 8042, 8050, 8056, 8092, 8921, 8936, 11366, 14914, 17877, 19236, 19750, 23455, 25912, 25914, 26364, 27243, 27285, 29722, 30108, 30451, 30455, 31117, 31661, 31707, 32379, 33763, 34861, 34914, 42208, 42231, 44203, 44425, 44457, 44461, 44614, 45284, 45297, 47666, 47750, 47960, 48181, 50288, 51505, 59638, 61295, 64844);

-- 2. Rows LoA has with MoP values (Rake 1822 and Lacerate 33745 stay: SkyFire's scripts add their DoT AP)
-- 3. Class rows only LoA has
DELETE FROM `spell_bonus_data` WHERE `entry` IN (8511, 33110, 102355, 103990, 106830, 1079, 110705, 110804, 1120, 11426, 119839, 122283, 122284, 122287, 123258, 131623, 137597, 13812, 141004, 1463, 147891, 149276, 17, 2098, 2818, 31935, 3674, 45477, 47632, 47633, 48721, 49184, 52212, 53600, 55078, 55095, 6229, 6343, 6572, 689, 7001, 703, 770, 77758, 779, 78, 8680, 879, 89420, 9007, 974);
INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES
(102355, 0, 0, 0.302, 0, 'Faerie Swarm'),
(103990, 0, 0.334, 0, 0, 'Drain Life'),
(106830, 0, 0, 0.191, 0.141, 'Thrash (Cat)'),
(1079, 0, 0, 0, 0.0484, 'Rip'),
(110705, 0, 0, 0.04, 0, 'Consecration (symbiosis)'),
(110804, 0, 0, 0.133, 0, 'Lightning Shield (symbiosis)'),
(1120, 0, 0.257, 0, 0, 'Drain Soul'),
(11426, 3.3, 0, 0, 0, 'Ice Barrier'),
(119839, 3, 0, 0, 0, 'Fury Ward'),
(122283, 0, 0, 0.495, 0, 'Death Coil damage symbiosis'),
(122284, 0, 0, 1.7325, 0, 'Death Coil heal symbiosis'),
(122287, 0, 0, 1.4, 0, 'Wrath (Symbiosis)'),
(123258, 1.871, 0, 0, 0, 'Power Word: Shield'),
(131623, 3, 0, 0, 0, 'Twilight Ward (PvP set)'),
(137597, 0, 0, 0.75, 0, 'Lightning Strike'),
(13812, -1, -1, 0.0382, 0.0382, 'Explosive Trap'),
(141004, 0, 0, 0.75, 0, 'Lightning Strike'),
(1463, 1, 0, 0, 0, 'Incanter''s Ward'),
(147891, 0, 0, 0.2, 0, 'Flurry of Xuen'),
(149276, 0, 0, 0.2, 0, 'Flurry of Xuen'),
(17, 1.871, 0, 0, 0, 'Power Word: Shield'),
(2098, 0, 0, 0.18, 0, 'Eviscerate'),
(2818, 0, 0, 0, 0.213, 'Rogue - Deadly Poison'),
(31935, -1, 0, 0.818, 0, 'Avenger''s Shield'),
(3674, 0, 0, 0, 0.126, 'Black Arrow'),
(45477, 0, 0, 0.319, 0, 'Icy Touch'),
(47632, 0, 0, 0.514, 0, 'Death Coil'),
(47633, 0, 0, 1.799, 0, 'Death Coil (Heal)'),
(48721, 0, 0, 0.11, 0, 'Blood Boil'),
(49184, 0, 0, 0.738, 0, 'Howling Blast'),
(52212, -1, 0, 0.064, 0, 'Death and Decay'),
(53600, 0, 0, 0.617, 0, 'Shield of the Righteous'),
(55078, 0, 0, 0, 0.158, 'Blood Plague'),
(55095, 0, 0, 0, 0.158, 'Frost Fever'),
(6229, 3, 0, 0, 0, 'Twilight Ward'),
(6343, 0, 0, 0.45, 0, 'Thunder Clap'),
(6572, 0, 0, 0.64, 0, 'Revenge'),
(689, 0, 0.334, 0, 0, 'Drain Life'),
(7001, 0, 0.8295, 0, 0, 'Lightwell Renew'),
(703, -1, -1, 0, 0.078, 'Rogue - Garrote'),
(770, 0, 0, 0.302, 0, 'Faerie Fire'),
(77758, 0, 0, 0.191, 0.141, 'Thrash (Bear)'),
(779, 0, 0, 0.225, 0, 'Swipe (Bear)'),
(78, -1, -1, 0.6, 0, 'Warrior - Heroic Strike'),
(8680, 0, 0, 0.12, 0, 'Wound Poison'),
(879, 0, 0, 0.677, 0, 'Exorcism'),
(89420, 0, 0.334, 0, 0, 'Drain Life (Soulburn)'),
(9007, 0, 0, 0, 0.053, 'Druid - Pounce Bleed'),
(974, 0.13, 0, 0, 0, 'Earth Shield'),
(33110, 0.571, 0, 0, 0, 'Prayer of Mending (heal): MoP coefficient, which the client keeps on 33076'),
(8511, 0, 0, 0, 0, 'Small Seaforium Backfire: no spell power (client has 100)');
