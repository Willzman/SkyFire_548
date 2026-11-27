-- Player bug reports, sent in game by the launcher's Bug Report add-on
-- (addon prefix SFBUG) and saved by the world server. In auth so that every
-- realm writes to the same list and one upload API and GitHub worker serve
-- them all; realm_id says which realm a report came from.
--
-- Columns from category to client_context come from the add-on and are not
-- trusted; the rest the server fills in itself.
CREATE TABLE IF NOT EXISTS `bug_reports` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ref` CHAR(16) NOT NULL COMMENT 'random, to find the row just inserted',
  `realm_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `character_guid` INT UNSIGNED NOT NULL,
  `character_name` VARCHAR(12) NOT NULL,
  `created_at` INT UNSIGNED NOT NULL COMMENT 'unix time the server saved it',
  `category` VARCHAR(16) NOT NULL,
  `description` TEXT NOT NULL,
  `client_context` TEXT NOT NULL COMMENT 'key=value lines from the add-on',
  `map_id` SMALLINT UNSIGNED NOT NULL,
  `zone_id` SMALLINT UNSIGNED NOT NULL,
  `area_id` SMALLINT UNSIGNED NOT NULL,
  `instance_id` INT UNSIGNED NOT NULL,
  `position_x` FLOAT NOT NULL,
  `position_y` FLOAT NOT NULL,
  `position_z` FLOAT NOT NULL,
  `orientation` FLOAT NOT NULL,
  `target_guid` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `target_entry` INT UNSIGNED NOT NULL DEFAULT 0,
  `level` TINYINT UNSIGNED NOT NULL,
  `class` TINYINT UNSIGNED NOT NULL,
  `race` TINYINT UNSIGNED NOT NULL,
  `core_revision` VARCHAR(255) NOT NULL,
  `status` ENUM('new','issued','fixed','closed') NOT NULL DEFAULT 'new',
  `github_issue` INT UNSIGNED NULL DEFAULT NULL,
  `player_notified` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ref` (`ref`),
  KEY `idx_account_time` (`account_id`, `created_at`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player bug reports from the Bug Report add-on';

-- Upload tokens for the launcher. The server hands one to the add-on, which
-- keeps it in its account-wide SavedVariables; the launcher reads it from
-- there and sends it with uploads. Only a SHA-256 of each token is kept here.
-- An account may have a few (one per PC it plays from).
CREATE TABLE IF NOT EXISTS `account_feedback_token` (
  `token_hash` CHAR(64) NOT NULL COMMENT 'uppercase hex SHA-256 of the token (itself 64 uppercase hex)',
  `account_id` INT UNSIGNED NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  `last_used` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`token_hash`),
  KEY `idx_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Launcher upload tokens for bug reports';
