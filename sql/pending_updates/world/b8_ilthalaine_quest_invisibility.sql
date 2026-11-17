-- B8 (issue #157): three Ilthalaines (2079) visible at once in Shadowglen.
-- Ilthalaine has one spawn per quest stage, each hidden by a quest invisibility aura
-- that spell_area lets the player see through:
--   guid 2573     before "The Balance of Nature" (28713) is done : 49415, seen with 49417
--   guid 8467027  from 28713 done until "Fel Moss Corruption" (28714) : 49414, seen with 49416
--   guid 8467026  after 28714 is done : 60921, seen with 60922
-- The spell_area rows and the two later spawns are already there; the original spawn had no
-- aura, so it stayed visible through every stage.
DELETE FROM `creature_addon` WHERE `guid`=2573;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(2573,0,0,0,1,0,'49415');
