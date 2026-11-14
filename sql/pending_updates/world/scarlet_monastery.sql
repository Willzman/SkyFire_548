-- Scarlet Monastery (map 1004): script bindings, texts, templates, encounters and spawns for the scripts ported from
-- Legends of Azeroth Pandaria 5.4.8 (GPL v2). Values come from the LoA world DB (2024-07-22). Safe to run twice.


-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'boss_high_inqusitior_whitemane' WHERE `entry` = 3977; -- was 'boss_high_inquisitor_whitemane'
UPDATE `creature_template` SET `ScriptName` = 'npc_horseman_head' WHERE `entry` = 23775; -- was 'npc_head'
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_fanatic' WHERE `entry` = 58555; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_purifier' WHERE `entry` = 58569; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_zealot' WHERE `entry` = 58590; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_sc_spirit_of_redemption' WHERE `entry` = 58592; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_judicator' WHERE `entry` = 58605; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_brother_korloff' WHERE `entry` = 59223; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_trigger_scorched_flame' WHERE `entry` = 59507; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_flamethower' WHERE `entry` = 59705; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scm_fuel_tank' WHERE `entry` = 59706; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_pile_corpses' WHERE `entry` = 59722; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scarlet_centurion' WHERE `entry` = 59746; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_zombified_corpse' WHERE `entry` = 59771; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_thalnos_the_soulrender' WHERE `entry` = 59789; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_fallen_crusader' WHERE `entry` = 59884; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_empowering_spirit' WHERE `entry` = 59893; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_empowered_zombie' WHERE `entry` = 59930; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_evicted_soul' WHERE `entry` = 59974; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_frenzied_spirit' WHERE `entry` = 60033; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_commander_durand' WHERE `entry` = 60040; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scm_hooded_crusader' WHERE `entry` = 64838; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_pumpkin_shrine' WHERE `entry` = 186267; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 9232 AND `ScriptName` = 'spell_sc_scarlet_ressurection';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (9232, 'spell_sc_scarlet_ressurection');
DELETE FROM `spell_script_names` WHERE `spell_id` = 42281 AND `ScriptName` = 'spell_sprouting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (42281, 'spell_sprouting');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111670 AND `ScriptName` = 'spell_sc_ressurection';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111670, 'spell_sc_ressurection');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113134 AND `ScriptName` = 'spell_sc_mass_ressurection';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113134, 'spell_sc_mass_ressurection');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113764 AND `ScriptName` = 'spell_firestorm_kick';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113764, 'spell_firestorm_kick');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114460 AND `ScriptName` = 'spell_scorched_earth';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114460, 'spell_scorched_earth');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114952 AND `ScriptName` = 'spell_scm_barrel_explosion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114952, 'spell_scm_barrel_explosion');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115139 AND `ScriptName` = 'spell_raise_fallen_crusader';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115139, 'spell_raise_fallen_crusader');
DELETE FROM `spell_script_names` WHERE `spell_id` = 115519 AND `ScriptName` = 'spell_sc_cleave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (115519, 'spell_sc_cleave');
DELETE FROM `spell_script_names` WHERE `spell_id` = 125852 AND `ScriptName` = 'spell_korloff_burning_man';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (125852, 'spell_korloff_burning_man');

-- areatrigger_scripts
DELETE FROM `areatrigger_scripts` WHERE `entry` = 8364 AND `ScriptName` = 'AreaTrigger_at_scarlet_monastery';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (8364, 'AreaTrigger_at_scarlet_monastery');

