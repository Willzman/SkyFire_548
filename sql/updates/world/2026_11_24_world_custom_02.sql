-- World DB rows for the C++ scripts ported in this branch (B21): bindings, the texts they say and the paths they walk.
-- Taken from LoA's or pandaria's world DB where ours has none. Safe to run twice.

-- Bindings (only while the creature has no script and no SmartAI rows of its own)
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_archmage_landalock' WHERE `entry` = 20735 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33285 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33306 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33382 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33383 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33384 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33558 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33559 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33561 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33562 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_valiants' WHERE `entry` = 33564 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33738 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33739 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33740 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33743 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33744 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33745 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33746 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33747 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33748 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_ring_champions' WHERE `entry` = 33749 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_plagueborn_horror' WHERE `entry` = 36879 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_queldelar' WHERE `entry` = 37704 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_commander_eligor_dawnbringer' WHERE `entry` = 27784 AND `ScriptName` = '';

-- Texts for 33285 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33285,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33285,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33285,0,2,'On your guard!',12,1,100,0,0,0,'Argent Valiant'),
(33285,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Valiant'),
(33285,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Valiant'),
(33285,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Valiant'),
(33285,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Valiant'),
(33285,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Valiant'),
(33285,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33285,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33285,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Valiant'),
(33285,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Valiant');
-- Texts for 33306 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33306,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33306,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33306,0,2,'On your guard!',12,1,100,0,0,0,'Argent Valiant'),
(33306,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Valiant'),
(33306,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Valiant'),
(33306,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Valiant'),
(33306,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Valiant'),
(33306,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Valiant'),
(33306,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33306,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33306,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Valiant'),
(33306,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Valiant');
-- Texts for 33382 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33382,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33382,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33382,0,2,'On your guard!',12,1,100,0,0,0,'Argent Valiant'),
(33382,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Valiant'),
(33382,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Valiant'),
(33382,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Valiant'),
(33382,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Valiant'),
(33382,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Valiant'),
(33382,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33382,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33382,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Valiant'),
(33382,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Valiant');
-- Texts for 33383 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33383,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33383,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33383,0,2,'On your guard!',12,1,100,0,0,0,'Argent Valiant'),
(33383,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Valiant'),
(33383,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Valiant'),
(33383,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Valiant'),
(33383,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Valiant'),
(33383,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Valiant'),
(33383,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33383,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33383,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Valiant'),
(33383,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Valiant');
-- Texts for 33384 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33384,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33384,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Valiant'),
(33384,0,2,'On your guard!',12,1,100,0,0,0,'Argent Valiant'),
(33384,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Valiant'),
(33384,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Valiant'),
(33384,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Valiant'),
(33384,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Valiant'),
(33384,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Valiant'),
(33384,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33384,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Valiant'),
(33384,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Valiant'),
(33384,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Valiant');
-- Texts for 33558 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33558,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33558,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33558,0,2,'On your guard!',12,7,100,0,0,0,'Argent Valiant'),
(33558,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Valiant'),
(33558,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Valiant'),
(33558,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Valiant'),
(33558,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Valiant'),
(33558,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Valiant'),
(33558,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33558,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33558,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Valiant'),
(33558,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Valiant');
-- Texts for 33559 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33559,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33559,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33559,0,2,'On your guard!',12,7,100,0,0,0,'Argent Valiant'),
(33559,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Valiant'),
(33559,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Valiant'),
(33559,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Valiant'),
(33559,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Valiant'),
(33559,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Valiant'),
(33559,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33559,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33559,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Valiant'),
(33559,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Valiant');
-- Texts for 33561 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33561,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33561,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33561,0,2,'On your guard!',12,7,100,0,0,0,'Argent Valiant'),
(33561,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Valiant'),
(33561,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Valiant'),
(33561,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Valiant'),
(33561,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Valiant'),
(33561,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Valiant'),
(33561,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33561,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33561,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Valiant'),
(33561,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Valiant');
-- Texts for 33562 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33562,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33562,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33562,0,2,'On your guard!',12,7,100,0,0,0,'Argent Valiant'),
(33562,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Valiant'),
(33562,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Valiant'),
(33562,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Valiant'),
(33562,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Valiant'),
(33562,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Valiant'),
(33562,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33562,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33562,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Valiant'),
(33562,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Valiant');
-- Texts for 33564 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33564,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33564,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Valiant'),
(33564,0,2,'On your guard!',12,7,100,0,0,0,'Argent Valiant'),
(33564,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Valiant'),
(33564,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Valiant'),
(33564,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Valiant'),
(33564,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Valiant'),
(33564,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Valiant'),
(33564,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33564,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Valiant'),
(33564,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Valiant'),
(33564,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Valiant');
-- Texts for 33738 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33738,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Champion'),
(33738,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Champion'),
(33738,0,2,'On your guard!',12,7,100,0,0,0,'Argent Champion'),
(33738,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Champion'),
(33738,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Champion'),
(33738,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Champion'),
(33738,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Champion'),
(33738,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Champion'),
(33738,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33738,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33738,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Champion'),
(33738,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Champion');
-- Texts for 33739 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33739,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Champion'),
(33739,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Champion'),
(33739,0,2,'On your guard!',12,7,100,0,0,0,'Argent Champion'),
(33739,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Champion'),
(33739,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Champion'),
(33739,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Champion'),
(33739,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Champion'),
(33739,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Champion'),
(33739,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33739,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33739,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Champion'),
(33739,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Champion');
-- Texts for 33740 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33740,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Champion'),
(33740,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Champion'),
(33740,0,2,'On your guard!',12,7,100,0,0,0,'Argent Champion'),
(33740,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Champion'),
(33740,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Champion'),
(33740,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Champion'),
(33740,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Champion'),
(33740,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Champion'),
(33740,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33740,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33740,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Champion'),
(33740,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Champion');
-- Texts for 33743 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33743,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Champion'),
(33743,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Champion'),
(33743,0,2,'On your guard!',12,7,100,0,0,0,'Argent Champion'),
(33743,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Champion'),
(33743,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Champion'),
(33743,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Champion'),
(33743,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Champion'),
(33743,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Champion'),
(33743,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33743,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33743,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Champion'),
(33743,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Champion');
-- Texts for 33744 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33744,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Champion'),
(33744,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Champion'),
(33744,0,2,'On your guard!',12,1,100,0,0,0,'Argent Champion'),
(33744,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Champion'),
(33744,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Champion'),
(33744,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Champion'),
(33744,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Champion'),
(33744,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Champion'),
(33744,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33744,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33744,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Champion'),
(33744,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Champion');
-- Texts for 33745 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33745,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Champion'),
(33745,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Champion'),
(33745,0,2,'On your guard!',12,1,100,0,0,0,'Argent Champion'),
(33745,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Champion'),
(33745,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Champion'),
(33745,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Champion'),
(33745,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Champion'),
(33745,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Champion'),
(33745,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33745,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33745,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Champion'),
(33745,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Champion');
-- Texts for 33746 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33746,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Champion'),
(33746,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Champion'),
(33746,0,2,'On your guard!',12,1,100,0,0,0,'Argent Champion'),
(33746,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Champion'),
(33746,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Champion'),
(33746,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Champion'),
(33746,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Champion'),
(33746,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Champion'),
(33746,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33746,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33746,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Champion'),
(33746,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Champion');
-- Texts for 33747 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33747,0,0,'Ready yourself!',12,7,100,0,0,0,'Argent Champion'),
(33747,0,1,'Prepare yourself!',12,7,100,0,0,0,'Argent Champion'),
(33747,0,2,'On your guard!',12,7,100,0,0,0,'Argent Champion'),
(33747,0,3,'Let it begin!',12,7,100,0,0,0,'Argent Champion'),
(33747,1,0,'Victory is mine!',12,7,100,0,0,0,'Argent Champion'),
(33747,1,1,'It seems you still need more practice. Perhaps another time.',12,7,100,0,0,0,'Argent Champion'),
(33747,1,2,'I have won. Better luck another time, friend.',12,7,100,0,0,0,'Argent Champion'),
(33747,1,3,'I am afraid you will need more practice to defeat me.',12,7,100,0,0,0,'Argent Champion'),
(33747,2,0,'I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33747,2,1,'That was a well fought battle. I yield to you.',12,7,100,0,0,0,'Argent Champion'),
(33747,2,2,'It would seem I underestimated your skills. Well done.',12,7,100,0,0,0,'Argent Champion'),
(33747,2,3,'I have been defeated. Good fight!',12,7,100,0,0,0,'Argent Champion');
-- Texts for 33748 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33748,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Champion'),
(33748,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Champion'),
(33748,0,2,'On your guard!',12,1,100,0,0,0,'Argent Champion'),
(33748,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Champion'),
(33748,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Champion'),
(33748,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Champion'),
(33748,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Champion'),
(33748,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Champion'),
(33748,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33748,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33748,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Champion'),
(33748,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Champion');
-- Texts for 33749 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(33749,0,0,'Ready yourself!',12,1,100,0,0,0,'Argent Champion'),
(33749,0,1,'Prepare yourself!',12,1,100,0,0,0,'Argent Champion'),
(33749,0,2,'On your guard!',12,1,100,0,0,0,'Argent Champion'),
(33749,0,3,'Let it begin!',12,1,100,0,0,0,'Argent Champion'),
(33749,1,0,'Victory is mine!',12,1,100,0,0,0,'Argent Champion'),
(33749,1,1,'It seems you still need more practice. Perhaps another time.',12,1,100,0,0,0,'Argent Champion'),
(33749,1,2,'I have won. Better luck another time, friend.',12,1,100,0,0,0,'Argent Champion'),
(33749,1,3,'I am afraid you will need more practice to defeat me.',12,1,100,0,0,0,'Argent Champion'),
(33749,2,0,'I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33749,2,1,'That was a well fought battle. I yield to you.',12,1,100,0,0,0,'Argent Champion'),
(33749,2,2,'It would seem I underestimated your skills. Well done.',12,1,100,0,0,0,'Argent Champion'),
(33749,2,3,'I have been defeated. Good fight!',12,1,100,0,0,0,'Argent Champion');
-- Texts for 37704 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(37704,0,0,'Quel\'Delar leaps to life in the presence of Frostmourne!',41,0,100,0,0,0,'Frostmourne Altar Bunny (Quel\'Delar)');
-- Texts for 27784 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27784,0,0,'Next, I shall speak of the most powerful entities within the pinnacle of Naxxramas. Truly, these are two of the greatest threats to all of Northrend.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - Pinnacle of Naxxramas'),
(27784,1,0,'Next, I shall speak of the death knight wing of Naxxramas. Within its corrupted halls, the echo of battle rings day and night, as our finest warriors are corrupted and twisted into the Scourge\'s greatest warriors.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - Death knight wing of Naxxramas'),
(27784,2,0,'Next, I shall speak of the blighted abomination wing of Naxxramas. There, the Scourge develop the strongest and most hideous aberrations of their armies.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - Blighted abomination wing of Naxxramas'),
(27784,3,0,'Next, I shall speak of the accursed spider wing of Naxxramas. It is there the Scourge breed even more poisonous and dangerous versions of their kin.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - Accursed spider wing of Naxxramas'),
(27784,4,0,'Next, I shall speak of the dread plague wing of Naxxramas, where the Scourge seek to improve upon the deadly blight which they spread across Lordaeron.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - Dread plague wing of Naxxramas'),
(27784,5,0,'I shall leave this image on display for your perusal. Study your opponents\' strengths, for a creature\'s strength can also be its weakness.',12,7,100,0,0,0,'Commander Eligor Dawnbringer - End of talk'),
(27784,6,0,'Sapphiron. Once a noble blue dragon within the mountains of Northrend, Sapphiron was slain by Arthas during his campaign through the frozen north. Resurrected to serve him, Sapphiron guards Kel\'thuzad\'s lair eternally, awaiting those who would dare tresspass upon his master.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,7,0,'The lich, Kel\'Thuzad. He serves the Lich King without question, a necromancer of great prowess in life, turned into a master of necromancy after his death. It is said he is the most loyal of the Lich King\'s subjects.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,8,0,'Kel\'thuzad has survived trials that would have long since shattered the souls of even the greatest of the Brotherhood. He readily gave his life at Arthas\'s hand, later to be brought back - reborn in the power of the Sunwell. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,9,0,'In the Plaguelands, Kel\'thuzad was again defeated by the agents of the Argent Dawn. However, his phylactery was delivered to a false agent of the Brotherhood. We have yet to discover who stole his phylactery or why. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,10,0,'Pay attention. This is Instructor Razuvious, Kel\'Thuzad\'s appointed trainer of all death knights. It is said that his own technique is so potent, only a disciple of his could possibly withstand his might.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,11,0,'Gothik, the Harvester. A master of necromancy and conjuration, Gothik is said to be able to beckon forth legions of the undead at a moment\'s notice. It is with his guidance that even the weakest of Death Knights can raise the dead.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,12,0,'The most powerful death knights within Naxxramas are the four horsemen. They represent the pinnacle of Kel\'Thuzad\'s guard. The first, Thane Korth\'azz, holds the power of flame. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,13,0,'The next, Lady Blaumeux, calls forth the power of shadows, drawing the souls of the living into the voracious embrace.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,14,0,'Sir Zeliek, a paladin in life, so strong in his faith, that even in undeath, the power of the light still heeds his call, smiting his foes in battle.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,15,0,'The final death knight, Lord Mograine, was the finest warrior that the death knights had ever seen. However, after the events in Azeroth, he vanished without a trace. It is yet to be seen who Kel\'Thuzad has appointed in his place.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,16,0,'Behold, Patchwerk. When word of his existence first reached the ears of the Brotherhood, none believed the tales of an abomination with such immense speed and strength. Fewer still believed it when he fell the first time...',12,0,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,17,0,'Grobbulus, the first of what was to be an army of flesh giants. It carried the plague slime of Naxxramas within its body, injecting the living ooze into the bodies of its foe. The recipient of this foul injection would usually flee to his allies, bringing them down with him.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,18,0,'Gluth, the foul plague-dog of Naxxramas, was said to have an appetite so voracious that even the living were not enough to satisfy his hunger. Feugen was said to feed him an army of zombies daily, recycling the remains of undead too weak to use in combat.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,19,0,'Thaddius, built from the flesh of women and children, it is said that their souls are fused together - eternally bound within that foul prison of flesh. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,20,0,'Anub\'Rekhan, one of the finest Spider Lords of Azjol\'Nerub, was brought under the control of the Scourge when he and his former commander, Anub\'arak, were finally defeated by Lich King many years ago. It is said that he was the most loyal of Anub\'arak\'s commanders.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,21,0,'The Grand Widow Faerlina, a botanist in life, breeder and caretaker of arachnids in death, she overseers the spider wing, developing the most potent of poisons for the Lich King. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,22,0,'Maexxna, born deep within the mountains of Northrend many ages ago, she was captured within the dread citadel Naxxramas, where she gives birth to her brood, feeding them the corpses of all who dare venture too deeply into Naxxramas.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,23,0,'Behold, Noth the Plaguebringer. Responsible for the creation of the process that distills the souls of the living and places them within the cold cage of undeath, Noth was observed to be refining this process even now. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,24,0,'Observe, Heigan the Unclean. The mastermind behind the plague cauldrons that turned the wilderness of Azeroth into the Plaguelands. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,25,0,'It is said that Heigan has rigged the very walls and floors of Naxxramas itself with a vast array of traps, which he can trigger at will.',12,7,100,0,0,0,'Commander Eligor Dawnbringer'),
(27784,26,0,'Loatheb. The hideous result of fusing the living plague of the Plaguelands with the bog beasts of Azeroth, Loatheb is said to control the power of healing itself. ',12,7,100,0,0,0,'Commander Eligor Dawnbringer');
