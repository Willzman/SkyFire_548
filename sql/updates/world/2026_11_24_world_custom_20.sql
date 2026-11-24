-- S6, pre-MoP part: quest starters / enders from TrinityCore Cata Classic (TDB_full_world_442.26081, GPL v2) for quests that
-- have no starter or no ender here. Only rows that leave the quest with both ends, with a giver that is spawned here and has
-- the same name in TC, for a quest with the same title; quests the AzerothCore triage marks as removed in Cataclysm and the
-- two warlock Summon Felsteed quests (4487, 4488; trainer-learned since Cataclysm) are left out. Safe to run twice.

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`) VALUES
(16252, 9177),
(22112, 10871),
(14829, 29508);
-- 16252 9177: High Executor Mavren - Journey to Undercity; 22112 10871: Karynaku - Ally of the Netherwing; 14829 29508: Yebb Neblegear - Baby Needs Two Pair of Shoes
INSERT IGNORE INTO `creature_questender` (`id`, `quest`) VALUES
(17684, 9695),
(22113, 10871),
(41402, 25707),
(48241, 28228),
(13433, 29382),
(13435, 29382),
(23010, 29382),
(13418, 29383),
(13429, 29383),
(13431, 29383),
(23011, 29383),
(34996, 29851);
-- 17684 9695: Vindicator Boros - The Sun King's Command; 22113 10871: Mordenai - Ally of the Netherwing; 41402 25707: Abandoned Bloodwash Crate - The Future of the Rockpool; 48241 28228: Flourishing Protector - Rejoining the Forest; 13433 29382: Wulmort Jinglepocket - Thanks, But No Thanks; 13435 29382: Khole Jinglepocket - Thanks, But No Thanks; 23010 29382: Wolgren Jinglepocket - Thanks, But No Thanks; 13418 29383: Kaymard Copperpinch - Thanks, But No Thanks; 13429 29383: Nardstrum Copperpinch - Thanks, But No Thanks; 13431 29383: Whulwert Copperpinch - Thanks, But No Thanks; 23011 29383: Morshelz Copperpinch - Thanks, But No Thanks; 34996 29851: Highlord Tirion Fordring - Champion of the Tournament

-- Enders that had no quest-giver flag
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE `entry` IN (23011, 34996, 48241);
