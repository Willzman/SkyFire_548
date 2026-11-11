-- C2 Shaman: bind the scripts ported from Legends of Azeroth Pandaria (spell_shaman.cpp).
DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_sha_frozen_power', 'spell_sha_spirit_hunt', 'spell_sha_searing_flames_generate');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(8056, 'spell_sha_frozen_power'),               -- Frost Shock: Frozen Power root
(58877, 'spell_sha_spirit_hunt'),               -- Spirit Hunt (Feral Spirit wolves heal)
(3606, 'spell_sha_searing_flames_generate'),    -- Searing Bolt (Searing Totem)
(57984, 'spell_sha_searing_flames_generate'),   -- Fire Blast (Fire Elemental)
(12470, 'spell_sha_searing_flames_generate');   -- Fire Nova (Fire Elemental)

-- Feral Spirit wolves (29264) carry Spirit Hunt, as in LoA (SkyFire had no addon row for them).
DELETE FROM `creature_template_addon` WHERE `entry` = 29264;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(29264, 0, 0, 0, 0, 0, '58877');
