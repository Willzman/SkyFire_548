-- Razorfen Downs (map 129) instance and boss scripts, ported from TrinityCore cata_classic.
-- Bindings, texts and Belnistrasz's escort path from TrinityCore TDB 4.4.2 (TDB_full_world_442.26081).
-- Safe to run twice.

-- Script bindings
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_tuten_kash'         WHERE `entry` = 7355;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_mordresh_fire_eye'  WHERE `entry` = 7357;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_glutton'            WHERE `entry` = 8567;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_belnistrasz'         WHERE `entry` = 8516;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_idol_room_spawner'   WHERE `entry` = 8611;

-- Texts (SkyFire's creature_text has no BroadcastTextId/TextRange/SoundPlayType columns)
DELETE FROM `creature_text` WHERE `entry` IN (7357, 7358, 8516, 8567);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(7357, 0, 0, 'We will enslave the quilboar!', 12, 0, 100, 1, 0, 5819, 'Mordresh Fire Eye - SAY_OOC_1'),
(7357, 1, 0, 'We will spread across this barren land!', 12, 0, 100, 1, 0, 5820, 'Mordresh Fire Eye - SAY_OOC_2'),
(7357, 2, 0, 'Soon, the Scourge will rule the world!', 12, 0, 100, 22, 0, 5821, 'Mordresh Fire Eye - SAY_OOC_3'),
(7357, 3, 0, 'Slay them, my brethren! For the Scourge!', 14, 0, 100, 0, 0, 5822, 'Mordresh Fire Eye - SAY_AGGRO'),
(7358, 0, 0, 'You\'ll never leave this place alive.', 14, 0, 100, 0, 0, 5825, 'amnennar SAY_AGGRO'),
(7358, 1, 0, 'Too easy.', 12, 0, 100, 0, 0, 5826, 'amnennar SAY_SLAY'),
(7358, 2, 0, 'I am the hand of the Lich King!', 14, 0, 100, 0, 0, 5827, 'amnennar SAY_HEALTH_75'),
(7358, 3, 0, 'To me, my servants!', 14, 0, 100, 0, 0, 5828, 'amnennar SAY_SUMMON_60'),
(7358, 4, 0, 'Come, spirits - attend your master!', 14, 0, 100, 0, 0, 5829, 'amnennar SAY_SUMMON_30'),
(7358, 5, 0, '%s begins to summon wraiths out of the freezing cold air!', 16, 0, 100, 0, 0, 0, 'amnennar EMOTE_SUMMON'),
(8516, 0, 0, 'All right, stay close.  These fiends will jump right out of the shadows at you if you let your guard down.', 12, 0, 100, 0, 0, 0, 'Belnistrasz SAY_QUEST_ACCEPTED'),
(8516, 1, 0, 'Okay, here we go.  It\'s going to take about five minutes to shut this thing down through the ritual.  Once I start, keep the vermin off of me or it will be the end of us all!', 12, 0, 100, 0, 0, 0, 'Belnistrasz SAY_EVENT_START'),
(8516, 2, 0, 'Three minutes left -- I can feel the energy starting to build!  Keep up the solid defense!', 14, 0, 100, 0, 0, 0, 'Belnistrasz SAY_EVENT_THREE_MIN_LEFT'),
(8516, 3, 0, 'Just two minutes to go!  We\'re half way there, but don\'t let your guard down!', 14, 0, 100, 0, 0, 0, 'Belnistrasz SAY_EVENT_TWO_MIN_LEFT'),
(8516, 4, 0, 'One more minute!  Hold on now, the ritual is about to take hold!', 14, 0, 100, 0, 0, 0, 'Belnistrasz SAY_EVENT_ONE_MIN_LEFT'),
(8516, 5, 0, 'That\'s it -- we made it!  The ritual is set in motion, and idol fires are about to go out for good!  You truly are the heroes I thought you would be!', 14, 0, 100, 4, 0, 0, 'Belnistrasz SAY_EVENT_END'),
(8516, 6, 0, 'You\'ll rue the day you crossed me, $n.', 12, 0, 100, 0, 0, 0, 'Belnistrasz SAY_AGGRO'),
(8516, 7, 0, 'Watch out for the $n!', 12, 0, 100, 0, 0, 0, 'Belnistrasz SAY_WATCH_OUT'),
(8567, 0, 0, 'Me smell stench of the living!', 14, 0, 100, 0, 0, 5823, 'Glutton - SAY_AGGRO'),
(8567, 1, 0, 'Me feast on you all!', 14, 0, 100, 0, 0, 5824, 'Glutton - SAY_SLAY'),
(8567, 2, 0, '%s is getting hungry!', 16, 0, 100, 0, 0, 0, 'Glutton - EMOTE_50%'),
(8567, 3, 0, '%s is getting VERY hungry!', 16, 0, 100, 0, 0, 0, 'Glutton - EMOTE 15%');

-- Belnistrasz's escort to the idol (TrinityCore path 6973680; the script stops at the last point)
DELETE FROM `waypoint_data` WHERE `id` = 6973680;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(6973680,  1, 2603.31, 724.335, 54.608,  0, 0, 0, 0, 100, 0),
(6973680,  2, 2593.38, 726.272, 55.112,  0, 0, 0, 0, 100, 0),
(6973680,  3, 2588.5,  733.195, 55.3959, 0, 0, 0, 0, 100, 0),
(6973680,  4, 2572.57, 752.516, 54.7182, 0, 0, 0, 0, 100, 0),
(6973680,  5, 2558.07, 748.301, 54.3559, 0, 0, 0, 0, 100, 0),
(6973680,  6, 2539.68, 777.136, 46.9515, 0, 0, 0, 0, 100, 0),
(6973680,  7, 2527.83, 800.84,  44.7471, 0, 0, 0, 0, 100, 0),
(6973680,  8, 2496,    785.754, 39.512,  0, 0, 0, 0, 100, 0),
(6973680,  9, 2484.36, 814.891, 43.5779, 0, 0, 0, 0, 100, 0),
(6973680, 10, 2501.13, 847.961, 47.5574, 0, 0, 0, 0, 100, 0),
(6973680, 11, 2537.36, 874.471, 47.678,  0, 0, 0, 0, 100, 0),
(6973680, 12, 2548.49, 894.651, 47.6931, 0, 0, 0, 0, 100, 0),
(6973680, 13, 2541.48, 910.51,  46.1722, 0, 0, 0, 0, 100, 0),
(6973680, 14, 2519.4,  925.633, 46.515,  0, 0, 0, 0, 100, 0),
(6973680, 15, 2527.24, 951.461, 49.2807, 0, 0, 0, 0, 100, 0),
(6973680, 16, 2541.68, 976.589, 50.4122, 0, 0, 0, 0, 100, 0),
(6973680, 17, 2554.08, 973.867, 50.3616, 0, 0, 0, 0, 100, 0),
(6973680, 18, 2575.6,  950.138, 52.8459, 0, 0, 0, 0, 100, 0);
