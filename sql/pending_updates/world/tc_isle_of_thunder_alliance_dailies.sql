-- Isle of Thunder: Alliance (Kirin Tor Offensive) daily quests that had no quest giver and no turn-in.
-- The Horde versions (Lor'themar Theron) already work. Relations from TrinityCore (TDB 1210.26091, GPL v2+).
-- Left out on purpose: 32584 and 32585, stage copies of 32580 Encroaching Force with the same objective.
-- Safe to run twice.

DELETE FROM `creature_queststarter` WHERE `quest` IN (32567,32568,32579,32580,32581,32582,32583,32599,32631) AND `id` IN (67992,67996,67997,67998,70517);
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(67992, 32567), -- The Beast Pens
(67996, 32567), -- The Beast Pens
(67997, 32567), -- The Beast Pens
(70517, 32567), -- The Beast Pens
(67992, 32568), -- No Time To Rest
(67996, 32568), -- No Time To Rest
(67997, 32568), -- No Time To Rest
(70517, 32568), -- No Time To Rest
(67992, 32579), -- Competing Magic
(67996, 32579), -- Competing Magic
(67997, 32579), -- Competing Magic
(70517, 32579), -- Competing Magic
(67992, 32580), -- Encroaching Force
(67996, 32580), -- Encroaching Force
(67997, 32580), -- Encroaching Force
(70517, 32580), -- Encroaching Force
(67992, 32581), -- Imposing Threat
(67996, 32581), -- Imposing Threat
(67997, 32581), -- Imposing Threat
(70517, 32581), -- Imposing Threat
(67998, 32582), -- Raining Bones
(67998, 32583), -- Zandalari on the Rise
(67992, 32599), -- Securing A Future
(67992, 32631) -- High Recognition
;

DELETE FROM `creature_questender` WHERE `quest` IN (32567,32568,32579,32580,32581,32582,32583,32599,32631) AND `id` IN (67992,67996,67997,67998,70517);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(67998, 32567), -- The Beast Pens
(67998, 32568), -- No Time To Rest
(67992, 32579), -- Competing Magic
(67992, 32580), -- Encroaching Force
(67992, 32581), -- Imposing Threat
(67998, 32582), -- Raining Bones
(67998, 32583), -- Zandalari on the Rise
(67992, 32599), -- Securing A Future
(67992, 32631) -- High Recognition
;

UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (67992,67996,67997,67998,70517);
