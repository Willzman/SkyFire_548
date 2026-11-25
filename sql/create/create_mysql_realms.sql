-- Creates the databases for running a Stable and a Development realm side by
-- side on one MySQL server. Both realms share the `auth` database (accounts and
-- the realm list); each realm has its own world and characters databases.
--
--   Stable:      world_stable, characters_stable
--   Development: world_dev,    characters_dev
--
-- Safe to re-run. Change the password before using this on a reachable server.
-- After importing sql/base/auth_database.sql into `auth`, run
-- sql/create/realmlist_realms.sql to register both realms.

CREATE DATABASE IF NOT EXISTS `auth` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE IF NOT EXISTS `world_stable` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE IF NOT EXISTS `characters_stable` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE IF NOT EXISTS `world_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE IF NOT EXISTS `characters_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER IF NOT EXISTS 'skyfire'@'localhost' IDENTIFIED BY 'skyfire';

CREATE USER IF NOT EXISTS 'skyfire'@'127.0.0.1' IDENTIFIED BY 'skyfire';

GRANT ALL PRIVILEGES ON `auth` . * TO 'skyfire'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `world_stable` . * TO 'skyfire'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `characters_stable` . * TO 'skyfire'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `world_dev` . * TO 'skyfire'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `characters_dev` . * TO 'skyfire'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `auth` . * TO 'skyfire'@'127.0.0.1' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `world_stable` . * TO 'skyfire'@'127.0.0.1' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `characters_stable` . * TO 'skyfire'@'127.0.0.1' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `world_dev` . * TO 'skyfire'@'127.0.0.1' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `characters_dev` . * TO 'skyfire'@'127.0.0.1' WITH GRANT OPTION;
