-- What the launcher uploads to the feedback API (tools/feedback), and what the
-- GitHub worker has posted of it. Needs bug_reports.sql first. Files are kept
-- on disk by the API; these rows say where.

-- The world server looks up a character's fixed reports at each login.
SET @have_index := (SELECT COUNT(*) FROM information_schema.statistics
    WHERE table_schema = DATABASE() AND table_name = 'bug_reports' AND index_name = 'idx_character');
SET @add_index := IF(@have_index = 0,
    'ALTER TABLE `bug_reports` ADD KEY `idx_character` (`realm_id`, `character_guid`, `status`)', 'DO 0');
PREPARE add_index FROM @add_index;
EXECUTE add_index;
DEALLOCATE PREPARE add_index;

-- Screenshots, each matched by the API to one bug report of the same account
-- (by the time it was taken). The worker commits them to the images repository
-- and links them in the report's issue.
CREATE TABLE IF NOT EXISTS `bug_report_attachment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `file_name` VARCHAR(128) NOT NULL COMMENT 'name in the player''s Screenshots folder',
  `sha256` CHAR(64) NOT NULL,
  `size` INT UNSIGNED NOT NULL,
  `taken_at` INT UNSIGNED NOT NULL COMMENT 'server time, corrected for the PC clock',
  `uploaded_at` INT UNSIGNED NOT NULL,
  `stored_path` VARCHAR(255) NOT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL COMMENT 'set once the worker has published it',
  `posted` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_sha` (`account_id`, `sha256`),
  KEY `idx_report` (`report_id`),
  KEY `idx_posted` (`posted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Screenshots for bug reports';

-- Client crashes, grouped by signature (error code, exception and the top
-- frames as module + offset). One GitHub issue per group. In both group
-- tables github_issue NULL means not posted yet, 0 left unposted on purpose.
CREATE TABLE IF NOT EXISTS `feedback_crash_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `signature` CHAR(64) NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `summary` TEXT NOT NULL COMMENT 'the public part of the first log; no names, paths or memory',
  `build` VARCHAR(32) NOT NULL DEFAULT '',
  `first_seen` INT UNSIGNED NOT NULL,
  `last_seen` INT UNSIGNED NOT NULL,
  `occurrences` INT UNSIGNED NOT NULL DEFAULT 0,
  `accounts` INT UNSIGNED NOT NULL DEFAULT 0,
  `github_issue` INT UNSIGNED NULL DEFAULT NULL,
  `posted_occurrences` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Client crash signatures';

-- Each crash log uploaded. The full log (and the .dmp, when the player sends
-- it) stays on the server: they hold the player's names and memory.
CREATE TABLE IF NOT EXISTS `feedback_crash` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `file_name` VARCHAR(128) NOT NULL,
  `sha256` CHAR(64) NOT NULL,
  `crashed_at` INT UNSIGNED NOT NULL COMMENT 'server time, corrected for the PC clock',
  `uploaded_at` INT UNSIGNED NOT NULL,
  `log_path` VARCHAR(255) NOT NULL,
  `dump_path` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account_sha` (`account_id`, `sha256`),
  KEY `idx_account_file` (`account_id`, `file_name`),
  KEY `idx_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Uploaded client crash logs';

-- Lua errors from the Error Catcher add-on, grouped by file + line + message.
CREATE TABLE IF NOT EXISTS `feedback_lua_error_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `signature` CHAR(64) NOT NULL,
  `kind` VARCHAR(16) NOT NULL DEFAULT 'error',
  `message` TEXT NOT NULL,
  `file` VARCHAR(255) NOT NULL DEFAULT '',
  `line` INT UNSIGNED NOT NULL DEFAULT 0,
  `stack` TEXT NOT NULL,
  `build` VARCHAR(32) NOT NULL DEFAULT '',
  `first_seen` INT UNSIGNED NOT NULL,
  `last_seen` INT UNSIGNED NOT NULL,
  `occurrences` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'sum of feedback_lua_error_account.count',
  `accounts` INT UNSIGNED NOT NULL DEFAULT 0,
  `github_issue` INT UNSIGNED NULL DEFAULT NULL,
  `posted_occurrences` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_signature` (`signature`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Lua error signatures';

-- The add-on keeps a running count per error, and the launcher sends the
-- whole list each time, so each account's count is kept (the highest seen),
-- not added up.
CREATE TABLE IF NOT EXISTS `feedback_lua_error_account` (
  `group_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `count` INT UNSIGNED NOT NULL,
  `last_seen` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`group_id`, `account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Lua error counts per account';

-- The worker's own bookmarks (when it last read closed issues, ...).
CREATE TABLE IF NOT EXISTS `feedback_state` (
  `name` VARCHAR(64) NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='GitHub worker bookmarks';
