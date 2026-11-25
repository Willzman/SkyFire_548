-- Upstream's Stormwind Royal Guard patrol (2026_11_22_world_04) deletes the duplicate road squad, guids 167468-167476.
-- One of them, 167473, had a patrol of its own from our patrol import: remove its spawn addon and path so they are not
-- left behind ("Creature (GUID: 167473) does not exist but has a record in `creature_addon`"). Safe to run twice.
DELETE `a` FROM `creature_addon` AS `a` LEFT JOIN `creature` AS `c` ON `c`.`guid` = `a`.`guid`
 WHERE `a`.`guid` BETWEEN 167468 AND 167476 AND `c`.`guid` IS NULL;
DELETE FROM `waypoint_data` WHERE `id` = 1674730
 AND NOT EXISTS (SELECT 1 FROM `creature_addon` WHERE `path_id` = 1674730);
