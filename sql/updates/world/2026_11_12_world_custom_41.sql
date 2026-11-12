-- Remove quests that Blizzard took out of the game in patch 4.0.3a (Cataclysm) and that must
-- not be obtainable in 5.4.8:
--   Felwood cleansed plants: Corrupted Songflower, Windblossom, Whipper Root, Night Dragon
--   Cenarion Plant Salve: Cleansing Felwood, Salve via Hunting/Mining/Gathering/Skinning/Disenchanting
--   Feralas: Corrupted Songflower (2878)
-- Some links came from the stock database, the rest from 2026_11_11_world_custom_05.sql.
-- Safe to run more than once.

DELETE FROM `creature_queststarter` WHERE `quest` IN (996, 998, 1514, 2523, 2878, 3363, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467, 5882, 5883, 5884, 5885, 5886, 5887, 5888, 5889, 5890, 5891);
DELETE FROM `creature_questender` WHERE `quest` IN (996, 998, 1514, 2523, 2878, 3363, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467, 5882, 5883, 5884, 5885, 5886, 5887, 5888, 5889, 5890, 5891);
DELETE FROM `gameobject_queststarter` WHERE `quest` IN (996, 998, 1514, 2523, 2878, 3363, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467, 5882, 5883, 5884, 5885, 5886, 5887, 5888, 5889, 5890, 5891);
DELETE FROM `gameobject_questender` WHERE `quest` IN (996, 998, 1514, 2523, 2878, 3363, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467, 5882, 5883, 5884, 5885, 5886, 5887, 5888, 5889, 5890, 5891);

-- The four corrupted plant objects (164885-164888) we spawned as quest givers.
DELETE FROM `gameobject` WHERE `guid` IN (9500005, 9500006, 9500007, 9500008);