UPDATE `instance_template` SET `script` = 'instance_scarlet_monastery' WHERE `map` = 1004; -- was ''

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
-- 3977 : replaces SkyFire's 3 rows (different groups) with LoA's 4
DELETE FROM `creature_text` WHERE `entry` = 3977;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(3977, 0, 0, 'Mograine has fallen! You shall pay for this treachery! Arise, my champion! Arise!', 14, 0, 100, 0, 0, 5838, 'whitemane SAY_WH_INTRO'),
(3977, 1, 0, 'The Light has spoken!', 14, 0, 100, 0, 0, 5839, 'whitemane SAY_WH_KILL'),
(3977, 2, 0, 'Arise, my champion!', 14, 0, 100, 0, 0, 5840, 'whitemane SAY_WH_RESSURECT'),
(3977, 3, 0, 'Arise, my champion!', 14, 0, 100, 0, 0, 5840, 'whitemane WHITEMANE_TALK_RESSURETION');
-- 23682 : replaces SkyFire's 5 rows (different groups) with LoA's 7
DELETE FROM `creature_text` WHERE `entry` = 23682;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23682, 0, 0, 'It is over, your search is done. Let fate choose now, the righteous one.', 14, 0, 100, 0, 0, 11961, 'headless horseman SAY_ENTRANCE'),
(23682, 1, 0, 'Here\'s my body, fit and pure!  Now, your blackened souls I\'ll cure!', 14, 0, 100, 0, 0, 12567, 'headless horseman SAY_REJOINED'),
(23682, 2, 0, 'Harken, cur! Tis you I spurn! Now feel... the burn!', 12, 0, 100, 0, 0, 0, 'headless horseman SAY_CONFLAGRATION'),
(23682, 3, 0, 'Soldiers arise, stand and fight! Bring victory at last to this fallen knight!', 14, 0, 100, 0, 0, 11963, 'headless horseman SAY_SPROUTING_PUMPKINS'),
(23682, 4, 0, 'This end have I reached before.  What new adventure lies in store?', 14, 0, 100, 0, 0, 11964, 'headless horseman SAY_DEATH'),
(23682, 4, 1, 'I am over here, you fool of a body!', 12, 0, 100, 0, 0, 12568, 'headless horseman SAY_PLAYER_DEATH'),
(23682, 5, 0, 'This end have I reached before.  What new adventure lies in store?', 12, 0, 100, 0, 0, 11964, 'headless horseman SAY_DEATH');
-- 23775 : replaces SkyFire's 2 rows (different groups) with LoA's 2
DELETE FROM `creature_text` WHERE `entry` = 23775;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(23775, 0, 0, 'So eager you are, for my blood to spill. Yet to vanquish me, \'tis my head you must kill!', 14, 0, 100, 0, 0, 11969, 'headless horseman SAY_LOST_HEAD'),
(23775, 1, 0, 'Your body lies beaten, battered and broken! Let my curse be your own, fate has spoken!', 14, 0, 100, 0, 0, 11962, 'headless horseman SAY_PLAYER_DEATH');
DELETE FROM `creature_text` WHERE `entry` = 59223;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59223, 0, 0, 'I will break you.', 14, 0, 100, 0, 0, 29496, 'Korloff_AGGRO'),
(59223, 1, 0, 'You are like... piece of iron...', 14, 0, 100, 0, 0, 29497, 'Korloff_DEATH'),
(59223, 2, 0, 'If you die, you die.', 14, 0, 100, 0, 0, 29500, 'Korloff_firestom'),
(59223, 3, 0, 'My fists are scarlet... with your blood!', 14, 0, 100, 0, 0, 29499, 'Korloff_Fists');
DELETE FROM `creature_text` WHERE `entry` = 59789;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59789, 0, 0, 'My endless agony shall be yours, as well!', 14, 0, 100, 396, 0, 27832, 'Thalnos_INTRO'),
(59789, 1, 0, 'No rest... for the angry dead!', 14, 0, 100, 396, 0, 27831, 'Thanlos_SUMMON'),
(59789, 2, 0, 'Seek out a vessel... and return!', 14, 0, 100, 396, 0, 27834, 'Thanlos_EVIC'),
(59789, 3, 0, 'Claim a body, and wreak terrible vengeance!', 14, 0, 100, 396, 0, 27835, 'Thalnos_spirits'),
(59789, 4, 0, 'Can this be... the end, at last...?', 14, 0, 100, 396, 0, 27830, 'Thalnos_dead'),
(59789, 5, 0, '|TInterface\\Icons\\spell_warlock_demonsoul.blp:20|t%s casts |cFFFF0000|Hspell:115297|h[Evict Soul]|h|r on |cFF006EFD$n|r!', 41, 0, 100, 0, 0, 0, 'THALNOS_EVICTED_SOUL_ANN'),
(59789, 6, 0, '|TInterface\\Icons\\ability_warlock_jinx.blp:20|t%s begins to cast |cFFFF0000|Hspell:115147|h[Empowering Spirits]|h|r!', 41, 0, 100, 0, 0, 0, 'THALNOS_EMPOWERED_SPIRIT_ANN');
DELETE FROM `creature_text` WHERE `entry` = 60040;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(60040, 0, 0, 'My legend begins NOW!', 12, 0, 100, 0, 0, 27527, 'Durand_intro'),
(60040, 1, 0, 'My blade is peerless!', 12, 0, 100, 0, 0, 27530, '');
DELETE FROM `creature_text` WHERE `entry` = 64838;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64838, 1, 0, 'Destroy the Piles of Corpses to stop the Zombified Corpses!', 41, 0, 100, 0, 0, 0, 'INSTANCE_INTRO_ANN');


-- spell_areatrigger_template (Thalnos's Spirit Gale)
DELETE FROM `spell_areatrigger_template` WHERE `Entry` = 220;
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES
(220, 0, 1, 2, 2, 2, 'sat_spirit_gale');

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `mechanic_immune_mask` = 634339327, `flags_extra` = 1 WHERE `entry` = 3977; -- High Inquisitor Whitemane
UPDATE `creature_template` SET `unit_flags` = 0, `mechanic_immune_mask` = 646658911 WHERE `entry` = 23682; -- Headless Horseman
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 23686; -- Headless Horseman Flame Bunny
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `flags_extra` = 128 WHERE `entry` = 23758; -- Headless Horseman - Earth Explosion Bunny
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `flags_extra` = 128 WHERE `entry` = 24034; -- Headless Horseman - Wisp Invis
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 67, `faction_H` = 67 WHERE `entry` = 58555; -- Scarlet Fanatic
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 67, `faction_H` = 67, `unit_class` = 8 WHERE `entry` = 58569; -- Scarlet Purifier
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 67, `faction_H` = 67, `unit_class` = 2 WHERE `entry` = 58590; -- Scarlet Zealot
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 67, `faction_H` = 67, `unit_class` = 8 WHERE `entry` = 58592; -- Spirit of Redemption
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 2156, `faction_H` = 2156 WHERE `entry` = 58605; -- Scarlet Judicator
UPDATE `creature_template` SET `minlevel` = 30, `maxlevel` = 30, `faction_A` = 67, `faction_H` = 67, `unit_class` = 2 WHERE `entry` = 58783; -- Scarlet Initiate
UPDATE `creature_template` SET `minlevel` = 34, `maxlevel` = 34, `faction_A` = 67, `faction_H` = 67, `mechanic_immune_mask` = 667893759, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59223; -- Brother Korloff
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 114, `faction_H` = 114, `flags_extra` = 128 WHERE `entry` = 59507; -- Scorched Earth
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 31, `faction_A` = 14, `faction_H` = 14, `VehicleId` = 2077 WHERE `entry` = 59705; -- Scarlet Flamethrower
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2110, `faction_H` = 2110 WHERE `entry` = 59706; -- Fuel Tank
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 31, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 131072, `mechanic_immune_mask` = 769638399 WHERE `entry` = 59722; -- Pile of Corpses
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 31, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 59746; -- Scarlet Centurion
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 31 WHERE `entry` = 59771; -- Zombified Corpse
UPDATE `creature_template` SET `minlevel` = 33, `maxlevel` = 33, `faction_A` = 16, `faction_H` = 16, `mechanic_immune_mask` = 634339327, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59789; -- Thalnos the Soulrender
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 1.1 WHERE `entry` = 59884; -- Fallen Crusader
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 14, `faction_H` = 14 WHERE `entry` = 59893; -- Empowering Spirit
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 1.1 WHERE `entry` = 59930; -- Empowered Zombie
UPDATE `creature_template` SET `minlevel` = 32, `maxlevel` = 32, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 2.8 WHERE `entry` = 59974; -- Evicted Soul
UPDATE `creature_template` SET `minlevel` = 31, `maxlevel` = 31, `faction_A` = 1814, `faction_H` = 1814 WHERE `entry` = 60033; -- Frenzied Spirit
UPDATE `creature_template` SET `minlevel` = 34, `maxlevel` = 34, `faction_A` = 67, `faction_H` = 67, `unit_flags` = 32832, `mechanic_immune_mask` = 667893759, `flags_extra` = 1 WHERE `entry` = 60040; -- Commander Durand
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 7, `faction_H` = 7, `unit_flags` = 262148 WHERE `entry` = 60197; -- Training Dummy
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 7, `faction_H` = 7, `unit_flags` = 262148 WHERE `entry` = 64446; -- Training Dummy
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE `entry` = 64835; -- \"Unto Dust Thou Shalt Return\" Kill Credit
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 1665, `faction_H` = 1665, `unit_class` = 2 WHERE `entry` = 64838; -- Hooded Crusader
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE `entry` = 64840; -- \"Unto Dust Thou Shalt Return\" Kill Credit
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `unit_class` = 2 WHERE `entry` = 64842; -- Hooded Crusader
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90 WHERE `entry` = 64855; -- Blade of the Anointed

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 58783;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (58783, 0, 0, 8, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 59706;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59706, 0, 0, 0, 1, 0, '114875');
DELETE FROM `creature_template_addon` WHERE `entry` = 59789;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59789, 0, 0, 0, 1, 0, '126653');
DELETE FROM `creature_template_addon` WHERE `entry` = 60033;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (60033, 0, 0, 50331648, 1, 0, '');

