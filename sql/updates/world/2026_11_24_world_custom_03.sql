-- World DB rows for the C++ scripts ported in this branch (B21): bindings, the texts they say and the paths they walk.
-- Taken from LoA's or pandaria's world DB where ours has none. Safe to run twice.

-- Bindings (only while the creature has no script and no SmartAI rows of its own)
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_anachronos_15192' WHERE `entry` = 15192 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_steam_powered_auctioneer' WHERE `entry` = 35594 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_steam_powered_auctioneer' WHERE `entry` = 35607 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_visual_sparring' WHERE `entry` = 37070 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_visual_sparring' WHERE `entry` = 37177 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_visual_sparring' WHERE `entry` = 45847 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_vision_of_the_naaru_stalker' WHERE `entry` = 51200 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_soul_mirror_artifact' WHERE `entry` = 51337 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_blue_dragon_53394' WHERE `entry` = 53394 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tarecgosa_53396' WHERE `entry` = 53396 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_abominated_greench' WHERE `entry` = 54499 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_shu_water_spirit' WHERE `entry` = 55212 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_mostrasz_56314' WHERE `entry` = 56314 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'mob_aisa_pre_balon_event' WHERE `entry` = 56662 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_master_shang_xi_thousand_staff_escort' WHERE `entry` = 56688 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_trainee_nim' WHERE `entry` = 60183 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_steam_powered_auctioneer' WHERE `entry` = 65599 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_steam_powered_auctioneer' WHERE `entry` = 67130 AND `ScriptName` = '';

-- Texts for 45847 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(45847,0,0,'You\'re doing well... you\'re going to be fine.',12,0,100,1,0,0,'S.A.F.E. Operative'),
(45847,1,0,'Our men have secured the walkway. Focus on helping those in the main room.',12,0,100,1,0,0,'S.A.F.E. Operative');
-- Texts for 56662 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(56662,0,0,'We\'re ready to go whenever you are, $n.',12,0,100,1,0,27428,'Aysa Cloudsinger'),
(56662,1,0,'Hop in.',12,0,100,1,0,27429,'Aysa Cloudsinger'),
(56662,2,0,'Don\'t listen to him.  We\'ve got work to do.',12,0,100,1,0,27430,'Aysa Cloudsinger');
