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