-- instance_encounters (DungeonEncounter.dbc ids; LFG dungeons 164 normal / 474 heroic end with Whitemane)
DELETE FROM `instance_encounters` WHERE `entry` IN (1423, 1424, 1425);
INSERT INTO `instance_encounters` (`entry`, `creditType`, `creditEntry`, `lastEncounterDungeon`, `comment`) VALUES
(1423, 0, 59789, 0, 'Thalnos the Soulrender'),
(1424, 0, 59223, 0, 'Brother Korloff'),
(1425, 0, 3977, 164, 'High Inquisitor Whitemane');

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Doodad_G_LeverMetal01', `faction` = 114 WHERE `entry` = 210548;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210549;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair', `faction` = 33 WHERE `entry` = 210550;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair', `faction` = 33 WHERE `entry` = 210551;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210552;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210553;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210554;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair', `faction` = 33 WHERE `entry` = 210555;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210556;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair', `faction` = 33 WHERE `entry` = 210557;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210558;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210559;
UPDATE `gameobject_template` SET `name` = 'Wooden Chair' WHERE `entry` = 210560;
UPDATE `gameobject_template` SET `name` = 'Suspicious Torch' WHERE `entry` = 210561;
UPDATE `gameobject_template` SET `name` = 'Doodad_MonestarySecretDoor01', `faction` = 1375, `flags` = 32 WHERE `entry` = 210562;
UPDATE `gameobject_template` SET `name` = 'Doodad_MonestaryBossDoor01', `faction` = 114, `flags` = 32 WHERE `entry` = 210563;
UPDATE `gameobject_template` SET `name` = 'Doodad_ScarletCathedralDoor01', `faction` = 114, `flags` = 32 WHERE `entry` = 210564;
UPDATE `gameobject_template` SET `name` = 'Graveyard Door', `size` = 0.495519, `faction` = 1375, `flags` = 32 WHERE `entry` = 211844;
UPDATE `gameobject_template` SET `name` = 'Blades of the Anointed Coffin', `faction` = 114, `flags` = 32 WHERE `entry` = 214285;
UPDATE `gameobject_template` SET `name` = 'Aura Red Tall (scale x1.5)', `faction` = 114, `flags` = 32 WHERE `entry` = 214286;
UPDATE `gameobject_template` SET `name` = 'Blade of the Anointed', `faction` = 114, `flags` = 32 WHERE `entry` = 214287;
UPDATE `gameobject_template` SET `name` = 'Aura Yellow Tall (scale x1.5)', `faction` = 114, `flags` = 32 WHERE `entry` = 214289;
UPDATE `gameobject_template` SET `name` = 'Pool Statue', `flags` = 32 WHERE `entry` = 214290;

-- chest loot SkyFire lacks
-- Blade of the Anointed (214284)
DELETE FROM `gameobject_loot_template` WHERE `entry` = 43122;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(43122, 87282, 100, 1, 0, 1, 1);
-- Blade of the Anointed (214296)
DELETE FROM `gameobject_loot_template` WHERE `entry` = 43126;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(43126, 87389, 100, 1, 0, 1, 1);



