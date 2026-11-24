-- World DB rows for the C++ scripts ported in this branch (B21): bindings, the texts they say and the paths they walk.
-- Taken from LoA's or pandaria's world DB where ours has none. Safe to run twice.

-- Bindings (only while the creature has no script and no SmartAI rows of its own)
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_aradne' WHERE `entry` = 50372 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_deathknell_grave_target' WHERE `entry` = 50373 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_mindless_zombie' WHERE `entry` = 1501 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_risen_dead' WHERE `entry` = 50374 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_sedrick_calston' WHERE `entry` = 38925 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_undertaker_mordo' WHERE `entry` = 1568 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_vile_fin_minor_oracle' WHERE `entry` = 1544 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_vile_fin_puddlejumper' WHERE `entry` = 1543 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_koroth_the_hillbreaker' WHERE `entry` = 36294 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_duskhaven_watchman' WHERE `entry` = 36211 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_forsaken_catapult' WHERE `entry` = 36283 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_forsaken_invader' WHERE `entry` = 34511 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_fenwick_thatros' WHERE `entry` = 47008 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_varian_wrynn_alliance_way_quest' WHERE `entry` = 61796 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_brother_paxton' WHERE `entry` = 951 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_stranglethorn_priestess_hurala' WHERE `entry` = 42812 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_stranglethorn_priestess_hurala' WHERE `entry` = 44017 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_burning_steppes_chiseled_golem' WHERE `entry` = 48037 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_scourge_siege_engineer' WHERE `entry` = 17878 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_dark_master_gandling_quest' WHERE `entry` = 44323 AND `ScriptName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_thassarian_quest' WHERE `entry` = 44453 AND `ScriptName` = '';

-- Texts for 50372 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(50372,0,0,'Rise from the grave and serve the Dark Lady!',12,0,100,1,0,0,'Aradne'),
(50372,0,1,'In the name of Sylvanas, the Banshee Queen, I bestow this gift upon you!',12,0,100,1,0,0,'Aradne'),
(50372,0,2,'Rise from death\'s slumber and join your brothers!',12,0,100,1,0,0,'Aradne'),
(50372,0,3,'Waken, sleeper. Your new life awaits.',12,0,100,1,0,0,'Aradne'),
(50372,0,4,'You are returned to life. The Banshee Queen asks for your service.',12,0,100,1,0,0,'Aradne');
-- Texts for 50374 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(50374,0,0,'I never asked for this! Leave me alone!',12,0,100,5,0,0,'Risen Dead'),
(50374,1,0,'What magic is this that turn back the hand of death?',12,0,100,6,0,0,'Risen Dead'),
(50374,1,1,'This is Lady Sylvanas\'s doing?',12,0,100,6,0,0,'Risen Dead'),
(50374,2,0,'If the Banshee Queen has offered me this chance, I will gladly serve.',12,0,100,1,0,0,'Risen Dead'),
(50374,2,1,'What use has the Dark Lady for me?',12,0,100,6,0,0,'Risen Dead'),
(50374,3,0,'What... what\'s happening to me? Why have you done this to me?',12,0,100,6,0,0,'Risen Dead'),
(50374,3,1,'I... I don\'t remember... Why have you done this?',12,0,100,6,0,0,'Risen Dead'),
(50374,4,0,'I should be dead and to death I will return!',12,0,100,5,0,0,'Risen Dead'),
(50374,5,0,'%s enrages and transforms into a Mindless Zombie and runs away.',16,0,100,0,0,0,'Risen Dead'),
(50374,6,0,'%s commits suicide.',16,0,100,0,0,0,'Risen Dead'),
(50374,7,0,'%s walks off towards the barracks.',16,0,100,0,0,0,'Risen Dead'),
(50374,8,0,'%s commits suicide.',16,0,100,0,0,0,'Risen Dead'),
(50374,9,0,'%s enrages and transforms into a Mindless Zombie and runs away.',16,0,100,0,0,0,'Risen Dead'),
(50374,10,0,'%s walks off towards the barracks.',16,0,100,0,0,0,'Risen Dead');
-- Texts for 1568 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(1568,0,0,'Let\'s see, I just saw a corpse with a jaw that would fit you',12,0,100,0,0,0,'Mordo'),
(1568,1,0,'That should do the job. Come back right away if it falls off again.',12,0,100,0,0,0,'Mordo');
-- Texts for 1544 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(1544,0,0,'The %s is ready to be captured!',16,0,100,0,0,0,'Vile Fin Minor Oracle');
-- Texts for 1543 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(1543,0,0,'The %s is ready to be captured!',16,0,100,0,0,0,'Vile Fin Puddlejumper');
-- Texts for 36294 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(36294,0,0,'Who dares to touch Koroth\'s banner!?',14,0,100,0,0,0,'Koroth the Hillbreaker to Player'),
(36294,1,0,'You puny thief!  Koroth find you!  Koroth smash your face in!',14,0,100,0,0,0,'Koroth the Hillbreaker to Player');
-- Texts for 47008 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(47008,0,0,'All I wanted was a little peace and quiet!',12,0,100,0,0,0,'');
-- Texts for 61796 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(61796,0,0,'Walk with me. All three of you.',12,0,100,1,0,29574,''),
(61796,1,0,'I understand you want to join the Alliance.',12,0,100,0,0,29575,''),
(61796,2,0,'We always have need of allies. I\'d be a fool to turn you away, especially at a time of war.',12,0,100,1,0,29576,''),
(61796,3,0,'But there are a number of things I need to make clear to you.',12,0,100,0,0,29577,''),
(61796,4,0,'First: the races of the Alliance look out for one another.',12,0,100,0,0,29578,''),
(61796,5,0,'You are expected to provide aid to Alliance members in need, whether they be human, gnome, draenei... or pandaren like yourselves.',12,0,100,1,0,29579,''),
(61796,6,0,'It is a simple guideline, but a meaningful one. Do you understand?',12,0,100,0,0,29580,''),
(61796,7,0,'Good. Because that brings me to my second point.',12,0,100,273,0,29581,''),
(61796,8,0,'Not all pandaren have chosen the same path as you three.',12,0,100,0,0,29582,''),
(61796,9,0,'Some have sided with the Horde.',12,0,100,0,0,29583,''),
(61796,10,0,'They, along with the other barbarian clans of the Horde, are your new enemies.',12,0,100,1,0,29584,''),
(61796,11,0,'Those who you once considered friends, or even those you might have loved, are now your sworn adversaries.',12,0,100,274,0,29585,''),
(61796,12,0,'I am deeply sorry, but the battle lines have been drawn. I will not tolerate any fraternizing with the enemy, as you could expose our Alliance to danger.',12,0,100,5,0,29586,''),
(61796,13,0,'Do I make myself clear?',12,0,100,0,0,29587,''),
(61796,14,0,'Few people know this, but I was once a pit fighter myself. A gladiator for the Horde\'s amusement. So I know a thing or two about martial combat.',12,0,100,1,0,29568,''),
(61796,15,0,'Now, pandaren... let me see what you\'ve got!',12,0,100,5,0,29569,''),
(61796,16,0,'Don\'t hold back now! Let\'s have it!',12,0,100,5,0,29570,''),
(61796,17,0,'What\'s the matter? You\'ll have to do better than that.',12,0,100,6,0,29571,''),
(61796,18,0,'Come on, pandaren! HIT ME!',14,0,100,5,0,29572,''),
(61796,19,0,'Ha ha ha haaa! I haven\'t felt like this in YEARS! Don\'t worry, $p... I\'ve been in worse scraps than this. A fighting spirit like yours is welcome in the Alliance.  Now, let\'s get back to business.',12,0,100,11,0,29573,'');
-- Texts for 951 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(951,0,0,'Be healed, $g brother:sister;!',12,0,100,0,0,0,'Brother Paxton'),
(951,0,1,'AND I LAY MY HANDS UPON YOU!',12,0,100,0,0,0,'Brother Paxton'),
(951,0,2,'Let the Holy Light embrace you!',12,0,100,0,0,0,'Brother Paxton'),
(951,0,3,'BY THE LIGHT BE RENEWED!',12,0,100,0,0,0,'Brother Paxton'),
(951,0,4,'FIGHT ON, $G BROTHER:SISTER;!',12,0,100,0,0,0,'Brother Paxton'),
(951,1,0,'Be healed, $g brother:sister;!',12,0,100,0,0,0,'Brother Paxton'),
(951,1,1,'FIGHT ON, $G BROTHER:SISTER;!',12,0,100,0,0,0,'Brother Paxton');
-- Texts for 48037 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(48037,0,0,'Battle result: embarrassing failure.  Incorporating new methods into battle regimen.',12,0,100,0,0,0,''),
(48037,1,0,'Self-training complete!',12,0,100,0,0,0,''),
(48037,2,0,'Pummeling received.  Adjusting battle parameters...',12,0,100,0,0,0,''),
(48037,2,1,'Beatdown received.  Optimizing strategy for next battle...',12,0,100,0,0,0,''),
(48037,3,0,'Training level sufficient.  Returning to guard duty.  Thank you.',12,0,100,0,0,0,'');
-- Texts for 17878 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(17878,0,0,'I do not fear death at your hands, $r!',14,0,100,0,0,0,''),
(17878,0,1,'I will tell you nothing, $r-pig!',14,0,100,0,0,0,''),
(17878,0,2,'She will never return the dwarf to you!',14,0,100,0,0,0,''),
(17878,0,3,'The dwarf belongs to our kind now!  Not yours!',14,0,100,0,0,0,''),
(17878,1,0,'The Plaguewood is too big!  Your friend is gone!  You will never find him!',14,0,100,0,0,0,''),
(17878,2,0,'Foolish $r!  You seek the dwarf?  Baroness Anastari has hidden him well!',14,0,100,0,0,0,'');
-- Texts for 44323 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(44323,0,0,'Prepare to die, $r!',12,0,100,0,0,0,''),
(44323,1,0,'Your life is forfeit.',12,0,100,5,0,0,''),
(44323,2,0,'Enough of this.  The Cult of the Damned doesn\'t need Andorhal.  This worthless city is yours to fight over.',12,0,100,5,0,0,'');
-- Texts for 44453 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(44453,0,0,'Gandling is strong, but do not worry.  I will join you shortly after you begin to fight him.',12,0,100,396,0,0,''),
(44453,1,0,'For the Alliance!',14,0,100,0,0,0,'');
-- Texts for 50414 (from LoA)
INSERT IGNORE INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(50414,0,0,'T-thank you, Under-t-taker.',12,0,100,0,0,0,'Risen Recruit');
-- Path 5037400 (from LoA), walked by a script
DELETE FROM `waypoint_data` WHERE `id` = 5037400;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(5037400,1,1702,1677.55,134.298,0,0,1,0,100,0),
(5037400,2,1693.66,1670.64,134.032,0,0,1,0,100,0),
(5037400,3,1686.21,1661.74,133.171,0,0,1,0,100,0),
(5037400,4,1681.66,1655.15,136.316,0,0,1,0,100,0),
(5037400,5,1676.76,1643.16,139.253,0,0,1,0,100,0),
(5037400,6,1669.11,1631.08,139.495,0,0,1,0,100,0),
(5037400,7,1664.2,1620.63,140.526,0,0,1,0,100,0);
-- Path 5037401 (from LoA), walked by a script
DELETE FROM `waypoint_data` WHERE `id` = 5037401;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(5037401,1,1695.44,1672.29,133.945,0,0,0,0,100,0),
(5037401,2,1691.08,1660.22,131.406,0,0,0,0,100,0),
(5037401,3,1709.56,1643.45,124.713,0,0,0,0,100,0),
(5037401,4,1723.48,1633.31,120.426,0,0,0,0,100,0);
-- Path 5041400 (from LoA), walked by a script
DELETE FROM `waypoint_data` WHERE `id` = 5041400;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(5041400,1,1694.16,1677.08,134.786,0,0,0,0,100,0),
(5041400,2,1691.29,1675.84,135.295,0,0,0,0,100,0);
-- Path 5041401 (from LoA), walked by a script
DELETE FROM `waypoint_data` WHERE `id` = 5041401;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(5041401,1,1691.29,1675.85,135.295,0,0,0,0,100,0),
(5041401,2,1690.59,1661.87,131.92,0,0,0,0,100,0),
(5041401,3,1719.38,1633.98,121.065,0,0,0,0,100,0);
