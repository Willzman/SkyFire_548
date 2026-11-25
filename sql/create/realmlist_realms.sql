-- Registers the Stable (id 1, port 8085) and Development (id 2, port 8086)
-- realms. Run against the `auth` database after sql/base/auth_database.sql.
-- Safe to re-run; it renames the default realm row 1 to "Stable".
-- The ids and ports must match RealmID / WorldServerPort in each realm's
-- worldserver.conf (tools/realms/configure_realm.sh sets them).

INSERT INTO `realmlist` (`id`, `name`, `address`, `localAddress`, `localSubnetMask`, `port`, `icon`, `flag`, `timezone`, `allowedSecurityLevel`, `population`, `gamebuild`)
VALUES
    (1, 'Stable',      '127.0.0.1', '127.0.0.1', '255.255.255.0', 8085, 0, 0, 1, 0, 0, 18414),
    (2, 'Development', '127.0.0.1', '127.0.0.1', '255.255.255.0', 8086, 0, 0, 1, 0, 0, 18414)
ON DUPLICATE KEY UPDATE
    `name` = VALUES(`name`),
    `port` = VALUES(`port`);
