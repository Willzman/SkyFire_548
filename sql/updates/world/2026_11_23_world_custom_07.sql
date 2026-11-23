-- MoP world bosses (map 870). Source: Legends of Azeroth Pandaria 5.4.8 (GPL v2), world DB of 2024-07-22; the
-- pandaria_5.4.8 world DB (GPL v2) has the same spawns. No database names; safe to run twice.
-- All ten world bosses already have spawnMask 1 (the only difficulty an open-world map has) and their scripts.

-- Sha of Anger was spawned twice at the same spot (8169612, 8174658), so two were up at once. LoA has five spawn
-- spots in Kun-Lai Summit in one pool (one up at a time, at a random spot): keep 8169612 (LoA's third spot), drop the
-- duplicate, add the other four, and put all five in pool 255 (already in pool_template, max_limit 1, with no members).
-- Respawn time stays SkyFire's (120 s).
DELETE FROM `creature` WHERE `guid` = 8174658 AND `id` = 60491;
DELETE FROM `creature_addon` WHERE `guid` = 8174658;
DELETE FROM `pool_creature` WHERE `guid` = 8174658;
DELETE FROM `creature` WHERE `guid` BETWEEN 9690429 AND 9690432;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9690429, 60491, 870, 1, 0, 0, 0, 0, 1958.73, 1634.28, 482.576, 0.491481, 120, 0, 0, 0, 0, 0, 0, 0, 0),
(9690430, 60491, 870, 1, 0, 0, 0, 0, 2361.8, 595.601, 494.394, 0.89169, 120, 0, 0, 0, 0, 0, 0, 0, 0),
(9690431, 60491, 870, 1, 0, 0, 0, 0, 2924.01, 1476, 648.314, 3.58546, 120, 0, 0, 0, 0, 0, 0, 0, 0),
(9690432, 60491, 870, 1, 0, 0, 0, 0, 2955.4, 407.047, 507.075, 1.45169, 120, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM `pool_template` WHERE `entry` = 255;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (255, 1, 'Sha of Anger (60491)');
DELETE FROM `pool_creature` WHERE `pool_entry` = 255 OR `guid` IN (8169612, 9690429, 9690430, 9690431, 9690432);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(8169612, 255, 0, 'Sha of Anger (60491)'),
(9690429, 255, 0, 'Sha of Anger (60491)'),
(9690430, 255, 0, 'Sha of Anger (60491)'),
(9690431, 255, 0, 'Sha of Anger (60491)'),
(9690432, 255, 0, 'Sha of Anger (60491)');

-- Xuen stood in the middle of the Celestial Court; LoA and pandaria_5.4.8 have him at his corner, like the other three
UPDATE `creature` SET `position_x` = -740.804, `position_y` = -4955.08, `position_z` = -6.19405, `orientation` = 5.63687 WHERE `guid` = 8183773 AND `id` = 71953;
