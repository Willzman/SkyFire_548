-- C7: class spell DB rows from Legends of Azeroth Pandaria (LoA) that SkyFire lacks.
-- Each row was checked against the 5.4.8 client (class, glyph and item set data) and against
-- SkyFire's scripts: rows whose effect a SkyFire script already casts or removes are left out
-- (Body and Soul, Sanctified Wrath, Killer Instinct, Fortifying Brew, Celestial Alignment,
-- Demonic Circle, Master of Subtlety, Paladin T15/T16, Leap of Faith, ...).

-- ---------------------------------------------------------------------------------------
-- 1. spell_linked_spell (type 0: positive trigger = cast effect when trigger is cast;
--    negative trigger = when trigger's aura fades, remove (-effect) the effect aura)
-- ---------------------------------------------------------------------------------------
DELETE FROM `spell_linked_spell` WHERE `type` = 0 AND (`spell_trigger`, `spell_effect`) IN (
(113858,138483),(113860,138483),(113861,138483),
(-113858,-138483),(-113860,-138483),(-113861,-138483),
(-113858,-148463),(-113860,-148463),(-113861,-148463),
(5784,143314),(23161,143314),(148970,143314),(148972,143314),
(-5784,-143314),(-23161,-143314),(-148970,-143314),(-148972,-143314),
(121471,138151),(-121471,-138151),
(16886,138351),(-16886,-138351),
(24858,114302),(-24858,-114302),
(22812,63058),
(5217,138358),
(-102355,-102354),
(-106731,-102543),(-106731,-102558),(-106731,-102560),(-106731,-33891),
(3714,93061),(-3714,-93061),
(79206,105877),(-79206,-105877),
(114207,138127),
(1680,147297),
(51124,144901),(81340,144901),
(63735,145327),
(781,115927));
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
-- Warlock
(113858, 138483, 0, 'Dark Soul: Instability - Warlock T15 2P bonus'),
(113860, 138483, 0, 'Dark Soul: Misery - Warlock T15 2P bonus'),
(113861, 138483, 0, 'Dark Soul: Knowledge - Warlock T15 2P bonus'),
(-113858, -138483, 0, 'Dark Soul: Instability - remove Warlock T15 2P bonus'),
(-113860, -138483, 0, 'Dark Soul: Misery - remove Warlock T15 2P bonus'),
(-113861, -138483, 0, 'Dark Soul: Knowledge - remove Warlock T15 2P bonus'),
(-113858, -148463, 0, 'Dark Soul: Instability - remove Raging Soul (Warlock T14 4P)'),
(-113860, -148463, 0, 'Dark Soul: Misery - remove Raging Soul (Warlock T14 4P)'),
(-113861, -148463, 0, 'Dark Soul: Knowledge - remove Raging Soul (Warlock T14 4P)'),
(5784, 143314, 0, 'Felsteed - Glyph of Nightmares'),
(23161, 143314, 0, 'Dreadsteed - Glyph of Nightmares'),
(148970, 143314, 0, 'Felsteed - Glyph of Nightmares'),
(148972, 143314, 0, 'Dreadsteed - Glyph of Nightmares'),
(-5784, -143314, 0, 'Felsteed - remove Glyph of Nightmares'),
(-23161, -143314, 0, 'Dreadsteed - remove Glyph of Nightmares'),
(-148970, -143314, 0, 'Felsteed - remove Glyph of Nightmares'),
(-148972, -143314, 0, 'Dreadsteed - remove Glyph of Nightmares'),
-- Rogue
(121471, 138151, 0, 'Shadow Blades - Rogue T15 4P bonus'),
(-121471, -138151, 0, 'Shadow Blades - remove Rogue T15 4P bonus'),
-- Druid
(16886, 138351, 0, 'Nature''s Grace - Druid T15 Balance 4P bonus'),
(-16886, -138351, 0, 'Nature''s Grace - remove Druid T15 Balance 4P bonus'),
(24858, 114302, 0, 'Moonkin Form - Astral Form (Glyph of Stars)'),
(-24858, -114302, 0, 'Moonkin Form - remove Astral Form (Glyph of Stars)'),
(22812, 63058, 0, 'Barkskin - Glyph of Amberskin Protection'),
(5217, 138358, 0, 'Tiger''s Fury - Druid T15 Feral 4P bonus'),
(-102355, -102354, 0, 'Faerie Swarm - remove Faerie Swarm snare'),
(-106731, -102543, 0, 'Incarnation talent removed - remove Incarnation: King of the Jungle'),
(-106731, -102558, 0, 'Incarnation talent removed - remove Incarnation: Son of Ursoc'),
(-106731, -102560, 0, 'Incarnation talent removed - remove Incarnation: Chosen of Elune'),
(-106731, -33891, 0, 'Incarnation talent removed - remove Incarnation: Tree of Life'),
-- Death Knight
(3714, 93061, 0, 'Path of Frost - Glyph of Path of Frost'),
(-3714, -93061, 0, 'Path of Frost - remove Glyph of Path of Frost'),
(51124, 144901, 0, 'Killing Machine - Death Shroud (Death Knight T16 DPS 2P)'),
(81340, 144901, 0, 'Sudden Doom - Death Shroud (Death Knight T16 DPS 2P)'),
-- Shaman
(79206, 105877, 0, 'Spiritwalker''s Grace - Shaman T13 Restoration 4P bonus'),
(-79206, -105877, 0, 'Spiritwalker''s Grace - remove Shaman T13 Restoration 4P bonus'),
-- Warrior
(114207, 138127, 0, 'Skull Banner - Warrior T15 DPS 4P bonus'),
(1680, 147297, 0, 'Whirlwind - Glyph of the Raging Whirlwind'),
-- Priest
(63735, 145327, 0, 'Serendipity - Priest T16 Healer 2P bonus'),
-- Hunter
(781, 115927, 0, 'Disengage - Glyph of Liberation');

-- ---------------------------------------------------------------------------------------
-- 2. conditions: the linked casts above are triggered, so they skip the spell's own aura
--    requirement. These rows make each one need its set bonus or glyph (as in LoA).
--    Type 1 = has aura, type 25 = knows spell; ErrorType 29 = don't report.
-- ---------------------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` IN
(138483, 143314, 138151, 138351, 114302, 63058, 138358, 93061, 144901, 105877, 138127, 147297, 145327, 115927);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 138483, 0, 0, 1, 0, 138129, 0, 0, 0, 29, 0, '', 'Dark Soul (Warlock T15 2P) - needs the set bonus aura'),
(17, 0, 143314, 0, 0, 1, 0, 56232, 0, 0, 0, 29, 0, '', 'Glyph of Nightmares - needs the glyph'),
(17, 0, 138151, 0, 0, 1, 0, 138150, 0, 0, 0, 29, 0, '', 'Shadow Blades (Rogue T15 4P) - needs the set bonus aura'),
(17, 0, 138351, 0, 0, 1, 0, 138350, 0, 0, 0, 29, 0, '', 'Nature''s Grace (Druid T15 Balance 4P) - needs the set bonus aura'),
(17, 0, 114302, 0, 0, 1, 0, 114301, 0, 0, 0, 29, 0, '', 'Astral Form - needs Glyph of Stars'),
(17, 0, 63058, 0, 0, 25, 0, 63057, 0, 0, 0, 29, 0, '', 'Glyph of Amberskin Protection - needs the glyph'),
(17, 0, 138358, 0, 0, 1, 0, 138357, 0, 0, 0, 29, 0, '', 'Tiger''s Fury (Druid T15 Feral 4P) - needs the set bonus aura'),
(17, 0, 93061, 0, 0, 1, 0, 59307, 0, 0, 0, 29, 0, '', 'Glyph of Path of Frost - needs the glyph'),
(17, 0, 144901, 0, 0, 1, 0, 144899, 0, 0, 0, 29, 0, '', 'Death Shroud (Death Knight T16 DPS 2P) - needs the set bonus aura'),
(17, 0, 105877, 0, 0, 1, 0, 105876, 0, 0, 0, 29, 0, '', 'Timewalker (Shaman T13 Restoration 4P) - needs the set bonus aura'),
(17, 0, 138127, 0, 0, 1, 0, 138126, 0, 0, 0, 29, 0, '', 'Skull Banner (Warrior T15 DPS 4P) - needs the set bonus aura'),
(17, 0, 147297, 0, 0, 1, 0, 146968, 0, 0, 0, 29, 0, '', 'Glyph of the Raging Whirlwind - needs the glyph'),
(17, 0, 145327, 0, 0, 1, 0, 145306, 0, 0, 0, 29, 0, '', 'Devout Faith (Priest T16 Healer 2P) - needs the set bonus aura'),
(17, 0, 115927, 0, 0, 25, 0, 132106, 0, 0, 0, 29, 0, '', 'Liberation - needs Glyph of Liberation');

-- ---------------------------------------------------------------------------------------
-- 3. spell_proc_event: auras that trigger a spell on their own (aura 42) and that SkyFire
--    has no handler for. Without a row they proc on every spell hit (client proc flags).
--    Masks checked against SpellClassOptions in the client. No cooldowns, so no ms/s issue.
-- ---------------------------------------------------------------------------------------
DELETE FROM `spell_proc_event` WHERE `entry` IN (87195, 58228, 123141, 145380);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(87195, 0, 6, 8192, 0, 0, 0, 0, 2, 0, 0, 0),         -- Glyph of Mind Blast: Mind Blast crits only
(58228, 0, 6, 0, 0, 0, 16, 0, 0, 0, 0, 0),           -- Glyph of Dark Archangel: Devouring Plague only
(123141, 0, 5, 0, 0, 262144, 0, 0, 0, 0, 0, 0),      -- Warlock T14 4P (Raging Soul): Dark Soul only
(145380, 0, 11, 0, 0, 536870912, 0, 0, 1, 0, 0, 0);  -- Shaman T16 Restoration 4P: Spiritwalker's Grace only

-- ---------------------------------------------------------------------------------------
-- 4. spell_learn_spell: glyphs that grant an ability (the glyph aura is a dummy)
-- ---------------------------------------------------------------------------------------
DELETE FROM `spell_learn_spell` WHERE (`entry`, `SpellID`) IN ((125045,132157),(126746,125050),(147788,148118));
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(125045, 132157, 1), -- Glyph of Holy Nova -> Holy Nova
(126746, 125050, 1), -- Glyph of Fetch -> Fetch
(147788, 148118, 1); -- Glyph of Elemental Familiars -> Summon Elemental Familiar
