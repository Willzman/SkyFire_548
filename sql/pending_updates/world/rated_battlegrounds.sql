-- Rated battlegrounds (section 3, P14): the template the 10v10 rated queue uses (LoA's row; the map is picked at
-- random from BattleMasterList 100: Arathi Basin, Deepwind Gorge, Eye of the Storm, Silvershard Mines, Temple of
-- Kotmogu, Battle for Gilneas, Twin Peaks, Warsong Gulch). Safe to run twice.
DELETE FROM `battleground_template` WHERE `id` = 100;
INSERT INTO `battleground_template` (`id`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`, `StartMaxDist`, `Weight`, `ScriptName`, `Comment`) VALUES
(100, 10, 10, 90, 90, 0, 0, 0, 0, 0, 1, '', 'Rated Battleground 10x10');