-- Zul'Aman: Jan'alai and Halazzi scripts ported from Legends-of-Azeroth-Pandaria-5.4.8.
-- Safe to run twice.

-- Jan'alai summons her 36 Dragonhawk Eggs (23817) on every reset, so drop the static spawns.
DELETE FROM `creature` WHERE `id` = 23817 AND `map` = 568 AND `guid` IN
(221160,221161,221162,221163,221164,221165,221166,221167,221168,221169,221170,221171,221172,221173,221174,221175,221176,221177,
 221282,221283,221284,221285,221286,221287,221288,221289,221290,221291,221292,221293,221294,221295,221296,221297,221298,221299);
DELETE FROM `creature_addon` WHERE `guid` IN
(221160,221161,221162,221163,221164,221165,221166,221167,221168,221169,221170,221171,221172,221173,221174,221175,221176,221177,
 221282,221283,221284,221285,221286,221287,221288,221289,221290,221291,221292,221293,221294,221295,221296,221297,221298,221299);

-- Second Amani'shi Hatcher (other side of the platform) and Halazzi's totems
UPDATE `creature_template` SET `ScriptName` = 'npc_janalai_hatcher' WHERE `entry` = 24504;
UPDATE `creature_template` SET `ScriptName` = 'npc_halazzi_lightning_totem' WHERE `entry` = 24224;
UPDATE `creature_template` SET `ScriptName` = 'npc_halazzi_water_totem' WHERE `entry` = 52755;

-- Flame Breath walks a line of fire
DELETE FROM `spell_script_names` WHERE `spell_id` = 43140 AND `ScriptName` = 'spell_janalai_flame_breath';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (43140, 'spell_janalai_flame_breath');
