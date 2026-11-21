-- Rated PvP (section 3, P14): personal ratings per bracket and season, the table of Legends of Azeroth Pandaria 5.4.8
-- (GPL v2). slot: 0 2v2, 1 3v3, 2 5v5, 3 rated battleground. Safe to run twice.
CREATE TABLE IF NOT EXISTS `rated_pvp_info` (
  `guid` int(10) unsigned NOT NULL,
  `slot` tinyint(3) unsigned NOT NULL,
  `season` smallint(5) unsigned NOT NULL,
  `rank` int(10) unsigned DEFAULT '0',
  `rating` smallint(5) unsigned DEFAULT '0',
  `matchmaker_rating` smallint(5) unsigned DEFAULT '0',
  `week_best` smallint(5) unsigned DEFAULT '0',
  `week_games` smallint(5) unsigned DEFAULT '0',
  `week_wins` smallint(5) unsigned DEFAULT '0',
  `season_best` smallint(5) unsigned DEFAULT '0',
  `season_games` smallint(5) unsigned DEFAULT '0',
  `season_wins` smallint(5) unsigned DEFAULT '0',
  `last_week_best` smallint(5) unsigned DEFAULT '0',
  `win_streak` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`slot`,`season`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Rated PvP: personal rating and matchmaker rating per character, bracket and season';