-- Small fixes found while checking what still needs paths or scripts (B20). Safe to run twice.

-- 1. C++ scripts that exist in the core but were bound to nothing ("does not have a script name assigned" at startup).
--    Only spells with no script at all are bound; ids as pandaria binds them (Halion: as TrinityCore 3.3.5, pandaria uses a custom id).
--    Left alone on purpose: scripts whose creature or spell already runs another script or SmartAI (pandriarchs,
--    Despondent Warden of Zhu, Greenstone Terror, Durumu, Primordius, waterspout, Heart of Fear poison), spell_timeless_isle_crane_wings
--    (unbound on purpose in 2026_11_21_world_custom_03), npc_flee_from_player, cond_hookshot (no condition row here).
DELETE FROM `spell_script_names` WHERE (`spell_id`, `ScriptName`) IN (
 (85578,'spell_chilling_winds'),(85573,'spell_deafening_winds'),(85576,'spell_withering_winds'),
 (107796,'spell_dragon_soul_ancient_water_lord_flood'),(107596,'spell_dragon_soul_earthen_destroyer_boulder_smash'),
 (52408,'spell_gen_seaforium_blast'),(74805,'spell_halion_summon_exit_portals'),
 (81665,'spell_summon_dominion_stalker_n'),(81745,'spell_summon_dominion_stalker_e'),(81746,'spell_summon_dominion_stalker_s'),(81747,'spell_summon_dominion_stalker_w'));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
 (85578,'spell_chilling_winds'),(85573,'spell_deafening_winds'),(85576,'spell_withering_winds'),
 (107796,'spell_dragon_soul_ancient_water_lord_flood'),(107596,'spell_dragon_soul_earthen_destroyer_boulder_smash'),
 (52408,'spell_gen_seaforium_blast'),(74805,'spell_halion_summon_exit_portals'),
 (81665,'spell_summon_dominion_stalker_n'),(81745,'spell_summon_dominion_stalker_e'),(81746,'spell_summon_dominion_stalker_s'),(81747,'spell_summon_dominion_stalker_w');

-- Gilnean Mastiff Collar (48707, quest From the Shadows 14204): the item script was added in Aug 2026 but never bound.
DELETE FROM `item_script_names` WHERE `Id` = 48707;
INSERT INTO `item_script_names` (`Id`, `ScriptName`) VALUES (48707, 'item_gilnean_mastiff_collar');

-- 2. Spawns that have a waypoint path (2+ points) in creature_addon but do not walk it, while pandaria's spawn at the
--    same spot walks a path: Karazhan guests and servants, Zul'Aman jaguars and spiders, Doomwalker, Hyjal druids,
--    Darkmoon Faire parade, Shadowmoon Valley drakonid and eye. 39 spawns.
UPDATE `creature` SET `MovementType` = 2, `spawndist` = 0 WHERE `MovementType` <> 2 AND (`guid`, `id`) IN (
 (8878,54595),(9065,55254),(9089,54643),(9150,55261),(31772,18982),(37642,18982),(37669,18983),(37671,18982),(37676,18983),
 (37677,18982),(37682,18982),(37691,18983),(37692,18982),(37694,18983),(37695,18983),(37698,18982),(37699,18983),(37700,18982),
 (52070,3795),(52074,3794),(57656,16666),(58702,16924),(77361,22072),(77730,22134),(84633,17711),(135170,16408),(135227,16409),
 (135228,16409),(135241,16409),(135253,16409),(135263,16409),(135265,16409),(135306,16414),(135338,14881),(135364,16425),
 (135517,16461),(135530,16468),(135712,16526),(135775,16544));

-- 3. Spawns set to walk a path that does not exist (Graceful Swan, Crypt Guardian, Alani, Finkle Einhorn): stand instead,
--    which is what they do now, without the load error.
UPDATE `creature` SET `MovementType` = 0 WHERE `MovementType` = 2 AND (`guid`, `id`) IN ((9583179,61350),(9587009,61418),(9627249,64403),(9656188,49476));

-- Akama (Black Temple) points at path 847160, which has no points.
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` = 84716 AND `path_id` = 847160;

-- 4. Path points that call waypoint scripts that do not exist.
UPDATE `waypoint_data` SET `action` = 0 WHERE `action` IN (212,213,380,381,382,383,384,441,442,444,445,448,450,467,468,469,492,668,669,670,671)
 AND `action` NOT IN (SELECT `id` FROM `waypoint_scripts`);
