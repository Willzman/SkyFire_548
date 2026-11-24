-- World DB rows for the C++ scripts ported in this branch (B21): bindings, the texts they say and the paths they walk.
-- Taken from LoA's or pandaria's world DB where ours has none. Safe to run twice.

-- Bindings (only while the creature has no script and no SmartAI rows of its own)
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_old_ironbark' WHERE `entry` = 11491 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_bunthen_plainswind' WHERE `entry` = 11798 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_chromie' WHERE `entry` = 26527 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_skorn_whitecloud' WHERE `entry` = 3052 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_sister_goldskimmer' WHERE `entry` = 34692 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_baine_bloodhoof' WHERE `entry` = 36648 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_watershed_patrol' WHERE `entry` = 39325 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_garrosh_hellscream_warchief' WHERE `entry` = 39605 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_azshara_awol_grunt' WHERE `entry` = 42646 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_quest_impending_retribution' WHERE `entry` = 46603 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_prince_nadun' WHERE `entry` = 46872 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_quest_impending_retribution' WHERE `entry` = 47715 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_quest_impending_retribution' WHERE `entry` = 47930 AND `ScriptName` = '';

-- Texts for 26527 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26527,0,0,'Oh, no! Adventurers, something awful has happened! A colleague of mine has been captured by the Infinite Dragonflight, and they\'re doing something horrible to him! Keeping Arthas is still your highest priority, but if you act fast you could help save a Guardian of Time!',15,0,100,0,0,0,'Chromie'),
(26527,1,0,'Adventurers, you must hurry! The Guardian of Time cannot last for much longer!',15,0,100,0,0,0,'Chromie'),
(26527,2,0,'I can barely sense the Guardian of Time! His timeline is fading quickly!',15,0,100,0,0,0,'Chromie');
-- Texts for 34692 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(34692,0,0,'It\'s not much, but it just might keep your green skin intact.',12,0,50,1,0,0,'say Text'),
(34692,0,1,'Just wanted to let you know that we\'re all counting on you!',12,0,50,1,0,0,'say Text'),
(34692,0,2,'Light be with you... for the very low price of a one silver tithe!',12,0,50,1,0,0,'say Text'),
(34692,0,3,'I was wondering when I\'d see you again, $n.',12,0,100,0,0,0,''),
(34692,0,4,'It\'s not much, but it just might keep your green skin intact.',12,0,100,0,0,0,''),
(34692,0,5,'Hope you don\'t mind the extra fortitude, boss-$g man : lady;.',12,0,100,0,0,0,''),
(34692,0,6,'Just wanted to let you know that we\'re all counting on you!',12,0,100,0,0,0,''),
(34692,0,7,'Light be with you... for the very low price of a one silver tithe!',12,0,100,0,0,0,'');
-- Texts for 36648 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36648,0,0,'The attackers shall not succeed!  Strength and honor to the Horde!',14,0,100,0,0,0,''),
(36648,1,0,'The attackers have fled!  Strength and honor to the Horde!',14,0,100,0,0,0,'');
-- Texts for 42646 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(42646,0,0,'$gRight away, sir:Right away ma\'am;!',12,0,100,2,0,0,'AWOL Grunt to Player'),
(42646,1,0,'Please don\'t tell the Warlord...',12,0,100,2,0,0,'AWOL Grunt to Player'),
(42646,2,0,'$gSir, yes sir:Ma\'am, yes ma\'am;!',12,0,100,2,0,0,'AWOL Grunt to Player'),
(42646,2,1,'I\'m sorry, $gsir:ma\'am;!',12,0,100,0,0,0,''),
(42646,3,0,'It won\'t happen again, $gsir:ma\'am;.',12,0,100,16,0,0,'AWOL Grunt to Player');