DELETE FROM `creature` WHERE `guid` BETWEEN 9509000 AND 9509172;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9509000, 3977, 1004, 262, 0, 0, 0, 0, 700.533, 605.764, 11.5924, 6.19592, 86400, 0, 0, 1, 6415, 0, 0, 0, 0), -- LoA 537330
(9509001, 64842, 1004, 262, 0, 0, 0, 0, 723.689, 605.68, 14.5363, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537331
(9509002, 4542, 1004, 262, 0, 0, 0, 0, 743.573, 649.481, 12.8883, 0.86033, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537332
(9509003, 60040, 1004, 262, 0, 0, 0, 0, 747.965, 605.971, 15.1105, 6.23986, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537333
(9509004, 58605, 1004, 262, 0, 0, 0, 0, 752.321, 546.028, 12.8877, 0.593412, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537334
(9509005, 58605, 1004, 262, 0, 0, 0, 0, 753.154, 550.778, 12.8859, 0.890118, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537335
(9509006, 58605, 1004, 262, 0, 0, 0, 0, 755.337, 544.255, 12.8845, 1.23918, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537336
(9509007, 58605, 1004, 262, 0, 0, 0, 0, 756.576, 550.286, 12.8843, 6.21337, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537337
(9509008, 58783, 1004, 262, 0, 0, 0, 0, 757.913, 660.122, 12.8879, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537338
(9509009, 58783, 1004, 262, 0, 0, 0, 0, 758.01, 663.43, 12.8862, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537339
(9509010, 58605, 1004, 262, 0, 0, 0, 0, 758.663, 544.073, 12.8846, 5.86431, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537340
(9509011, 58605, 1004, 262, 0, 0, 0, 0, 758.925, 548.054, 12.8826, 4.01426, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537341
(9509012, 58590, 1004, 262, 0, 0, 0, 0, 760.762, 551.483, 12.8863, 4.67748, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537342
(9509013, 58590, 1004, 262, 0, 0, 0, 0, 761.007, 655.733, 12.8891, 1.50098, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537343
(9509014, 58783, 1004, 262, 0, 0, 0, 0, 761.188, 659.903, 12.8869, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537344
(9509015, 58783, 1004, 262, 0, 0, 0, 0, 761.403, 663.389, 12.8851, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537346
(9509016, 58605, 1004, 262, 0, 0, 0, 0, 761.472, 546.904, 12.884, 1.22173, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537347
(9509017, 58605, 1004, 262, 0, 0, 0, 0, 763.071, 550.677, 12.8852, 4.13643, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537348
(9509018, 58605, 1004, 262, 0, 0, 0, 0, 763.875, 543.892, 12.8864, 5.07891, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537349
(9509019, 58783, 1004, 262, 0, 0, 0, 0, 764.208, 659.851, 12.886, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537350
(9509020, 58783, 1004, 262, 0, 0, 0, 0, 764.639, 663.434, 12.884, 4.66003, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537351
(9509021, 58605, 1004, 262, 0, 0, 0, 0, 765.295, 546.938, 12.8852, 3.4383, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537352
(9509022, 58605, 1004, 262, 0, 0, 0, 0, 767.083, 551.016, 12.8874, 1.09956, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537354
(9509023, 58605, 1004, 262, 0, 0, 0, 0, 767.945, 543.682, 12.8875, 0.0174533, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537355
(9509024, 58605, 1004, 262, 0, 0, 0, 0, 768.958, 547.529, 12.8864, 3.29867, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537356
(9509025, 58605, 1004, 262, 0, 0, 0, 0, 770.43, 549.938, 12.8875, 1.65806, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537357
(9509026, 58555, 1004, 262, 0, 0, 0, 0, 785.271, 595.611, 12.8833, 0.766644, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537358
(9509027, 58569, 1004, 262, 0, 0, 0, 0, 785.535, 598.663, 12.8862, 5.32505, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537359
(9509028, 58569, 1004, 262, 0, 0, 0, 0, 785.775, 586.867, 12.8002, 0.00961565, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537360
(9509029, 58590, 1004, 262, 0, 0, 0, 0, 788.023, 595.385, 12.8845, 2.25593, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537361
(9509030, 58555, 1004, 262, 0, 0, 0, 0, 788.151, 598.424, 12.8864, 3.92183, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537362
(9509031, 58569, 1004, 262, 0, 0, 0, 0, 793.021, 582.766, 12.8911, 4.69494, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537363
(9509032, 58569, 1004, 262, 0, 0, 0, 0, 793.191, 628.524, 12.8904, 1.50098, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537364
(9509033, 58569, 1004, 262, 0, 0, 0, 0, 799.761, 586.962, 12.8034, 0.00172284, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537365
(9509034, 58569, 1004, 262, 0, 0, 0, 0, 803.771, 614.448, 12.8864, 0.621373, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537367
(9509035, 58555, 1004, 262, 0, 0, 0, 0, 803.861, 616.776, 12.8852, 5.62101, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537368
(9509036, 58590, 1004, 262, 0, 0, 0, 0, 806.908, 614.271, 12.8863, 2.42886, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537369
(9509037, 58555, 1004, 262, 0, 0, 0, 0, 806.91, 616.245, 12.8858, 3.54136, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537370
(9509038, 58569, 1004, 262, 0, 0, 0, 0, 811.835, 582.561, 12.8903, 4.69494, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537371
(9509039, 58569, 1004, 262, 0, 0, 0, 0, 811.913, 628.281, 12.8899, 1.50098, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537372
(9509040, 58569, 1004, 262, 0, 0, 0, 0, 815.787, 586.989, 12.8061, 0.00172281, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537373
(9509041, 58569, 1004, 262, 0, 0, 0, 0, 821.259, 624.171, 12.7987, 6.27486, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537374
(9509042, 58569, 1004, 262, 0, 0, 0, 0, 821.617, 624.168, 12.798, 3.1331, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537375
(9509043, 58569, 1004, 262, 0, 0, 0, 0, 821.815, 587, 12.799, 0.00172079, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537376
(9509044, 58569, 1004, 262, 0, 0, 0, 0, 821.96, 587, 12.7988, 3.14331, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537377
(9509045, 58555, 1004, 262, 0, 0, 0, 0, 856.842, 586.167, 10.0725, 1.309, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537380
(9509046, 58555, 1004, 262, 0, 0, 0, 0, 857.104, 625.578, 10.0725, 4.83456, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537381
(9509047, 58555, 1004, 262, 0, 0, 0, 0, 860.924, 585.925, 10.0847, 1.51844, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537382
(9509048, 58555, 1004, 262, 0, 0, 0, 0, 861.193, 625.564, 10.1153, 4.64258, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537384
(9509049, 58555, 1004, 262, 0, 0, 0, 0, 864.479, 585.708, 10.1909, 1.67552, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537386
(9509050, 58555, 1004, 262, 0, 0, 0, 0, 864.753, 625.543, 10.3476, 4.46804, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537387
(9509051, 58555, 1004, 262, 0, 0, 0, 0, 885.144, 629.264, 11.4214, 5.23876, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537389
(9509052, 58555, 1004, 262, 0, 0, 0, 0, 887.483, 630.033, 11.4214, 5.06145, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537390
(9509053, 58555, 1004, 262, 0, 0, 0, 0, 889.549, 631.096, 11.4214, 4.99164, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537391
(9509054, 64446, 1004, 262, 0, 0, 0, 0, 896.247, 649.752, 10.1267, 4.67879, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537392
(9509055, 64446, 1004, 262, 0, 0, 0, 0, 896.533, 562.222, 10.4783, 1.61134, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537393
(9509056, 58555, 1004, 262, 0, 0, 0, 0, 896.575, 563.625, 10.3773, 4.6653, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537394
(9509057, 58590, 1004, 262, 0, 0, 0, 0, 899.065, 661.252, 11.6379, 6.2763, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537395
(9509058, 64446, 1004, 262, 0, 0, 0, 0, 899.695, 649.561, 10.2136, 4.66105, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537396
(9509059, 64446, 1004, 262, 0, 0, 0, 0, 899.979, 562.031, 10.5535, 1.68466, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537397
(9509060, 58555, 1004, 262, 0, 0, 0, 0, 900.13, 563.568, 10.4881, 4.59271, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537398
(9509061, 64446, 1004, 262, 0, 0, 0, 0, 903.323, 649.547, 10.3021, 4.65209, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537399
(9509062, 64446, 1004, 262, 0, 0, 0, 0, 903.609, 562.017, 10.6337, 1.55086, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537400
(9509063, 58555, 1004, 262, 0, 0, 0, 0, 903.766, 563.464, 10.6115, 4.72278, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537401
(9509064, 58590, 1004, 262, 0, 0, 0, 0, 908.422, 661.187, 11.638, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537403
(9509065, 58590, 1004, 262, 0, 0, 0, 0, 908.817, 661.185, 11.638, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537404
(9509066, 58590, 1004, 262, 0, 0, 0, 0, 909.094, 661.183, 11.638, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537405
(9509067, 58590, 1004, 262, 0, 0, 0, 0, 910.136, 661.175, 11.6379, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537406
(9509068, 58590, 1004, 262, 0, 0, 0, 0, 911.119, 661.169, 11.6379, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537407
(9509069, 58590, 1004, 262, 0, 0, 0, 0, 912.164, 661.161, 11.6379, 3.1347, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537408
(9509070, 58590, 1004, 262, 0, 0, 0, 0, 913.106, 661.155, 11.6379, 6.2763, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537409
(9509071, 58555, 1004, 262, 0, 0, 0, 0, 915.127, 550.734, 11.7292, 6.17846, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537410
(9509072, 58555, 1004, 262, 0, 0, 0, 0, 915.259, 549.019, 11.7292, 6.26573, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537411
(9509073, 58605, 1004, 262, 0, 0, 0, 0, 916.778, 663.271, 11.7292, 5.28835, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537412
(9509074, 58590, 1004, 262, 0, 0, 0, 0, 916.981, 549.809, 11.7292, 3.15905, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537413
(9509075, 58569, 1004, 262, 0, 0, 0, 0, 918.507, 660.721, 11.7292, 2.05949, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537414
(9509076, 58590, 1004, 262, 0, 0, 0, 0, 937.141, 625.408, 1.26045, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537415
(9509077, 58605, 1004, 262, 0, 0, 0, 0, 938.951, 623.913, 1.26044, 1.51844, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537416
(9509078, 58605, 1004, 262, 0, 0, 0, 0, 938.971, 627.24, 1.26044, 4.71239, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537417
(9509079, 58569, 1004, 262, 0, 0, 0, 0, 942.922, 644.064, 1.16956, 3.1525, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537418
(9509080, 58590, 1004, 262, 0, 0, 0, 0, 946.043, 584.092, 0.767248, 6.16101, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537419
(9509081, 58569, 1004, 262, 0, 0, 0, 0, 946.292, 582.222, 0.758954, 6.14356, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537420
(9509082, 58605, 1004, 262, 0, 0, 0, 0, 948.767, 583.986, 0.767248, 3.07178, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537421
(9509083, 58569, 1004, 262, 0, 0, 0, 0, 948.852, 582.141, 0.775044, 3.19395, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537422
(9509084, 58569, 1004, 262, 0, 0, 0, 0, 949.666, 644.099, 1.16329, 6.28132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537423
(9509085, 58569, 1004, 262, 0, 0, 0, 0, 953.683, 644.091, 1.1548, 6.28132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537424
(9509086, 58590, 1004, 262, 0, 0, 0, 0, 960.784, 628.725, 0.75, 6.26059, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537425
(9509087, 58569, 1004, 262, 0, 0, 0, 0, 961.078, 644.077, 1.16088, 3.13973, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537426
(9509088, 64855, 1004, 262, 0, 0, 0, 0, 961.356, 605.495, 0.926281, 0.236222, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537427
(9509089, 58569, 1004, 262, 0, 0, 0, 0, 964.282, 585.416, 0.722222, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537428
(9509090, 58569, 1004, 262, 0, 0, 0, 0, 965.721, 644.069, 1.16868, 6.28131, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537429
(9509091, 58590, 1004, 262, 0, 0, 0, 0, 965.982, 628.583, 0.750022, 3.11659, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537430
(9509092, 58569, 1004, 262, 0, 0, 0, 0, 966.201, 644.068, 1.15573, 3.13973, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537431
(9509093, 58569, 1004, 262, 0, 0, 0, 0, 967.455, 565.856, 1.26046, 0.541052, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537432
(9509094, 58590, 1004, 262, 0, 0, 0, 0, 968.158, 645.373, 1.26046, 5.77704, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537433
(9509095, 58569, 1004, 262, 0, 0, 0, 0, 969.147, 567.306, 1.16229, 0.00391707, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537434
(9509096, 58555, 1004, 262, 0, 0, 0, 0, 969.965, 569.75, 1.26046, 4.45059, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537435
(9509097, 58590, 1004, 262, 0, 0, 0, 0, 970.245, 578.593, 0.722222, 1.92865, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537436
(9509098, 58555, 1004, 262, 0, 0, 0, 0, 970.347, 641.241, 1.26045, 1.22173, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537437
(9509099, 58555, 1004, 262, 0, 0, 0, 0, 971.314, 581.71, 0.722222, 3.93458, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537438
(9509100, 58590, 1004, 262, 0, 0, 0, 0, 972.396, 565.93, 1.26046, 2.72271, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537439
(9509101, 58590, 1004, 262, 0, 0, 0, 0, 972.554, 580.308, 0.722222, 2.7715, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537440
(9509102, 58569, 1004, 262, 0, 0, 0, 0, 973.09, 645.158, 1.26046, 3.59538, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537441
(9509103, 60197, 1004, 262, 0, 0, 0, 0, 982.682, 598.479, 0.767247, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537442
(9509104, 58605, 1004, 262, 0, 0, 0, 0, 984.533, 610.703, 0.767247, 3.01927, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537443
(9509105, 58605, 1004, 262, 0, 0, 0, 0, 984.682, 614.471, 0.767247, 4.3275, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537444
(9509106, 58569, 1004, 262, 0, 0, 0, 0, 985.422, 595.708, 0.767247, 1.96629, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537446
(9509107, 58569, 1004, 262, 0, 0, 0, 0, 985.792, 567.374, 1.1697, 3.14578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537447
(9509108, 58569, 1004, 262, 0, 0, 0, 0, 985.972, 598.29, 0.767247, 3.10982, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537449
(9509109, 58569, 1004, 262, 0, 0, 0, 0, 986.758, 567.378, 1.16971, 3.14578, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537450
(9509110, 58605, 1004, 262, 0, 0, 0, 0, 1000.01, 627.107, 0.802, 0.777, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537451
(9509111, 58569, 1004, 262, 0, 0, 0, 0, 990.045, 644.067, 1.16922, 6.28314, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537454
(9509112, 58590, 1004, 262, 0, 0, 0, 0, 993.022, 620.443, 0.756847, 4.70239, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537455
(9509113, 58555, 1004, 262, 0, 0, 0, 0, 993.274, 580.816, 1.11931, 5.42797, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537457
(9509114, 58569, 1004, 262, 0, 0, 0, 0, 993.42, 577.028, 1.18669, 1.01229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537458
(9509115, 58605, 1004, 262, 0, 0, 0, 0, 995.757, 631.502, 0.940972, 0.965425, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537459
(9509116, 58590, 1004, 262, 0, 0, 0, 0, 996.573, 579.055, 1.375, 2.96706, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537460
(9509117, 58569, 1004, 262, 0, 0, 0, 0, 999.17, 644.067, 1.16922, 6.28315, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537462
(9509118, 58569, 1004, 262, 0, 0, 0, 0, 1011.14, 567.48, 1.05897, 3.14578, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537464
(9509119, 58569, 1004, 262, 0, 0, 0, 0, 1011.23, 645.667, 1.26048, 5.49779, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537465
(9509120, 58569, 1004, 262, 0, 0, 0, 0, 1012.07, 568.484, 1.09695, 1.56229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537466
(9509121, 58569, 1004, 262, 0, 0, 0, 0, 1012.11, 572.494, 1.11941, 1.56229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537467
(9509122, 58569, 1004, 262, 0, 0, 0, 0, 1012.16, 573.107, 1.1489, 4.70879, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537469
(9509123, 58569, 1004, 262, 0, 0, 0, 0, 1013.55, 643.215, 1.26048, 2.21657, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537470
(9509124, 58555, 1004, 262, 0, 0, 0, 0, 1033.48, 600.023, 0.345, 5.42797, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537471
(9509125, 58569, 1004, 262, 0, 0, 0, 0, 1033.63, 596.234, 0.345, 1.01229, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537472
(9509126, 58590, 1004, 262, 0, 0, 0, 0, 1036.78, 598.262, 0.345, 2.96706, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537473
(9509127, 58605, 1004, 262, 0, 0, 0, 0, 1047.16, 651.163, 1.14178, 3.05529, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537474
(9509128, 58605, 1004, 262, 0, 0, 0, 0, 1050.3, 633.771, 1.12611, 4.59911, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537475
(9509129, 59705, 1004, 262, 0, 0, 0, 0, 1072.99, 590.325, 0.738073, 0.151743, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537476
(9509130, 59746, 1004, 262, 0, 0, 0, 0, 1073.3, 587.977, 0.738074, 0.547464, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537477
(9509131, 59746, 1004, 262, 0, 0, 0, 0, 1075.81, 585.938, 0.738076, 1.16736, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537480
(9509132, 59722, 1004, 262, 0, 0, 0, 0, 1078.28, 591.097, 0.738076, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537486
(9509133, 24034, 1004, 262, 0, 0, 0, 0, 1088.72, 612.849, 0.283721, 6.17846, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537519
(9509134, 23758, 1004, 262, 0, 0, 0, 0, 1088.78, 611.693, 1.23005, 0.0631916, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537522
(9509135, 23686, 1004, 262, 0, 0, 0, 0, 1100.37, 612.795, 1.47208, 0.10472, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537571
(9509136, 59705, 1004, 262, 0, 0, 0, 0, 1104.68, 543.13, 0.258744, 1.16466, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537579
(9509137, 59722, 1004, 262, 0, 0, 0, 0, 1106.12, 548.842, 0.384861, 4.77058, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537580
(9509138, 59746, 1004, 262, 0, 0, 0, 0, 1107.67, 543.415, 0.14069, 1.79442, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537581
(9509139, 59746, 1004, 262, 0, 0, 0, 0, 1108.31, 544.52, 0.140053, 3.45947, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537583
(9509140, 64838, 1004, 6, 0, 0, 0, 0, 1122.06, 522.675, 0.741729, 2.08758, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537615
(9509141, 59746, 1004, 262, 0, 0, 0, 0, 1124.26, 584.993, 1.09856, 5.40643, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 537620
(9509142, 59789, 1004, 262, 0, 0, 0, 0, 1124.71, 688.512, 1.31515, 4.7584, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537622
(9509143, 59722, 1004, 262, 0, 0, 0, 0, 1126.62, 580.759, 1.07461, 3.92811, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537630
(9509144, 59746, 1004, 262, 0, 0, 0, 0, 1127.22, 585.132, 1.09936, 4.6183, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537633
(9509145, 59705, 1004, 262, 0, 0, 0, 0, 1129.94, 584.248, 1.09435, 3.99617, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537645
(9509146, 59746, 1004, 262, 0, 0, 0, 0, 1133.99, 617.031, 0.832948, 5.13048, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537655
(9509147, 59746, 1004, 262, 0, 0, 0, 0, 1136.94, 619.205, 0.546219, 4.51803, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537657
(9509148, 59722, 1004, 262, 0, 0, 0, 0, 1137.13, 614.243, 0.435764, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537659
(9509149, 59746, 1004, 262, 0, 0, 0, 0, 1138.96, 555.852, 0.375716, 1.36545, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537663
(9509150, 59722, 1004, 262, 0, 0, 0, 0, 1139.75, 559.505, 0.513277, 4.50591, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537665
(9509151, 59705, 1004, 262, 0, 0, 0, 0, 1139.84, 618.726, 0.274205, 4.11252, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537666
(9509152, 59746, 1004, 262, 0, 0, 0, 0, 1141.37, 556.175, 0.264303, 2.04058, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537667
(9509153, 59746, 1004, 262, 0, 0, 0, 0, 1143.05, 552.743, 0.296064, 2.1084, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537668
(9509154, 59705, 1004, 262, 0, 0, 0, 0, 1145.69, 555.026, 0.181448, 2.41519, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537671
(9509155, 59705, 1004, 262, 0, 0, 0, 0, 1170.97, 548.672, 0.738079, 1.5693, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537760
(9509156, 59722, 1004, 262, 0, 0, 0, 0, 1171.43, 553.439, 0.738078, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537763
(9509157, 59746, 1004, 262, 0, 0, 0, 0, 1175.02, 549.88, 0.738074, 2.37525, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537771
(9509158, 59746, 1004, 262, 0, 0, 0, 0, 1175.37, 557.637, 0.738074, 3.85418, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 537772
(9509159, 53488, 1004, 4, 0, 0, 0, 0, 1124.64, 512.467, 0.989549, 3.24213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545096
(9509160, 59223, 1004, 262, 0, 0, 0, 0, 863.653, 614.346, 9.98951, 2.54334, 86400, 0, 0, 1050, 0, 2, 0, 0, 0), -- LoA 570472
(9509161, 60033, 1004, 262, 0, 0, 0, 0, 1160.49, 681.037, 0.906851, 3.77443, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570473
(9509162, 60033, 1004, 262, 0, 0, 0, 0, 1166.09, 672.127, 1.87779, 3.54667, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570474
(9509163, 60033, 1004, 262, 0, 0, 0, 0, 1158.56, 673.956, 1.5524, 0.925792, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570475
(9509164, 60033, 1004, 262, 0, 0, 0, 0, 1163.3, 665.478, 1.8233, 1.0813, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570476
(9509165, 60033, 1004, 262, 0, 0, 0, 0, 1150.98, 672.966, 0.913163, 0.658757, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570477
(9509166, 60033, 1004, 262, 0, 0, 0, 0, 1155.25, 680.678, 0.484799, 5.05384, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570478
(9509167, 60033, 1004, 262, 0, 0, 0, 0, 1085.73, 679.097, 0.53456, 5.49053, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570479
(9509168, 60033, 1004, 262, 0, 0, 0, 0, 1094.83, 682.143, 0.290076, 5.24548, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570480
(9509169, 60033, 1004, 262, 0, 0, 0, 0, 1093.13, 675.733, -0.932506, 5.22035, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570481
(9509170, 60033, 1004, 262, 0, 0, 0, 0, 1098.77, 672.709, 0.614811, 1.36797, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570482
(9509171, 60033, 1004, 262, 0, 0, 0, 0, 1089.12, 671.356, 0.113765, 5.05856, 7200, 5, 0, 84, 0, 1, 0, 0, 0), -- LoA 570483
(9509172, 60033, 1004, 262, 0, 0, 0, 0, 1101.43, 681.077, 0.611032, 5.58791, 7200, 5, 0, 84, 0, 1, 0, 0, 0); -- LoA 570484

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9509000 AND 9509045;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9509000, 210563, 1004, 262, 0, 0, 729.437, 605.803, 14.4716, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534377
(9509001, 210561, 1004, 262, 0, 0, 733.411, 659.081, 15.5449, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534378
(9509002, 210562, 1004, 262, 0, 0, 734.653, 657.445, 14.0488, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534379
(9509003, 210559, 1004, 262, 0, 0, 737.342, 582.124, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534380
(9509004, 210553, 1004, 262, 0, 0, 737.376, 631.782, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534381
(9509005, 210558, 1004, 262, 0, 0, 739.192, 582.124, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534382
(9509006, 210552, 1004, 262, 0, 0, 739.206, 631.782, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534383
(9509007, 210556, 1004, 262, 0, 0, 741.022, 578.736, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534384
(9509008, 210560, 1004, 262, 0, 0, 741.022, 582.124, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534385
(9509009, 210549, 1004, 262, 0, 0, 741.056, 629.302, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534386
(9509010, 210554, 1004, 262, 0, 0, 741.056, 631.782, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534387
(9509011, 210548, 1004, 262, 0, 0, 828.53, 598.786, 12.7716, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534388
(9509012, 210564, 1004, 262, 0, 0, 832.492, 605.568, 13.295, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534389
(9509013, 2042, 1004, 262, 0, 0, 905.642, 651.722, 10.4237, 5.43577, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534392
(9509014, 214290, 1004, 262, 0, 0, 959.929, 605.462, 0.842723, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534395
(9509015, 214289, 1004, 262, 0, 0, 960.885, 605.42, 0.843085, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534396
(9509016, 214287, 1004, 262, 0, 0, 960.964, 605.51, 2.32201, 6.25627, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534397
(9509017, 2042, 1004, 262, 0, 0, 1000.75, 631.625, 1.03545, 4.84032, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534400
(9509018, 211844, 1004, 262, 0, 0, 1057.69, 652.215, 2.7383, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534401
(9509019, 186314, 1004, 262, 0, 0, 1088.97, 611.826, 0.0735657, 5.0091, 0, 0, 0, 1, -86400, 255, 1), -- LoA 534402
(9509020, 186269, 1004, 262, 0, 0, 1089.08, 611.811, 0.213542, 0.0698117, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534403
(9509021, 186269, 1004, 262, 0, 0, 1098.07, 613.917, 0.0702424, 2.33874, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534404
(9509022, 186269, 1004, 262, 0, 0, 1098.17, 612.002, 0.167672, 3.4034, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534405
(9509023, 181191, 1004, 262, 0, 0, 1099.05, 614.523, 0.0557499, 2.75761, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534406
(9509024, 186328, 1004, 262, 0, 0, 1099.08, 610.93, 0.208333, 4.72984, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534407
(9509025, 186327, 1004, 262, 0, 0, 1099.66, 612.929, 0.119792, 4.62512, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534408
(9509026, 186269, 1004, 262, 0, 0, 1099.85, 610.743, 0.206597, 4.81711, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534411
(9509027, 186269, 1004, 262, 0, 0, 1100.04, 614.977, 0.0553949, 1.5708, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534412
(9509028, 181191, 1004, 262, 0, 0, 1100.05, 611.096, 0.1875, 1.43117, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534413
(9509029, 186328, 1004, 262, 0, 0, 1100.95, 611.675, 0.120834, 0.0174525, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534414
(9509030, 186328, 1004, 262, 0, 0, 1101.02, 613.87, 0.078125, 0.575957, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534415
(9509031, 181191, 1004, 262, 0, 0, 1101.36, 613.441, 0.0955281, 5.65487, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534416
(9509032, 186269, 1004, 262, 0, 0, 1101.71, 614.186, 0.056193, 0.331611, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534417
(9509033, 186269, 1004, 262, 0, 0, 1101.83, 612.068, 0.140625, 5.70723, 0, 0, 0, 1, 7200, 255, 0), -- LoA 534418
(9509034, 214508, 1004, 262, 0, 0, 1124.56, 504.333, 0.9892, 1.5614, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534419
(9509035, 214285, 1004, 262, 0, 0, 1124.73, 701.465, 5.9695, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534420
(9509036, 214286, 1004, 262, 0, 0, 1124.96, 701.509, 7.88455, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534421
(9509037, 214296, 1004, 262, 0, 0, 1126.24, 701.45, 7.69274, 5.50872, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534422
(9509038, 2044, 1004, 262, 0, 0, 1152.61, 713.517, 3.92056, 5.50818, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534423
(9509039, 210550, 1004, 262, 0, 0, 739.206, 629.302, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 542585
(9509040, 210551, 1004, 262, 0, 0, 737.376, 629.302, 14.5796, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 542586
(9509041, 210555, 1004, 262, 0, 0, 739.192, 578.736, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 542587
(9509042, 210557, 1004, 262, 0, 0, 737.342, 578.736, 14.5796, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 542588
(9509043, 214284, 1004, 262, 0, 0, 1126.24, 701.45, 7.69274, 5.50872, 0, 0, 0, 1, 7200, 255, 1), -- LoA 542750
(9509044, 211674, 1004, 256, 0, 0, 1124.51, 517.966, 0.65, 0.61747, 0, 0, 0.303853, 0.952719, 7200, 255, 1), -- LoA 546715
(9509045, 211989, 1004, 256, 0, 0, 1124.48, 519.556, 0.65, 1.53, 0, 0, 0.692536, 0.721383, 7200, 255, 1); -- LoA 546716

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 9509000 AND 9509172;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(9509127, 0, 0, 1, 0, 415, '128800'), -- LoA 537474
(9509128, 0, 0, 1, 0, 415, '128800'), -- LoA 537475
(9509160, 95091600, 0, 0, 0, 0, NULL); -- LoA 570472

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 95090000 AND 95091720 OR `id` BETWEEN 9509000 AND 9509172;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(95091600, 1, 859.095, 618.257, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 2, 860.502, 616.814, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 3, 860.381, 604.796, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 4, 860.219, 591.441, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 5, 858.689, 589.271, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 6, 853.95, 589.112, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 7, 857.992, 589.59, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 8, 861.102, 592.46, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 9, 860.661, 604.417, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 10, 860.645, 617.026, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 11, 858.22, 619.204, 9.98952, 0, 0, 0, 0, 100, 0),
(95091600, 12, 854.129, 619.089, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 1, 859.095, 618.257, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 2, 860.502, 616.814, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 3, 860.381, 604.796, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 4, 860.219, 591.441, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 5, 858.689, 589.271, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 6, 853.95, 589.112, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 7, 857.992, 589.59, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 8, 861.102, 592.46, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 9, 860.661, 604.417, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 10, 860.645, 617.026, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 11, 858.22, 619.204, 9.98952, 0, 0, 0, 0, 100, 0),
(9509160, 12, 854.129, 619.089, 9.98952, 0, 0, 0, 0, 100, 0);


-- Headless Horseman: spawned only during Hallow's End (game event 12), as in LoA (guid 537518)
DELETE FROM `creature` WHERE `guid` = 9509173;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9509173, 23682, 1004, 262, 0, 0, 0, 0, 1088.6, 611.917, -3.5879, 0.479457, 7200, 0, 0, 1, 0, 0, 0, 0, 0);
DELETE FROM `game_event_creature` WHERE `guid` = 9509173;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (12, 9509173);
