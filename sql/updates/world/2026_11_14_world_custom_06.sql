-- Scholomance (map 1007): script bindings, texts, templates, encounters and spawns for the scripts ported from
-- Legends of Azeroth Pandaria 5.4.8 (GPL v2). Values come from the LoA world DB (2024-07-22). Safe to run twice.


-- creature_template ScriptName
UPDATE `creature_template` SET `ScriptName` = 'boss_instructor_chillheart' WHERE `entry` = 58633; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_instructor_chillhearts_phylactery' WHERE `entry` = 58664; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_acolyte' WHERE `entry` = 58757; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_shatter_soul_fragment' WHERE `entry` = 58758; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_lilian_soul' WHERE `entry` = 58791; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_risen_guard' WHERE `entry` = 58822; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_neophyte' WHERE `entry` = 58823; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_gandling_at_rattlegore' WHERE `entry` = 58875; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_grandmaster_gandling' WHERE `entry` = 59080; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_rattlegore' WHERE `entry` = 59153; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_gandling_room_stalker' WHERE `entry` = 59167; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_jandice_barov' WHERE `entry` = 59184; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_boneweaver' WHERE `entry` = 59193; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'boss_lilian_voss' WHERE `entry` = 59200; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_jandice_illusion' WHERE `entry` = 59220; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_magical_tomes' WHERE `entry` = 59227; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_bone_pile' WHERE `entry` = 59304; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_flesh_horror' WHERE `entry` = 59359; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_krastinoc_carvers' WHERE `entry` = 59368; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_candlestick_mage' WHERE `entry` = 59467; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_dark_candle' WHERE `entry` = 59481; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_professor' WHERE `entry` = 59613; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_scholomance_bored_student' WHERE `entry` = 59614; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_magical_tomes' WHERE `entry` = 59707; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_magical_tomes' WHERE `entry` = 59711; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_talking_skull' WHERE `entry` = 64562; -- was ''
UPDATE `creature_template` SET `ScriptName` = 'npc_magical_tomes' WHERE `entry` = 66240; -- was ''

-- gameobject_template ScriptName
UPDATE `gameobject_template` SET `ScriptName` = 'go_chillheart_iron_door' WHERE `entry` = 211259; -- was ''
UPDATE `gameobject_template` SET `ScriptName` = 'go_alchemy_bottle_white' WHERE `entry` = 211669; -- was ''

-- spell_script_names
DELETE FROM `spell_script_names` WHERE `spell_id` = 111570 AND `ScriptName` = 'spell_deaths_grasp';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111570, 'spell_deaths_grasp');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111609 AND `ScriptName` = 'spell_dark_blaze';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111609, 'spell_dark_blaze');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111631 AND `ScriptName` = 'spell_aura_wrack_soul';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111631, 'spell_aura_wrack_soul');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111642 AND `ScriptName` = 'spell_blazing_soul';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111642, 'spell_blazing_soul');
DELETE FROM `spell_script_names` WHERE `spell_id` = 111669 AND `ScriptName` = 'spell_summon_books';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (111669, 'spell_summon_books');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113280 AND `ScriptName` = 'spell_explosive_pain';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113280, 'spell_explosive_pain');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113312 AND `ScriptName` = 'spell_explosive_pain_proc';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113312, 'spell_explosive_pain_proc');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113765 AND `ScriptName` = 'spell_rattlegore_rusting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113765, 'spell_rattlegore_rusting');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113775 AND `ScriptName` = 'spell_whirl_of_illusion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113775, 'spell_whirl_of_illusion');
DELETE FROM `spell_script_names` WHERE `spell_id` = 113999 AND `ScriptName` = 'spell_bone_spike';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (113999, 'spell_bone_spike');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114009 AND `ScriptName` = 'spell_soul_flame';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114009, 'spell_soul_flame');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114155 AND `ScriptName` = 'spell_boiling_bloodthirst';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114155, 'spell_boiling_bloodthirst');
DELETE FROM `spell_script_names` WHERE `spell_id` = 114800 AND `ScriptName` = 'spell_polymorfic_acid_potion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (114800, 'spell_polymorfic_acid_potion');

UPDATE `instance_template` SET `script` = 'instance_scholomance' WHERE `map` = 1007; -- was ''

-- creature_text for the ported scripts (LoA's rows, matching the scripts' Talk() ids)
DELETE FROM `creature_text` WHERE `entry` = 58633;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58633, 0, 0, 'Class is now in session.', 14, 0, 100, 0, 0, 29460, 'CHILLHEART_INTRO_1'),
(58633, 1, 0, 'Class dismissed.', 14, 0, 100, 0, 0, 29455, 'CHILLHEART_AGGRO'),
(58633, 2, 0, 'Your soul cannot withstand my power!', 14, 0, 100, 0, 0, 29457, 'CHILLHEART_WRACK_SOUL'),
(58633, 3, 0, 'I can never die!', 14, 0, 100, 0, 0, 29458, 'CHILLHEART_FAKE_DEATH'),
(58633, 4, 0, 'THIS CANNOT BE!', 14, 0, 100, 0, 0, 29456, 'CHILLHEART_DEATH'),
(58633, 5, 0, 'A deadly wave of ice begins to sweep across the room!', 14, 0, 100, 0, 0, 0, 'TALK_WAVE_OF_ICE'),
(58633, 6, 0, 'Instructor Chillheart\'s soul escapes to her phylactery. Destroy it!', 14, 0, 100, 0, 0, 0, 'TALK_ESCAPE');
DELETE FROM `creature_text` WHERE `entry` = 58875;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(58875, 0, 0, 'My dear, it appears we have visitors!  Friends of yours, Voss?', 14, 0, 100, 0, 0, 27479, 'GANDLING_TALK_1'),
(58875, 1, 0, 'Their deaths only serve to empower my summoners further! Behold!', 14, 0, 100, 0, 0, 27480, 'GANDLING_TALK_2'),
(58875, 2, 0, 'What\'s the matter, Voss, getting tired?', 14, 0, 100, 0, 0, 27481, 'GANDLING_TALK_3'),
(58875, 3, 0, 'Isn\'t it beautiful? The weaving of flesh and bone and soul.', 14, 0, 100, 0, 0, 27482, 'GANDLING_TALK_4'),
(58875, 4, 0, 'You, too, are beautiful, Voss. Have you looked in a mirror recently?', 14, 0, 100, 0, 0, 27483, 'GANDLING_TALK_5'),
(58875, 5, 0, 'My dear, you should embrace this gift that has been bestowed upon you.', 14, 0, 100, 0, 0, 27484, 'GANDLING_TALK_6'),
(58875, 6, 0, 'Come, Voss, your fate awaits you.', 14, 0, 100, 0, 0, 27485, 'GANDLING_TALK_7');
DELETE FROM `creature_text` WHERE `entry` = 59080;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59080, 0, 0, 'School is in session!', 14, 0, 100, 0, 0, 27477, 'grandmaster gandling - TALK_AGGRO'),
(59080, 1, 0, 'Dunce.', 14, 0, 100, 0, 0, 27497, 'grandmaster gandling - TALK_SLAY'),
(59080, 2, 0, 'Class... dismissed.', 14, 0, 100, 0, 0, 27478, 'grandmaster gandling - TALK_DEATH'),
(59080, 3, 0, '|TInterface\\Icons\\inv_misc_book_01.blp:20|t%s assigns $n a |cFFFF0000|Hspell:113395|h[Harsh Lesson]|h|r!', 41, 0, 100, 0, 0, 0, 'grandmaster gandling - TALK_HARSH_LESSON');
DELETE FROM `creature_text` WHERE `entry` = 59153;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59153, 0, 0, 'RATTLEGORE!', 14, 0, 100, 0, 0, 0, 'rattlegore - TALK_SUMMONED'),
(59153, 1, 0, 'Click on a Bone Pile to protect yourself from Bone Spike!', 41, 0, 100, 0, 0, 0, 'rattlegore - TALK_BONE_PILE_ANN');
DELETE FROM `creature_text` WHERE `entry` = 59184;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59184, 0, 0, 'Ooh, it takes some real stones to challenge the Mistress of Illusion. Well? Show me what you\'ve got!', 14, 0, 100, 0, 0, 30287, 'JANDICE_AGGRO'),
(59184, 1, 0, 'Ugh... death... hurts? Unreal...', 14, 0, 100, 0, 0, 30288, 'JANDICE_DEATH'),
(59184, 2, 0, 'Come, try your luck! Ha ha haaa...', 14, 0, 100, 0, 0, 30292, 'JANDICE_RAPIDITY'),
(59184, 3, 0, 'Feeling a bit... dizzy?', 14, 0, 100, 0, 0, 30293, 'JANDICE_ILLUSION');
DELETE FROM `creature_text` WHERE `entry` = 59200;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59200, 0, 0, 'I...won\'t let you...', 14, 0, 100, 0, 0, 29464, 'LILIAN_TALK_1'),
(59200, 1, 0, 'I can\'t...fight him...', 14, 0, 100, 0, 0, 29465, 'LILIAN_TALK_2'),
(59200, 2, 0, 'It burns...my soul...it burns!!!!', 14, 0, 100, 0, 0, 29468, 'LILIAN_TALK_3'),
(59200, 3, 0, 'END IT! NOW! Before he can...', 14, 0, 100, 0, 0, 29463, 'LILIAN_TALK_4'),
(59200, 4, 0, 'DIE, NECROMANCER!', 14, 0, 100, 0, 0, 29466, 'LILIAN_TALK_5'),
(59200, 5, 0, 'Leave me...to die...alone...please...', 14, 0, 100, 0, 0, 29467, 'LILIAN_TALK_6'),
(59200, 6, 0, 'You there!  Make yourselves useful and deal with these summoners!', 12, 0, 100, 0, 0, 29469, 'LILIAN_TALK_1'),
(59200, 7, 0, 'You feed their souls to their brethren?  You are sick.', 12, 0, 100, 0, 0, 29470, 'LILIAN_TALK_2'),
(59200, 8, 0, 'I\'ll never stop hunting your kind, necromancer.  NEVER.', 12, 0, 100, 0, 0, 29471, 'LILIAN_TALK_3'),
(59200, 9, 0, 'We\'ll see if you revel so much in death once I\'ve ripped out your throat!', 12, 0, 100, 0, 0, 29472, 'LILIAN_TALK_4'),
(59200, 10, 0, 'You\'ll pay for your tongue.', 12, 0, 100, 0, 0, 29473, 'LILIAN_TALK_6'),
(59200, 11, 0, 'Run...necromancer...your life ends once I catch my breath.', 12, 0, 100, 0, 0, 29475, 'LILIAN_TALK_7');
DELETE FROM `creature_text` WHERE `entry` = 59368;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(59368, 0, 0, 'Blood blood blood BLOOD BLOOD!!', 12, 0, 100, 0, 0, 27752, ''),
(59368, 0, 1, 'More blood!', 12, 0, 100, 0, 0, 27754, ''),
(59368, 0, 2, 'Yes! Yes! More blood!', 12, 0, 100, 0, 0, 27751, ''),
(59368, 1, 0, 'The scent of blood...so delicious!', 12, 0, 100, 0, 0, 27755, '');
DELETE FROM `creature_text` WHERE `entry` = 64562;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`) VALUES
(64562, 0, 0, 'Here we go. Do try to keep yourselves alive until the end.', 12, 0, 100, 0, 0, 0, ''),
(64562, 1, 0, 'We\'re coming for you, Chillheart! Time for payback!', 14, 0, 100, 0, 0, 0, ''),
(64562, 2, 0, 'The Talking Skull cackles gleefully as the instructor\'s soul is destroyed.', 16, 0, 100, 0, 0, 0, ''),
(64562, 3, 0, 'The Talking Skull seems hesitant to enter the hall, but proceeds with you nonetheless.', 16, 0, 100, 0, 0, 0, ''),
(64562, 4, 0, 'I can\'t bear to watch.', 12, 0, 100, 0, 0, 0, ''),
(64562, 5, 0, 'The Talking Skull proceeds into the next chamber without saying a word.', 16, 0, 100, 0, 0, 0, ''),
(64562, 6, 0, 'Die, Gandling! Kill him!', 14, 0, 100, 0, 0, 0, ''),
(64562, 7, 0, 'NO! Get back here coward!', 14, 0, 100, 0, 0, 0, ''),
(64562, 8, 0, 'Let\'s go!', 12, 0, 100, 0, 0, 0, ''),
(64562, 9, 0, 'There he is! Kill him now, $p!', 14, 0, 100, 0, 0, 0, ''),
(64562, 10, 0, 'Stop him! Forget about her!', 14, 0, 100, 0, 0, 0, ''),
(64562, 11, 0, 'PREPARE TO DIE, VILLAIN!', 14, 0, 100, 0, 0, 0, '');


-- spell_areatrigger_template (Jandice's Gravity Flux, Chillheart's Ice Wall)
DELETE FROM `spell_areatrigger_template` WHERE `Entry` IN (204, 348);
INSERT INTO `spell_areatrigger_template` (`Entry`, `Flags`, `CollisionType`, `Radius`, `ScaleX`, `ScaleY`, `ScriptName`) VALUES
(204, 0, 1, 4, 0, 0, 'sat_scholomance_gravity_flux'),
(348, 0, 0, 15, 0, 0, 'sat_ice_wall');

-- creature_template SkyFire lacks: Ice Wall stalker (drives Chillheart's Ice Wall)
DELETE FROM `creature_template` WHERE `entry` = 68291;
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`exp_unk`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`npc_rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`type_flags2`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Mana_mod_extra`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`ModLevel`,`detection_range`,`WDBVerified`) VALUES
(68291, 0, 0, 0, 0, 0, 47615, 0, 0, 0, 'Ice Wall', '', '', 0, 90, 90, 4, 0, 14, 14, 0, 1, 1.14286, 1, 1, 14666, 24933, 0, 45299, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1073741888, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 100, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 128, 'npc_ice_wall_stalker', 0, 10, );

-- creature_template (values from the LoA world DB; SkyFire's speeds, gold, loot ids, spells and health are kept)
UPDATE `creature_template` SET `minlevel` = 87, `maxlevel` = 87, `exp` = 3, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432, `unit_flags2` = 34816, `flags_extra` = 128 WHERE `entry` = 57860; -- Frost Grasp Stalker
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 974, `faction_H` = 974, `mechanic_immune_mask` = 769638399, `unit_class` = 8, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 58633; -- Instructor Chillheart
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `unit_class` = 8, `VehicleId` = 2020, `dmg_multiplier` = 3 WHERE `entry` = 58662; -- Instructor Chillheart\'s Phylactery Vehicle
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 974, `faction_H` = 974, `mechanic_immune_mask` = 769638399, `unit_class` = 8 WHERE `entry` = 58664; -- Instructor Chillheart\'s Phylactery
UPDATE `creature_template` SET `minlevel` = 92, `maxlevel` = 92, `flags_extra` = 128, `dmg_multiplier` = 3 WHERE `entry` = 58753; -- Arcane Bomb
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16, `unit_class` = 8 WHERE `entry` = 58757; -- Scholomance Acolyte
UPDATE `creature_template` SET `minlevel` = 2, `maxlevel` = 2 WHERE `entry` = 58780; -- Dark Blaze
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 14, `faction_H` = 14, `dmg_multiplier` = 1.1 WHERE `entry` = 58791; -- Lilian\'s Soul
UPDATE `creature_template` SET `minlevel` = 42, `maxlevel` = 42, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 58822; -- Risen Guard
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16, `unit_class` = 8 WHERE `entry` = 58823; -- Scholomance Neophyte
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 14, `faction_H` = 14, `mechanic_immune_mask` = 769638399, `unit_class` = 2, `VehicleId` = 2024, `dmg_multiplier` = 9 WHERE `entry` = 58875; -- Darkmaster Gandling
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `flags_extra` = 128 WHERE `entry` = 58917; -- Book Spawn Target
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 21, `faction_H` = 21, `mechanic_immune_mask` = 769638399, `unit_class` = 2, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59080; -- Darkmaster Gandling
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `unit_flags` = 524288 WHERE `entry` = 59099; -- Fresh Test Subject
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 59100; -- Expired Test Subject
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 233, `faction_H` = 233, `mechanic_immune_mask` = 769638399, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59153; -- Rattlegore
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `dmg_multiplier` = 3 WHERE `entry` = 59167; -- Teleport Location
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 233, `faction_H` = 233, `mechanic_immune_mask` = 769638399, `unit_class` = 2, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59184; -- Jandice Barov
UPDATE `creature_template` SET `minlevel` = 42, `maxlevel` = 42, `faction_A` = 2245, `faction_H` = 2245, `unit_class` = 2 WHERE `entry` = 59193; -- Boneweaver
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 2036, `faction_H` = 2036, `mechanic_immune_mask` = 769638399, `unit_class` = 2, `flags_extra` = 1, `dmg_multiplier` = 9 WHERE `entry` = 59200; -- Lilian Voss
UPDATE `creature_template` SET `minlevel` = 43, `maxlevel` = 43, `faction_A` = 233, `faction_H` = 233, `mechanic_immune_mask` = 769638399, `unit_class` = 8, `dmg_multiplier` = 1.1 WHERE `entry` = 59220; -- Jandice Barov
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `InhabitType` = 4 WHERE `entry` = 59227; -- Wander\'s Colossal Book of Shadow Puppets
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 233, `faction_H` = 233 WHERE `entry` = 59242; -- Woven Boneguard
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 2028, `faction_H` = 2028, `npcflag` = 16777216 WHERE `entry` = 59304; -- Bone Pile
UPDATE `creature_template` SET `minlevel` = 92, `maxlevel` = 92, `faction_A` = 14, `faction_H` = 14, `unit_flags` = 33554432 WHERE `entry` = 59316; -- Soulflame
UPDATE `creature_template` SET `minlevel` = 42, `maxlevel` = 42, `faction_A` = 16, `faction_H` = 16, `VehicleId` = 2098 WHERE `entry` = 59359; -- Flesh Horror
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 21, `faction_H` = 21 WHERE `entry` = 59368; -- Krastinovian Carver
UPDATE `creature_template` SET `minlevel` = 91, `maxlevel` = 91, `faction_A` = 21, `faction_H` = 21, `dmg_multiplier` = 12.5 WHERE `entry` = 59369; -- Doctor Theolen Krastinov
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16, `unit_class` = 2 WHERE `entry` = 59467; -- Candlestick Mage
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 233, `faction_H` = 233 WHERE `entry` = 59501; -- Reanimated Corpse
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 59503; -- Brittle Skeleton
UPDATE `creature_template` SET `minlevel` = 42, `maxlevel` = 42, `faction_A` = 14, `faction_H` = 14, `unit_class` = 2 WHERE `entry` = 59613; -- Professor Slate
UPDATE `creature_template` SET `minlevel` = 41, `maxlevel` = 41, `faction_A` = 16, `faction_H` = 16, `unit_class` = 2 WHERE `entry` = 59614; -- Bored Student
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `InhabitType` = 4 WHERE `entry` = 59707; -- The Anarchist Arcanist
UPDATE `creature_template` SET `faction_A` = 14, `faction_H` = 14, `flags_extra` = 128, `dmg_multiplier` = 3, `InhabitType` = 4 WHERE `entry` = 59711; -- Arcane Bomb Chase
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 59980; -- Meat Graft
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `flags_extra` = 128 WHERE `entry` = 62731; -- Ice Wall
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `npcflag` = 2 WHERE `entry` = 64683; -- Spirit of Lord Alexei Barov
UPDATE `creature_template` SET `minlevel` = 90, `maxlevel` = 90, `faction_A` = 16, `faction_H` = 16, `InhabitType` = 4 WHERE `entry` = 66240; -- Antonidas\' Self Help Guide to Standing in Fire

-- creature_template_addon
DELETE FROM `creature_template_addon` WHERE `entry` = 54020;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (54020, 0, 0, 50331648, 1, 0, NULL);
DELETE FROM `creature_template_addon` WHERE `entry` = 58875;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (58875, 0, 0, 50331648, 1, 0, '112058');
DELETE FROM `creature_template_addon` WHERE `entry` = 59080;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59080, 0, 0, 0, 1, 0, '21389');
DELETE FROM `creature_template_addon` WHERE `entry` = 59099;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59099, 0, 0, 0, 1, 0, '113280');
DELETE FROM `creature_template_addon` WHERE `entry` = 59153;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59153, 0, 0, 0, 1, 0, '113763');
DELETE FROM `creature_template_addon` WHERE `entry` = 59193;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59193, 0, 0, 0, 1, 0, '113647');
DELETE FROM `creature_template_addon` WHERE `entry` = 59227;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59227, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 59304;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59304, 0, 0, 0, 1, 0, '113995');
DELETE FROM `creature_template_addon` WHERE `entry` = 59316;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59316, 0, 0, 0, 1, 0, '114057');
DELETE FROM `creature_template_addon` WHERE `entry` = 59359;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59359, 0, 0, 0, 1, 0, '114176');
DELETE FROM `creature_template_addon` WHERE `entry` = 59368;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59368, 0, 0, 0, 1, 0, '128122');
DELETE FROM `creature_template_addon` WHERE `entry` = 59503;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59503, 0, 0, 0, 1, 0, '19818');
DELETE FROM `creature_template_addon` WHERE `entry` = 59613;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59613, 0, 0, 0, 1, 0, '124143');
DELETE FROM `creature_template_addon` WHERE `entry` = 59707;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59707, 0, 0, 50331648, 1, 0, '');
DELETE FROM `creature_template_addon` WHERE `entry` = 59980;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (59980, 0, 0, 0, 1, 0, '114178');
DELETE FROM `creature_template_addon` WHERE `entry` = 64562;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (64562, 0, 0, 0, 1, 0, '126155');
DELETE FROM `creature_template_addon` WHERE `entry` = 66240;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES (66240, 0, 0, 50331648, 1, 0, '');

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 112081;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 112081, 0, 1, 31, 0, 3, 59200, 0, 0, 0, 0, '', 'Cosmetic Soul Reap Beam - by Gandling to Lilian');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 122499;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 122499, 0, 1, 31, 0, 3, 58664, 0, 0, 0, 0, '', 'Cosmetic Shadow Channel - by Chillheart');

-- npc_spellclick_spells
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 59304;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(59304, 46598, 1, 0);

-- instance_encounters (DungeonEncounter.dbc ids; LFG dungeons 2 normal / 472 heroic end with Gandling)
DELETE FROM `instance_encounters` WHERE `entry` IN (1426, 1427, 1428, 1429, 1430);
INSERT INTO `instance_encounters` (`entry`, `creditType`, `creditEntry`, `lastEncounterDungeon`, `comment`) VALUES
(1426, 0, 58633, 0, 'Instructor Chillheart'),
(1427, 0, 59184, 0, 'Jandice Barov'),
(1428, 0, 59153, 0, 'Rattlegore'),
(1429, 0, 59200, 0, 'Lilian Voss'),
(1430, 0, 59080, 2, 'Darkmaster Gandling');

-- gameobject_template ('unk name' stubs and chests without a loot id)
UPDATE `gameobject_template` SET `name` = 'Reinforced Wooden Door', `data1` = 77, `faction` = 1375, `flags` = 34 WHERE `entry` = 210771;
UPDATE `gameobject_template` SET `name` = 'Vault of Souls', `data1` = 77, `faction` = 114, `flags` = 32 WHERE `entry` = 210781;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_bottom05', `faction` = 114, `flags` = 32 WHERE `entry` = 210783;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_bottom06', `faction` = 1375, `flags` = 32 WHERE `entry` = 210784;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_top01', `faction` = 114, `flags` = 32 WHERE `entry` = 210785;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_top02', `faction` = 114, `flags` = 32 WHERE `entry` = 210786;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_top03', `faction` = 114, `flags` = 32 WHERE `entry` = 210787;
UPDATE `gameobject_template` SET `name` = 'doodad_Vaultgate_bottom04', `faction` = 114, `flags` = 32 WHERE `entry` = 210788;
UPDATE `gameobject_template` SET `name` = 'Doodad_Portcullis_to_TeleportBossroom', `data0` = 1, `faction` = 114, `flags` = 32 WHERE `entry` = 210789;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Doodad_UndeadCampFire29', `data1` = 10, `data2` = 5622444, `data4` = 5708708, `flags` = 4 WHERE `entry` = 210791;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Doodad_UndeadCampFire30', `data1` = 10, `data2` = 5622444, `data4` = 5708708, `flags` = 4 WHERE `entry` = 210792;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Doodad_UndeadCampFire31', `data1` = 10, `data2` = 5622444, `data4` = 5708708, `flags` = 4 WHERE `entry` = 210793;
UPDATE `gameobject_template` SET `type` = 8, `name` = 'Doodad_UndeadCampFire32', `data1` = 10, `data2` = 5622444, `data4` = 5708708, `flags` = 4 WHERE `entry` = 210794;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `data1` = 77, `faction` = 114, `flags` = 32 WHERE `entry` = 211256;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `data0` = 1, `data1` = 86, `faction` = 114, `flags` = 32 WHERE `entry` = 211257;
UPDATE `gameobject_template` SET `name` = 'ChillheartToJandice', `faction` = 114, `flags` = 32 WHERE `entry` = 211258;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `data1` = 81, `faction` = 35, `flags` = 32 WHERE `entry` = 211259;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `flags` = 32 WHERE `entry` = 211260;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `data1` = 81, `flags` = 32 WHERE `entry` = 211261;
UPDATE `gameobject_template` SET `name` = 'Iron Gate', `data1` = 85, `faction` = 1375, `flags` = 34 WHERE `entry` = 211262;
UPDATE `gameobject_template` SET `type` = 3, `name` = 'Coffer of Forgotten Souls', `data0` = 1634, `data1` = 43112, `data3` = 1, `data11` = 1, `data13` = 1, `data15` = 1, `data20` = 90, `data25` = 1429, `faction` = 35, `flags` = 32 WHERE `entry` = 211278;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Alchemy Bottle White', `faction` = 1375 WHERE `entry` = 211647;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Alchemy Bottle Green', `faction` = 1375 WHERE `entry` = 211648;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Alchemy Bottle Blue', `faction` = 1375 WHERE `entry` = 211649;
UPDATE `gameobject_template` SET `type` = 22, `name` = 'Polyformic Acid Potion', `data0` = 114800, `data1` = -1, `faction` = 35, `flags` = 32 WHERE `entry` = 211669;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Polyformic Acid Potion Highlight', `data1` = 1, `faction` = 1375 WHERE `entry` = 211670;
UPDATE `gameobject_template` SET `type` = 5, `name` = 'Grandmaster Architect Holmberg', `data1` = 1, `data3` = 1, `flags` = 32 WHERE `entry` = 214178;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'The Dark Grimoire', `data0` = 93, `data3` = 2147483647, `data14` = 24585 WHERE `entry` = 214277;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Kel\'Thuzad\'s Deep Knowledge', `data0` = 93, `data3` = 2147483647, `data14` = 24585 WHERE `entry` = 214278;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'In the Shadow of the Light', `data0` = 93, `data3` = 2147483647, `data14` = 24585 WHERE `entry` = 214279;
UPDATE `gameobject_template` SET `type` = 10, `name` = 'Forbidden Rites and other Rituals Necromantic', `data0` = 93, `data3` = 2147483647, `data14` = 24585 WHERE `entry` = 214280;

-- chest loot SkyFire lacks
-- Coffer of Forgotten Souls (211278)
DELETE FROM `gameobject_loot_template` WHERE `entry` = 43112;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(43112, 81567, 0, 1, 1, 1, 1),
(43112, 82853, 0, 1, 1, 1, 1),
(43112, 82854, 0, 1, 1, 1, 1),
(43112, 82855, 0, 1, 1, 1, 1),
(43112, 82856, 0, 1, 1, 1, 1);



-- gameobject_template rows SkyFire lacks
DELETE FROM `gameobject_template` WHERE `entry` IN (211277,214101,214105,214106,214107);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `data24`, `data25`, `data26`, `data27`, `data28`, `data29`, `data30`, `data31`, `unkInt32`, `AIName`, `ScriptName`, `WDBVerified`) VALUES
(211277, 3, 9233, 'Coffer of Forgotten Souls', '', '', '', 35, 32, 1, 0, 0, 0, 0, 0, 0, 1634, 43297, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 42, 0, 0, 0, 0, 1429, 0, 0, 0, 0, 0, 0, 0, '', '', 19342),
(214101, 10, 255, 'In the Shadow of the Light', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 19342),
(214105, 10, 6894, 'Kel\'Thuzad\'s Deep Knowledge', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 19342),
(214106, 10, 6908, 'Forbidden Rites and other Rituals Necromantic', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 19342),
(214107, 10, 6893, 'The Dark Grimoire', '', '', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24585, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 19342);

DELETE FROM `creature` WHERE `guid` BETWEEN 9508000 AND 9508612;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9508000, 59167, 1007, 262, 0, 0, 0, 0, -55.0504, 57.882, 83.596, 6.26573, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538327
(9508001, 59099, 1007, 262, 0, 0, 0, 0, -50.9809, 57.9062, 69.1412, 2.1293, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538328
(9508002, 59100, 1007, 262, 0, 0, 0, 0, -49.2622, 74.0504, 83.5127, 2.21696, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538330
(9508003, 59099, 1007, 262, 0, 0, 0, 0, -49.1233, 66.4566, 69.1412, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538331
(9508004, 59099, 1007, 262, 0, 0, 0, 0, -48.2031, 47.5885, 69.1412, 3.94444, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538335
(9508005, 59100, 1007, 262, 0, 0, 0, 0, -48.1138, 68.6338, 83.5127, 5.01235, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538337
(9508006, 59100, 1007, 262, 0, 0, 0, 0, -46.9845, 72.4337, 83.5127, 5.77463, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538340
(9508007, 59100, 1007, 262, 0, 0, 0, 0, -45.9967, 46.5193, 83.5127, 4.39135, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538346
(9508008, 59100, 1007, 262, 0, 0, 0, 0, -44.7505, 67.7036, 83.5127, 1.74891, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538355
(9508009, 59100, 1007, 262, 0, 0, 0, 0, -44.2158, 72.1362, 83.5127, 2.34516, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538356
(9508010, 59100, 1007, 262, 0, 0, 0, 0, -44.034, 70.418, 83.5127, 0.00127666, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538359
(9508011, 59100, 1007, 262, 0, 0, 0, 0, -44.0277, 66.6562, 83.5127, 1.42395, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538360
(9508012, 59100, 1007, 262, 0, 0, 0, 0, -42.7536, 42.5728, 83.5127, 5.5508, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538362
(9508013, 59100, 1007, 262, 0, 0, 0, 0, -41.3663, 41.184, 83.5961, 1.20428, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538366
(9508014, 59100, 1007, 262, 0, 0, 0, 0, -39.9392, 44.6146, 83.5127, 3.14516, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538368
(9508015, 59100, 1007, 262, 0, 0, 0, 0, -38.2391, 49.5722, 83.5127, 5.80972, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538377
(9508016, 59099, 1007, 262, 0, 0, 0, 0, -35.6215, 71.908, 73.7656, 0.20944, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538382
(9508017, 59100, 1007, 262, 0, 0, 0, 0, -34.8501, 46.3928, 83.5127, 5.98435, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538386
(9508018, 59099, 1007, 262, 0, 0, 0, 0, -34.4566, 47.6198, 73.7656, 5.77704, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538387
(9508019, 59100, 1007, 262, 0, 0, 0, 0, -32.5733, 43.9367, 83.5127, 1.71386, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538389
(9508020, 59099, 1007, 262, 0, 0, 0, 0, -32.2552, 60.3038, 83.2086, 0.907571, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538391
(9508021, 59100, 1007, 262, 0, 0, 0, 0, -32.1875, 41.2865, 83.5961, 6.23082, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538393
(9508022, 59100, 1007, 262, 0, 0, 0, 0, -29.0975, 61.7943, 73.6823, 5.60652, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538396
(9508023, 59099, 1007, 262, 0, 0, 0, 0, -28.8542, 55.967, 83.2086, 5.37561, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538397
(9508024, 59100, 1007, 262, 0, 0, 0, 0, -28.7805, 60.4267, 73.6823, 3.04469, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538398
(9508025, 59100, 1007, 262, 0, 0, 0, 0, -26.6298, 52.1112, 73.6823, 5.07233, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538410
(9508026, 59100, 1007, 262, 0, 0, 0, 0, -26.3611, 60.6838, 73.6823, 0.231548, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538411
(9508027, 59100, 1007, 262, 0, 0, 0, 0, -26.3266, 54.3608, 73.6823, 0.587489, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538412
(9508028, 59099, 1007, 262, 0, 0, 0, 0, -25.4861, 61.3542, 83.2086, 5.61996, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538413
(9508029, 59100, 1007, 262, 0, 0, 0, 0, -23.8507, 48.7591, 73.6823, 2.69674, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538416
(9508030, 59100, 1007, 262, 0, 0, 0, 0, -23.4149, 65.961, 73.6823, 4.23607, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538420
(9508031, 59099, 1007, 262, 0, 0, 0, 0, -21.8646, 54.4913, 83.2086, 6.23082, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538427
(9508032, 59100, 1007, 262, 0, 0, 0, 0, -21.5763, 50.0963, 73.6823, 2.0518, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538428
(9508033, 59167, 1007, 262, 0, 0, 0, 0, -19.2205, 57.7344, 73.7656, 6.23082, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538431
(9508034, 59100, 1007, 262, 0, 0, 0, 0, -18.6482, 68.1793, 73.6823, 3.00384, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538433
(9508035, 59099, 1007, 262, 0, 0, 0, 0, -18.2448, 57.8056, 83.5961, 3.14159, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538436
(9508036, 59100, 1007, 262, 0, 0, 0, 0, -17.8625, 49.5288, 73.6823, 5.88494, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538438
(9508037, 59100, 1007, 262, 0, 0, 0, 0, -16.4856, 49.4695, 73.6823, 3.267, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538442
(9508038, 59100, 1007, 262, 0, 0, 0, 0, -16.1028, 68.2993, 73.6823, 0.283723, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538444
(9508039, 59100, 1007, 262, 0, 0, 0, 0, -15.0694, 49.099, 73.6823, 1.82148, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538449
(9508040, 59100, 1007, 262, 0, 0, 0, 0, -14.9632, 63.2937, 73.6823, 3.74612, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538450
(9508041, 59100, 1007, 262, 0, 0, 0, 0, -11.8669, 64.2053, 73.6823, 6.18305, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538456
(9508042, 59100, 1007, 262, 0, 0, 0, 0, -11.6581, 52.6125, 73.6823, 3.34548, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538457
(9508043, 59100, 1007, 262, 0, 0, 0, 0, -10.0937, 58.4254, 73.6823, 4.69897, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538463
(9508044, 59100, 1007, 262, 0, 0, 0, 0, -9.47699, 53.022, 73.6823, 1.16822, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538471
(9508045, 59100, 1007, 262, 0, 0, 0, 0, -9.44072, 55.017, 73.6823, 4.91522, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538472
(9508046, 59100, 1007, 262, 0, 0, 0, 0, -8.7658, 62.3666, 73.6823, 1.10062, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538478
(9508047, 50485, 1007, 262, 0, 0, 0, 0, 14.0992, 80.7324, 87.297, 3.42337, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538481
(9508048, 50485, 1007, 262, 0, 0, 0, 0, 14.9075, 81.95, 87.2825, 2.8733, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538482
(9508049, 50485, 1007, 262, 0, 0, 0, 0, 15.2487, 81.34, 87.2897, 3.87914, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538483
(9508050, 50485, 1007, 262, 0, 0, 0, 0, 15.3528, 80.3987, 87.3009, 4.37657, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538484
(9508051, 50485, 1007, 262, 0, 0, 0, 0, 15.6233, 81.1736, 87.2917, 3.44772, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538485
(9508052, 50485, 1007, 262, 0, 0, 0, 0, 15.7487, 80.6813, 87.2975, 4.96196, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538486
(9508053, 50485, 1007, 262, 0, 0, 0, 0, 16.3359, 81.3788, 87.2893, 1.50787, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538490
(9508054, 59100, 1007, 262, 0, 0, 0, 0, 16.6639, 105.405, 73.6823, 3.51335, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538492
(9508055, 59100, 1007, 262, 0, 0, 0, 0, 17.1038, 104.625, 73.6823, 5.67998, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538495
(9508056, 50485, 1007, 262, 0, 0, 0, 0, 17.1134, 81.627, 87.2863, 0.128194, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538496
(9508057, 59100, 1007, 262, 0, 0, 0, 0, 18.4697, -1.92548, 70.9575, 5.77789, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538497
(9508058, 59100, 1007, 262, 0, 0, 0, 0, 19.2816, -6.18517, 83.5127, 3.27957, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538500
(9508059, 59100, 1007, 262, 0, 0, 0, 0, 19.308, -2.56747, 70.9575, 3.41818, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538501
(9508060, 59100, 1007, 262, 0, 0, 0, 0, 20.1495, 95.896, 73.6823, 1.54322, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538506
(9508061, 59080, 1007, 262, 0, 0, 0, 0, 20.151, 57.7448, 73.883, 0, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538507
(9508062, 59100, 1007, 262, 0, 0, 0, 0, 20.2015, 98.5216, 73.6823, 1.67822, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538509
(9508063, 59099, 1007, 262, 0, 0, 0, 0, 20.3177, 103.12, 73.7656, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538512
(9508064, 59100, 1007, 262, 0, 0, 0, 0, 20.3425, -2.61697, 83.5127, 0.164778, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538513
(9508065, 59100, 1007, 262, 0, 0, 0, 0, 20.3578, 96.4375, 73.6823, 4.755, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538515
(9508066, 59100, 1007, 262, 0, 0, 0, 0, 20.8651, -3.15166, 70.9575, 5.8023, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538521
(9508067, 59100, 1007, 262, 0, 0, 0, 0, 21.0035, -1.0191, 83.5127, 1.7647, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538525
(9508068, 59100, 1007, 262, 0, 0, 0, 0, 21.0651, -17.4971, 83.5127, 2.80353, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538527
(9508069, 59100, 1007, 262, 0, 0, 0, 0, 21.5955, 0.89942, 70.9575, 3.17814, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538531
(9508070, 59100, 1007, 262, 0, 0, 0, 0, 21.9591, -6.92071, 83.5127, 0.359277, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538534
(9508071, 59100, 1007, 262, 0, 0, 0, 0, 22.3722, -3.68585, 83.5127, 6.13707, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538539
(9508072, 59099, 1007, 262, 0, 0, 0, 0, 22.441, 115.783, 73.7656, 0.698132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538540
(9508073, 59099, 1007, 262, 0, 0, 0, 0, 23.6562, 18.6944, 87.3203, 3.9619, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538545
(9508074, 59100, 1007, 262, 0, 0, 0, 0, 24.0708, 113.415, 83.5016, 1.92626, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538549
(9508075, 59100, 1007, 262, 0, 0, 0, 0, 24.1677, 105.987, 83.5219, 6.04678, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538552
(9508076, 59100, 1007, 262, 0, 0, 0, 0, 24.2138, 0.553809, 70.9575, 2.8385, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538553
(9508077, 59099, 1007, 262, 0, 0, 0, 0, 24.349, 137.809, 83.5961, 3.94444, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538556
(9508078, 59100, 1007, 262, 0, 0, 0, 0, 25.171, 18.1975, 70.9575, 2.20196, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538570
(9508079, 59100, 1007, 262, 0, 0, 0, 0, 25.1831, 1.35198, 70.9575, 0.152294, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538571
(9508080, 59100, 1007, 262, 0, 0, 0, 0, 25.3628, -17.3084, 83.1253, 4.68202, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538575
(9508081, 59100, 1007, 262, 0, 0, 0, 0, 25.5555, 111.717, 73.6823, 4.14859, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538579
(9508082, 59100, 1007, 262, 0, 0, 0, 0, 25.6505, 11.8686, 83.5127, 3.86386, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538583
(9508083, 59100, 1007, 262, 0, 0, 0, 0, 25.8594, 111.454, 83.507, 6.01657, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538589
(9508084, 59100, 1007, 262, 0, 0, 0, 0, 26.1021, 110.846, 73.6823, 0.677084, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538592
(9508085, 59100, 1007, 262, 0, 0, 0, 0, 26.1754, 112.885, 73.6823, 2.27035, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538594
(9508086, 59100, 1007, 262, 0, 0, 0, 0, 26.3765, 2.80815, 70.9575, 3.05273, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538597
(9508087, 59100, 1007, 262, 0, 0, 0, 0, 26.444, 13.5868, 83.5127, 0.587814, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538598
(9508088, 59100, 1007, 262, 0, 0, 0, 0, 26.9332, 102.321, 73.6823, 3.38704, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538610
(9508089, 59100, 1007, 262, 0, 0, 0, 0, 27.2053, 120.934, 83.5127, 2.16029, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538612
(9508090, 59099, 1007, 262, 0, 0, 0, 0, 27.4254, -9.10764, 83.2086, 0.698132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538614
(9508091, 59100, 1007, 262, 0, 0, 0, 0, 27.4367, -13.7866, 83.1253, 1.42721, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538615
(9508092, 59099, 1007, 262, 0, 0, 0, 0, 27.6493, -5.27431, 72.5444, 0.925025, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538620
(9508093, 59099, 1007, 262, 0, 0, 0, 0, 27.8472, 6.29167, 72.5437, 3.92699, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538624
(9508094, 59100, 1007, 262, 0, 0, 0, 0, 28.1457, 14.8835, 83.5127, 1.18981, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538628
(9508095, 59100, 1007, 262, 0, 0, 0, 0, 28.2348, 1.4721, 70.9575, 5.12143, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538629
(9508096, 59100, 1007, 262, 0, 0, 0, 0, 28.3682, 106.971, 83.5192, 2.08296, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538630
(9508097, 59099, 1007, 262, 0, 0, 0, 0, 28.8698, 139.521, 83.7442, 2.67035, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538636
(9508098, 59100, 1007, 262, 0, 0, 0, 0, 29.7623, 112.643, 83.5037, 5.44427, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538643
(9508099, 30298, 1007, 262, 0, 0, 0, 0, 30.25, 57.842, 92.7124, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538651
(9508100, 59100, 1007, 262, 0, 0, 0, 0, 30.335, 14.5152, 70.9575, 2.04881, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538653
(9508101, 59100, 1007, 262, 0, 0, 0, 0, 30.444, 23.6021, 70.9575, 5.23486, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538654
(9508102, 59167, 1007, 262, 0, 0, 0, 0, 30.5781, 132.503, 73.7336, 4.64258, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538657
(9508103, 59167, 1007, 262, 0, 0, 0, 0, 30.6979, -12.6875, 71.0408, 1.51844, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538658
(9508104, 59099, 1007, 262, 0, 0, 0, 0, 30.7986, 109.939, 73.7656, 3.94444, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538661
(9508105, 50485, 1007, 262, 0, 0, 0, 0, 30.9179, 31.3494, 87.251, 0.024538, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538662
(9508106, 59167, 1007, 262, 0, 0, 0, 0, 31.1198, -28.1736, 83.596, 1.51844, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538668
(9508107, 59100, 1007, 262, 0, 0, 0, 0, 31.245, 9.29725, 83.5127, 1.33411, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538670
(9508108, 59100, 1007, 262, 0, 0, 0, 0, 31.2778, 23.0677, 70.9575, 6.17642, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538672
(9508109, 59167, 1007, 262, 0, 0, 0, 0, 31.2882, 145.538, 83.596, 4.67748, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538675
(9508110, 59100, 1007, 262, 0, 0, 0, 0, 31.4254, 104.929, 83.5248, 5.75734, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538677
(9508111, 59100, 1007, 262, 0, 0, 0, 0, 31.6573, 13.7845, 70.9575, 6.03947, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538681
(9508112, 59100, 1007, 262, 0, 0, 0, 0, 32.2146, 105.712, 83.5226, 6.10465, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538692
(9508113, 59100, 1007, 262, 0, 0, 0, 0, 32.2639, 118.188, 83.5127, 2.81259, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538693
(9508114, 59100, 1007, 262, 0, 0, 0, 0, 32.5423, 11.4035, 83.5127, 0.46756, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538695
(9508115, 59099, 1007, 262, 0, 0, 0, 0, 32.6875, 2.77083, 83.2086, 3.94444, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538697
(9508116, 50485, 1007, 262, 0, 0, 0, 0, 32.7474, 31.1878, 87.249, 5.02438, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538698
(9508117, 59099, 1007, 262, 0, 0, 0, 0, 32.7795, 137.429, 83.7442, 6.10865, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538699
(9508118, 59100, 1007, 262, 0, 0, 0, 0, 32.8864, 111.43, 83.507, 3.69507, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538700
(9508119, 50485, 1007, 262, 0, 0, 0, 0, 32.8924, 31.151, 87.3319, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538701
(9508120, 59100, 1007, 262, 0, 0, 0, 0, 33.2784, 111.493, 83.5069, 2.14452, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538706
(9508121, 50485, 1007, 262, 0, 0, 0, 0, 33.4526, 31.9201, 87.2582, 2.78158, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538708
(9508122, 50485, 1007, 262, 0, 0, 0, 0, 33.9173, 32.12, 87.2607, 0.757372, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538713
(9508123, 50485, 1007, 262, 0, 0, 0, 0, 34.0004, 31.5933, 87.2541, 2.92401, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538715
(9508124, 59100, 1007, 262, 0, 0, 0, 0, 34.2361, 4.98748, 70.9575, 2.94861, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538718
(9508125, 59100, 1007, 262, 0, 0, 0, 0, 34.5134, 112.553, 73.6823, 5.13302, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538721
(9508126, 59100, 1007, 262, 0, 0, 0, 0, 34.8315, 117.718, 83.5127, 3.77901, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538727
(9508127, 59099, 1007, 262, 0, 0, 0, 0, 35.4132, -19.8785, 83.2086, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538734
(9508128, 59100, 1007, 262, 0, 0, 0, 0, 35.4854, 112.042, 73.6823, 4.68358, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538735
(9508129, 59099, 1007, 262, 0, 0, 0, 0, 35.6771, 0.145833, 72.5454, 0.925025, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538736
(9508130, 59099, 1007, 262, 0, 0, 0, 0, 36.1076, 140.247, 83.5961, 2.1293, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538744
(9508131, 59100, 1007, 262, 0, 0, 0, 0, 36.2277, 110.82, 73.6823, 4.69065, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538745
(9508132, 59100, 1007, 262, 0, 0, 0, 0, 36.2484, 105.148, 83.5242, 2.89415, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538746
(9508133, 59099, 1007, 262, 0, 0, 0, 0, 36.2899, -5.3125, 72.8483, 3.94444, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538747
(9508134, 59100, 1007, 262, 0, 0, 0, 0, 36.2994, 109.136, 83.5133, 3.42156, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538748
(9508135, 59100, 1007, 262, 0, 0, 0, 0, 36.3984, 19.9151, 70.9575, 0.483218, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538749
(9508136, 59099, 1007, 262, 0, 0, 0, 0, 36.5399, 18.4288, 87.337, 5.02655, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538751
(9508137, 59100, 1007, 262, 0, 0, 0, 0, 36.6362, 5.15724, 70.9575, 4.98168, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538752
(9508138, 59100, 1007, 262, 0, 0, 0, 0, 37.3005, 115.723, 83.5127, 1.08762, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538758
(9508139, 59100, 1007, 262, 0, 0, 0, 0, 37.4557, 108.804, 83.5142, 2.75184, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538761
(9508140, 59100, 1007, 262, 0, 0, 0, 0, 37.6467, 114.968, 83.5127, 3.20832, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 538763
(9508141, 59100, 1007, 262, 0, 0, 0, 0, 38.2145, -12.295, 83.5127, 3.32405, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538765
(9508142, 59099, 1007, 262, 0, 0, 0, 0, 38.5208, 115.205, 73.7656, 2.47837, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538767
(9508143, 59099, 1007, 262, 0, 0, 0, 0, 38.5312, 137.476, 83.5961, 4.29351, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538768
(9508144, 59100, 1007, 262, 0, 0, 0, 0, 39.0471, 94.1733, 73.6823, 2.99682, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538773
(9508145, 59099, 1007, 262, 0, 0, 0, 0, 39.3316, 101.34, 73.7656, 2.1293, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538777
(9508146, 59100, 1007, 262, 0, 0, 0, 0, 40.0501, -2.42814, 70.9575, 2.51329, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538783
(9508147, 59100, 1007, 262, 0, 0, 0, 0, 40.0973, 95.4579, 73.6823, 3.803, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538784
(9508148, 59100, 1007, 262, 0, 0, 0, 0, 40.125, 94.2743, 73.7656, 5.2709, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538785
(9508149, 59100, 1007, 262, 0, 0, 0, 0, 41.3689, -8.00545, 70.9575, 3.92518, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538797
(9508150, 59099, 1007, 262, 0, 0, 0, 0, 41.5295, 0.272569, 72.5445, 6.00393, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538801
(9508151, 59100, 1007, 262, 0, 0, 0, 0, 41.8422, -3.44032, 83.5127, 1.09936, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538804
(9508152, 59100, 1007, 262, 0, 0, 0, 0, 41.9548, -18.3571, 83.5127, 4.7149, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538806
(9508153, 59100, 1007, 262, 0, 0, 0, 0, 42.1202, -2.7058, 70.9575, 0.535541, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538810
(9508154, 59100, 1007, 262, 0, 0, 0, 0, 42.1781, 106.116, 73.6823, 5.92105, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538813
(9508155, 59100, 1007, 262, 0, 0, 0, 0, 42.522, 101.003, 73.6823, 1.62361, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538822
(9508156, 59100, 1007, 262, 0, 0, 0, 0, 42.5892, -8.0984, 70.9575, 3.26364, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538823
(9508157, 59100, 1007, 262, 0, 0, 0, 0, 42.632, 99.5816, 73.7656, 2.72271, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538824
(9508158, 59100, 1007, 262, 0, 0, 0, 0, 42.8217, 103.299, 73.6823, 5.17103, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538828
(9508159, 59100, 1007, 262, 0, 0, 0, 0, 42.8715, 105.436, 73.7656, 6.23082, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538829
(9508160, 59100, 1007, 262, 0, 0, 0, 0, 42.926, -15.3716, 83.5127, 1.39513, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538831
(9508161, 59100, 1007, 262, 0, 0, 0, 0, 42.935, -5.89322, 83.5127, 5.96336, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538832
(9508162, 59100, 1007, 262, 0, 0, 0, 0, 43.679, -6.6173, 70.9575, 0.248269, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538834
(9508163, 59100, 1007, 262, 0, 0, 0, 0, 43.865, -1.45686, 70.9575, 0.621524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538835
(9508164, 50485, 1007, 262, 0, 0, 0, 0, 68.5521, 105.615, 101.111, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538837
(9508165, 50485, 1007, 262, 0, 0, 0, 0, 68.6397, 105.241, 101.024, 5.15971, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538839
(9508166, 50485, 1007, 262, 0, 0, 0, 0, 68.7512, 104.547, 101.024, 2.44756, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538841
(9508167, 50485, 1007, 262, 0, 0, 0, 0, 69.1485, 104.924, 101.024, 0.853582, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538842
(9508168, 50485, 1007, 262, 0, 0, 0, 0, 69.1774, 104.377, 101.024, 2.03807, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538843
(9508169, 50485, 1007, 262, 0, 0, 0, 0, 69.8965, 104.174, 101.024, 0.198871, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538844
(9508170, 50485, 1007, 262, 0, 0, 0, 0, 71.3819, 107.344, 101.109, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538845
(9508171, 50485, 1007, 262, 0, 0, 0, 0, 71.5955, 107.29, 101.026, 5.71346, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538846
(9508172, 50485, 1007, 262, 0, 0, 0, 0, 72.0201, 106.912, 101.026, 2.19823, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538847
(9508173, 50485, 1007, 262, 0, 0, 0, 0, 72.2768, 106.479, 101.026, 4.48042, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538848
(9508174, 50485, 1007, 262, 0, 0, 0, 0, 72.6452, 106.613, 101.026, 5.75866, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538849
(9508175, 50485, 1007, 262, 0, 0, 0, 0, 72.7791, 107.38, 101.026, 0.0259916, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538851
(9508176, 50485, 1007, 262, 0, 0, 0, 0, 76.9639, 60.4221, 87.0391, 1.98629, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538852
(9508177, 50485, 1007, 262, 0, 0, 0, 0, 77.8253, 61.5297, 87.0388, 4.65412, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538853
(9508178, 50485, 1007, 262, 0, 0, 0, 0, 78.2583, 60.9589, 87.0389, 4.07574, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538854
(9508179, 50485, 1007, 262, 0, 0, 0, 0, 78.4931, 59.8108, 87.1214, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538855
(9508180, 50485, 1007, 262, 0, 0, 0, 0, 78.5853, 58.8112, 87.0395, 4.80437, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538856
(9508181, 50485, 1007, 262, 0, 0, 0, 0, 78.7142, 59.2989, 87.0394, 0.549629, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538857
(9508182, 50485, 1007, 262, 0, 0, 0, 0, 79.1817, 61.8581, 87.0386, 3.84936, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538858
(9508183, 50485, 1007, 262, 0, 0, 0, 0, 79.2918, 62.7748, 87.0384, 5.11096, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538859
(9508184, 50485, 1007, 262, 0, 0, 0, 0, 79.5049, 62.8573, 87.0383, 3.00757, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538860
(9508185, 50485, 1007, 262, 0, 0, 0, 0, 79.5152, 63.5983, 87.0381, 5.59617, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538861
(9508186, 50485, 1007, 262, 0, 0, 0, 0, 79.8938, 62.8784, 87.0383, 2.06192, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538862
(9508187, 50485, 1007, 262, 0, 0, 0, 0, 80.1704, 62.7919, 87.0383, 4.76498, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538863
(9508188, 50485, 1007, 262, 0, 0, 0, 0, 80.5364, 59.8455, 87.0391, 4.51692, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538864
(9508189, 50485, 1007, 262, 0, 0, 0, 0, 80.9184, 62.6667, 87.1214, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538865
(9508190, 50485, 1007, 262, 0, 0, 0, 0, 81.0181, 59.2355, 87.0392, 5.29835, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538866
(9508191, 50485, 1007, 262, 0, 0, 0, 0, 81.2793, 59.0989, 87.0393, 5.06947, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538867
(9508192, 50485, 1007, 262, 0, 0, 0, 0, 81.374, 58.8262, 87.0393, 5.44255, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538868
(9508193, 50485, 1007, 262, 0, 0, 0, 0, 81.3821, 59.0403, 87.0393, 5.98548, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538869
(9508194, 50485, 1007, 262, 0, 0, 0, 0, 81.4543, 57.8516, 87.0396, 4.47893, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538870
(9508195, 50485, 1007, 262, 0, 0, 0, 0, 81.684, 58.8177, 87.1214, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538871
(9508196, 50485, 1007, 262, 0, 0, 0, 0, 93.3432, 89.5611, 100.938, 2.68723, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538872
(9508197, 50485, 1007, 262, 0, 0, 0, 0, 93.6875, 88.4688, 101.021, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538873
(9508198, 50485, 1007, 262, 0, 0, 0, 0, 93.8971, 89.1728, 100.938, 2.64481, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538874
(9508199, 50485, 1007, 262, 0, 0, 0, 0, 93.9358, 62.6354, 101.024, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538875
(9508200, 50485, 1007, 262, 0, 0, 0, 0, 93.9414, 88.8801, 100.938, 1.01781, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538876
(9508201, 50485, 1007, 262, 0, 0, 0, 0, 94.291, 62.618, 100.943, 3.51202, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538877
(9508202, 50485, 1007, 262, 0, 0, 0, 0, 94.3998, 63.5046, 100.94, 2.87672, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538878
(9508203, 50485, 1007, 262, 0, 0, 0, 0, 94.4028, 90.1969, 100.938, 1.77527, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538879
(9508204, 50485, 1007, 262, 0, 0, 0, 0, 94.4612, 62.3348, 100.944, 3.88861, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538880
(9508205, 50485, 1007, 262, 0, 0, 0, 0, 94.4876, 62.5723, 100.943, 3.70488, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538881
(9508206, 50485, 1007, 262, 0, 0, 0, 0, 94.6492, 90.1333, 100.938, 1.41625, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538882
(9508207, 50485, 1007, 262, 0, 0, 0, 0, 94.7526, 62.73, 100.943, 3.20306, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538884
(9508208, 50485, 1007, 262, 0, 0, 0, 0, 94.9665, 62.5271, 100.944, 5.89741, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538886
(9508209, 50485, 1007, 262, 0, 0, 0, 0, 95.0034, 88.6106, 100.938, 5.02782, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538887
(9508210, 50485, 1007, 262, 0, 0, 0, 0, 95.6488, 63.1781, 100.943, 3.46246, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538888
(9508211, 50485, 1007, 262, 0, 0, 0, 0, 95.8091, 62.597, 100.945, 2.17585, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538889
(9508212, 50485, 1007, 262, 0, 0, 0, 0, 96.7431, 61.2465, 101.032, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538890
(9508213, 50485, 1007, 262, 0, 0, 0, 0, 96.7951, 61.4562, 100.95, 0.890523, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538891
(9508214, 50485, 1007, 262, 0, 0, 0, 0, 97.1286, 61.2842, 100.951, 5.01213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538892
(9508215, 50485, 1007, 262, 0, 0, 0, 0, 97.8152, 62.3934, 100.948, 4.36292, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538893
(9508216, 50485, 1007, 262, 0, 0, 0, 0, 98.3773, 62.2519, 100.95, 0.55715, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538894
(9508217, 50485, 1007, 262, 0, 0, 0, 0, 98.4723, 61.8175, 100.951, 0.783381, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538895
(9508218, 50485, 1007, 262, 0, 0, 0, 0, 98.5654, 61.3599, 100.952, 6.1428, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538896
(9508219, 59613, 1007, 262, 0, 0, 0, 0, 102.806, 81.2014, 101.014, 0.0389344, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538898
(9508220, 50485, 1007, 262, 0, 0, 0, 0, 108.55, 93.2478, 102.49, 4.34525, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538899
(9508221, 59614, 1007, 262, 0, 0, 0, 0, 109.656, 102.054, 102.565, 1.60072, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538900
(9508222, 50485, 1007, 262, 0, 0, 0, 0, 109.701, 93.4482, 102.492, 3.95416, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538901
(9508223, 50485, 1007, 262, 0, 0, 0, 0, 110.186, 93.9601, 102.573, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538902
(9508224, 50485, 1007, 262, 0, 0, 0, 0, 110.205, 94.6345, 102.492, 1.54193, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538903
(9508225, 50485, 1007, 262, 0, 0, 0, 0, 110.244, 95.1001, 102.492, 1.51983, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538904
(9508226, 50485, 1007, 262, 0, 0, 0, 0, 110.531, 95.6867, 102.492, 4.51502, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538905
(9508227, 59614, 1007, 262, 0, 0, 0, 0, 110.545, 109.542, 102.565, 4.6592, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538906
(9508228, 59614, 1007, 262, 0, 0, 0, 0, 111.182, 101.955, 102.565, 1.58393, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538907
(9508229, 59614, 1007, 262, 0, 0, 0, 0, 112.254, 104.335, 102.565, 3.073, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538908
(9508230, 59614, 1007, 262, 0, 0, 0, 0, 112.281, 106.63, 102.565, 3.1247, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538909
(9508231, 59614, 1007, 262, 0, 0, 0, 0, 116.099, 94.2951, 103.895, 4.76004, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538910
(9508232, 59614, 1007, 262, 0, 0, 0, 0, 116.42, 87.4688, 103.895, 1.68367, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538911
(9508233, 50485, 1007, 262, 0, 0, 0, 0, 116.785, 103.932, 103.815, 1.68636, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538912
(9508234, 50485, 1007, 262, 0, 0, 0, 0, 116.872, 100.591, 103.816, 1.41393, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538913
(9508235, 50485, 1007, 262, 0, 0, 0, 0, 116.972, 102.318, 103.901, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538914
(9508236, 50485, 1007, 262, 0, 0, 0, 0, 116.974, 102.117, 103.816, 1.53937, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538915
(9508237, 59614, 1007, 262, 0, 0, 0, 0, 117.556, 94.3108, 103.895, 4.68675, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538916
(9508238, 59614, 1007, 262, 0, 0, 0, 0, 119.155, 91.842, 103.895, 3.10052, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538917
(9508239, 59614, 1007, 262, 0, 0, 0, 0, 119.21, 89.6007, 103.895, 3.09173, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538918
(9508240, 59614, 1007, 262, 0, 0, 0, 0, 123.693, 102.58, 105.369, 1.24856, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538920
(9508241, 59614, 1007, 262, 0, 0, 0, 0, 124.127, 109.448, 105.368, 4.80013, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538921
(9508242, 59614, 1007, 262, 0, 0, 0, 0, 124.385, 70.9045, 105.369, 1.80193, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538922
(9508243, 59614, 1007, 262, 0, 0, 0, 0, 124.545, 78.092, 105.37, 4.69693, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538923
(9508244, 59614, 1007, 262, 0, 0, 0, 0, 126.359, 102.752, 105.369, 2.05375, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538924
(9508245, 59614, 1007, 262, 0, 0, 0, 0, 126.898, 76.2986, 105.37, 3.14177, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538925
(9508246, 59614, 1007, 262, 0, 0, 0, 0, 126.976, 74.4774, 105.37, 3.16196, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538926
(9508247, 59614, 1007, 262, 0, 0, 0, 0, 127.08, 72.967, 105.369, 3.18945, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538927
(9508248, 59614, 1007, 262, 0, 0, 0, 0, 127.141, 104.571, 105.369, 2.96668, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538928
(9508249, 59614, 1007, 262, 0, 0, 0, 0, 127.2, 106.444, 105.369, 2.9339, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538929
(9508250, 59614, 1007, 262, 0, 0, 0, 0, 141.377, 108.182, 108.138, 2.67403, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538930
(9508251, 59614, 1007, 262, 0, 0, 0, 0, 142.516, 99.2986, 108.141, 3.53008, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538931
(9508252, 59614, 1007, 262, 0, 0, 0, 0, 143.378, 97.4583, 108.141, 3.56125, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538932
(9508253, 59614, 1007, 262, 0, 0, 0, 0, 146.429, 94.9913, 108.142, 5.20947, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538933
(9508254, 50485, 1007, 262, 0, 0, 0, 0, 146.604, 60.7476, 106.412, 0.386626, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538934
(9508255, 50485, 1007, 262, 0, 0, 0, 0, 146.712, 60.6591, 106.411, 6.22542, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538935
(9508256, 50485, 1007, 262, 0, 0, 0, 0, 146.88, 60.4917, 106.41, 3.50531, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538936
(9508257, 50485, 1007, 262, 0, 0, 0, 0, 147.276, 60.6424, 106.495, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538937
(9508258, 59614, 1007, 262, 0, 0, 0, 0, 148.677, 119.861, 108.136, 0.673298, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538938
(9508259, 59614, 1007, 262, 0, 0, 0, 0, 151.691, 110.368, 108.138, 5.89443, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538939
(9508260, 59614, 1007, 262, 0, 0, 0, 0, 152.01, 96.4792, 108.141, 5.94788, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538940
(9508261, 50485, 1007, 262, 0, 0, 0, 0, 152.984, 119.127, 108.136, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538941
(9508262, 50485, 1007, 262, 0, 0, 0, 0, 153.236, 119.184, 108.055, 0.113919, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538942
(9508263, 59614, 1007, 262, 0, 0, 0, 0, 153.826, 104.818, 108.14, 0.0136215, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538943
(9508264, 50485, 1007, 262, 0, 0, 0, 0, 153.858, 91.8217, 108.054, 1.70278, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538944
(9508265, 50485, 1007, 262, 0, 0, 0, 0, 154.09, 91.3021, 108.054, 5.14024, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538945
(9508266, 50485, 1007, 262, 0, 0, 0, 0, 154.165, 117.947, 108.055, 0.690524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538946
(9508267, 50485, 1007, 262, 0, 0, 0, 0, 154.365, 90.733, 108.054, 5.28524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538947
(9508268, 50485, 1007, 262, 0, 0, 0, 0, 154.439, 90.5573, 108.143, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538948
(9508269, 58917, 1007, 262, 0, 0, 0, 0, 156.951, 37.0295, 122.342, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538949
(9508270, 58917, 1007, 262, 0, 0, 0, 0, 157.602, 27.316, 122.478, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538950
(9508271, 50485, 1007, 262, 0, 0, 0, 0, 157.845, 23.5473, 119.226, 3.29297, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538951
(9508272, 50485, 1007, 262, 0, 0, 0, 0, 159.448, 23.1285, 119.309, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538961
(9508273, 50485, 1007, 262, 0, 0, 0, 0, 159.843, 23.9407, 119.226, 1.41958, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538962
(9508274, 58823, 1007, 262, 0, 0, 0, 0, 159.924, 32.7587, 119.226, 2.89725, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538963
(9508275, 58823, 1007, 262, 0, 0, 0, 0, 159.932, 27.898, 119.226, 1.57251, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538964
(9508276, 58823, 1007, 262, 0, 0, 0, 0, 159.934, 26.8958, 119.309, 3.18933, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538965
(9508277, 50485, 1007, 262, 0, 0, 0, 0, 160.107, 22.9736, 119.226, 5.40104, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538966
(9508278, 58823, 1007, 262, 0, 0, 0, 0, 160.189, 34.9184, 119.309, 3.51596, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538967
(9508279, 50485, 1007, 262, 0, 0, 0, 0, 160.527, 23.5718, 119.226, 5.40981, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538968
(9508280, 58757, 1007, 262, 0, 0, 0, 0, 160.84, 22.1996, 119.309, 4.60767, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538969
(9508281, 50485, 1007, 262, 0, 0, 0, 0, 160.902, 23.3962, 119.226, 0.627256, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538970
(9508282, 50485, 1007, 262, 0, 0, 0, 0, 160.929, 22.9161, 119.226, 5.684, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538971
(9508283, 58917, 1007, 262, 0, 0, 0, 0, 163.587, 10.6146, 121.497, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538972
(9508284, 58757, 1007, 262, 0, 0, 0, 0, 165.844, 25.4496, 119.309, 4.95674, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538973
(9508285, 58823, 1007, 262, 0, 0, 0, 0, 167.049, 34.1649, 119.309, 4.28693, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538974
(9508286, 59394, 1007, 262, 0, 0, 0, 0, 168.34, 98.934, 108.329, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538975
(9508287, 50485, 1007, 262, 0, 0, 0, 0, 170.064, 2.38368, 119.309, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538992
(9508288, 58917, 1007, 262, 0, 0, 0, 0, 170.174, -4.44792, 121.884, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538994
(9508289, 58757, 1007, 262, 0, 0, 0, 0, 170.33, -2.12153, 119.309, 4.51682, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538995
(9508290, 58823, 1007, 262, 0, 0, 0, 0, 170.403, 1.71875, 119.309, 1.54572, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538996
(9508291, 50485, 1007, 262, 0, 0, 0, 0, 170.533, 127.062, 113.223, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538997
(9508292, 50485, 1007, 262, 0, 0, 0, 0, 170.603, 127.384, 113.102, 5.98631, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538998
(9508293, 50485, 1007, 262, 0, 0, 0, 0, 170.841, 2.79556, 119.226, 3.16268, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 538999
(9508294, 50485, 1007, 262, 0, 0, 0, 0, 171.036, 169.093, 113.081, 3.93923, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539001
(9508295, 50485, 1007, 262, 0, 0, 0, 0, 171.046, 1.7128, 119.226, 4.15588, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539002
(9508296, 59368, 1007, 262, 0, 0, 0, 0, 171.128, 135.094, 113.163, 3.22886, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539003
(9508297, 50485, 1007, 262, 0, 0, 0, 0, 171.175, 168.594, 113.079, 2.1984, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539004
(9508298, 59368, 1007, 262, 0, 0, 0, 0, 171.271, 164.861, 113.125, 3.24631, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539005
(9508299, 50485, 1007, 262, 0, 0, 0, 0, 171.286, 169.349, 113.166, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539006
(9508300, 50485, 1007, 262, 0, 0, 0, 0, 171.319, 2.26724, 119.226, 6.19063, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539007
(9508301, 50485, 1007, 262, 0, 0, 0, 0, 171.32, 2.57291, 119.226, 0.149594, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539008
(9508302, 50485, 1007, 262, 0, 0, 0, 0, 171.35, 169.917, 113.089, 2.21798, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539009
(9508303, 59368, 1007, 262, 0, 0, 0, 0, 171.606, 137.927, 113.141, 3.90954, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539010
(9508304, 50485, 1007, 262, 0, 0, 0, 0, 171.632, 2.82225, 119.226, 1.63719, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539012
(9508305, 59368, 1007, 262, 0, 0, 0, 0, 171.651, 132.721, 113.181, 2.61799, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539013
(9508306, 58757, 1007, 262, 0, 0, 0, 0, 171.767, 6.22743, 119.309, 4.38078, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539014
(9508307, 50485, 1007, 262, 0, 0, 0, 0, 171.784, 3.13227, 119.226, 0.410588, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539015
(9508308, 50485, 1007, 262, 0, 0, 0, 0, 171.797, 127.178, 113.112, 2.81778, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539016
(9508309, 50485, 1007, 262, 0, 0, 0, 0, 171.988, 126.975, 113.114, 6.24043, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539017
(9508310, 50485, 1007, 262, 0, 0, 0, 0, 172.404, 130.283, 113.199, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539024
(9508311, 50485, 1007, 262, 0, 0, 0, 0, 173.109, 130.077, 113.111, 2.59851, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539036
(9508312, 50485, 1007, 262, 0, 0, 0, 0, 173.184, 129.901, 113.112, 3.09848, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539037
(9508313, 59368, 1007, 262, 0, 0, 0, 0, 173.308, 135.669, 113.09, 1.23166, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539038
(9508314, 50485, 1007, 262, 0, 0, 0, 0, 173.623, 127.772, 113.124, 2.23039, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539039
(9508315, 50485, 1007, 262, 0, 0, 0, 0, 173.696, 127.033, 113.224, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539040
(9508316, 50485, 1007, 262, 0, 0, 0, 0, 173.935, 127.021, 113.13, 3.27566, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539041
(9508317, 50485, 1007, 262, 0, 0, 0, 0, 174.15, 171.041, 113.115, 3.11264, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539042
(9508318, 50485, 1007, 262, 0, 0, 0, 0, 174.373, 169.987, 113.109, 3.74705, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539043
(9508319, 50485, 1007, 262, 0, 0, 0, 0, 174.69, 126.869, 113.136, 6.12005, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539044
(9508320, 50485, 1007, 262, 0, 0, 0, 0, 175.247, 170.974, 113.212, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539045
(9508321, 50485, 1007, 262, 0, 0, 0, 0, 175.496, 174.168, 113.144, 3.19724, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539047
(9508322, 50485, 1007, 262, 0, 0, 0, 0, 175.688, 172.722, 113.136, 4.86368, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539048
(9508323, 50485, 1007, 262, 0, 0, 0, 0, 176.324, 173.233, 113.144, 4.53699, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539049
(9508324, 50485, 1007, 262, 0, 0, 0, 0, 176.5, 174.224, 113.243, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539050
(9508325, 58822, 1007, 262, 0, 0, 0, 0, 176.936, 31.8659, 119.226, 1.573, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 539057
(9508326, 50485, 1007, 262, 0, 0, 0, 0, 177.219, 66.7014, 108.316, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539070
(9508327, 58917, 1007, 262, 0, 0, 0, 0, 177.66, -7.36632, 121.644, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539076
(9508328, 50485, 1007, 262, 0, 0, 0, 0, 177.861, 66.7387, 108.233, 1.25573, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539085
(9508329, 50485, 1007, 262, 0, 0, 0, 0, 178.546, 66.7936, 108.233, 4.94584, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539092
(9508330, 58757, 1007, 262, 0, 0, 0, 0, 179.839, -6.29688, 119.226, 3.12414, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539093
(9508331, 58757, 1007, 262, 0, 0, 0, 0, 180.752, -6.56802, 119.226, 2.85291, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539095
(9508332, 58757, 1007, 262, 0, 0, 0, 0, 183.651, -7.42914, 119.226, 2.85291, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539096
(9508333, 59359, 1007, 262, 0, 0, 0, 0, 184.503, 173.884, 113.313, 5.76132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539097
(9508334, 50485, 1007, 262, 0, 0, 0, 0, 186.012, 40.5666, 119.226, 3.03374, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539098
(9508335, 58823, 1007, 262, 0, 0, 0, 0, 187.745, 21.0868, 118.936, 0.000290817, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539099
(9508336, 50485, 1007, 262, 0, 0, 0, 0, 187.795, 40.727, 119.226, 0.360898, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539101
(9508337, 50485, 1007, 262, 0, 0, 0, 0, 187.797, 40.1493, 119.226, 3.67079, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539102
(9508338, 58823, 1007, 262, 0, 0, 0, 0, 190.515, -12.952, 119.226, 0.15454, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539120
(9508339, 58823, 1007, 262, 0, 0, 0, 0, 191.242, -14.4751, 119.237, 2.06017, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539121
(9508340, 58823, 1007, 262, 0, 0, 0, 0, 191.311, -12.8281, 119.226, 5.01497, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539122
(9508341, 58757, 1007, 262, 0, 0, 0, 0, 191.346, -9.71431, 119.226, 2.85291, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539123
(9508342, 50485, 1007, 262, 0, 0, 0, 0, 191.733, 38.2033, 119.226, 4.68873, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539124
(9508343, 50485, 1007, 262, 0, 0, 0, 0, 192.023, 39.0417, 119.309, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539125
(9508344, 58757, 1007, 262, 0, 0, 0, 0, 192.302, -9.99826, 119.226, 5.69362, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539127
(9508345, 58823, 1007, 262, 0, 0, 0, 0, 192.651, -17.1215, 119.309, 0.0174533, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539128
(9508346, 50485, 1007, 262, 0, 0, 0, 0, 192.959, 139.676, 113.261, 4.44432, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539130
(9508347, 50485, 1007, 262, 0, 0, 0, 0, 193.523, 141.757, 113.267, 1.67895, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539131
(9508348, 50485, 1007, 262, 0, 0, 0, 0, 193.532, 39.3188, 119.226, 1.98068, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539132
(9508349, 50485, 1007, 262, 0, 0, 0, 0, 193.585, 141.188, 113.396, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539137
(9508350, 50485, 1007, 262, 0, 0, 0, 0, 193.763, 140.243, 113.27, 4.87779, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539138
(9508351, 58917, 1007, 262, 0, 0, 0, 0, 194.688, -12.2569, 119.96, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539140
(9508352, 58757, 1007, 262, 0, 0, 0, 0, 194.792, -9.14062, 119.309, 4.2213, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539141
(9508353, 58822, 1007, 262, 0, 0, 0, 0, 195.332, 66.7587, 132.036, 1.5708, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539142
(9508354, 50485, 1007, 262, 0, 0, 0, 0, 196.585, 175.663, 113.397, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539157
(9508355, 50485, 1007, 262, 0, 0, 0, 0, 196.625, 175.549, 113.314, 1.59367, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539158
(9508356, 50485, 1007, 262, 0, 0, 0, 0, 196.777, 175.152, 113.314, 1.02896, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539159
(9508357, 50485, 1007, 262, 0, 0, 0, 0, 196.981, 143.45, 113.396, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539161
(9508358, 50485, 1007, 262, 0, 0, 0, 0, 197.001, 143.604, 113.313, 1.97059, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539162
(9508359, 50485, 1007, 262, 0, 0, 0, 0, 197.403, 140.969, 113.396, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539163
(9508360, 50485, 1007, 262, 0, 0, 0, 0, 197.434, 145.217, 113.313, 1.5715, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539164
(9508361, 50485, 1007, 262, 0, 0, 0, 0, 197.61, 141.334, 113.313, 4.23116, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539165
(9508362, 50485, 1007, 262, 0, 0, 0, 0, 197.643, 141.939, 113.313, 1.42397, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539166
(9508363, 50485, 1007, 262, 0, 0, 0, 0, 198.343, 142.706, 113.313, 5.82371, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539173
(9508364, 58823, 1007, 262, 0, 0, 0, 0, 200.252, -10.0469, 119.309, 5.0063, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539174
(9508365, 58633, 1007, 262, 0, 0, 0, 0, 200.366, 6.07986, 119.309, 1.53589, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539175
(9508366, 58757, 1007, 262, 0, 0, 0, 0, 200.444, 30.0434, 118.924, 4.74601, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539176
(9508367, 58662, 1007, 262, 0, 0, 0, 0, 200.58, 21.2153, 118.566, 4.67748, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539179
(9508368, 58664, 1007, 262, 0, 0, 0, 0, 200.58, 21.2153, 118.566, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539180
(9508369, 50485, 1007, 262, 0, 0, 0, 0, 203.279, 158.819, 113.313, 4.6144, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539196
(9508370, 50485, 1007, 262, 0, 0, 0, 0, 203.333, 158.337, 113.313, 4.63077, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539197
(9508371, 50485, 1007, 262, 0, 0, 0, 0, 203.398, 160.024, 113.397, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539198
(9508372, 50485, 1007, 262, 0, 0, 0, 0, 203.427, 160.331, 113.313, 4.49375, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539199
(9508373, 59359, 1007, 262, 0, 0, 0, 0, 203.5, 135.354, 113.396, 1.38881, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539200
(9508374, 64562, 1007, 6, 0, 0, 0, 0, 203.549, 103.226, 132.036, 1.96896, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539201
(9508375, 59368, 1007, 262, 0, 0, 0, 0, 203.608, 157.842, 113.397, 2.02249, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539203
(9508376, 59368, 1007, 262, 0, 0, 0, 0, 203.608, 165.828, 113.313, 6.27244, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539204
(9508377, 58822, 1007, 262, 0, 0, 0, 0, 205.469, 66.6302, 132.036, 1.5708, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539217
(9508378, 58823, 1007, 262, 0, 0, 0, 0, 205.797, -17.0451, 119.309, 2.94961, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539219
(9508379, 58917, 1007, 262, 0, 0, 0, 0, 207.479, -13.9375, 122.544, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539220
(9508380, 50485, 1007, 262, 0, 0, 0, 0, 208.628, -35.6024, 119.327, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539222
(9508381, 50485, 1007, 262, 0, 0, 0, 0, 208.684, -36.1874, 119.244, 4.45505, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539230
(9508382, 50485, 1007, 262, 0, 0, 0, 0, 208.699, -35.7772, 119.244, 1.36536, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539231
(9508383, 50485, 1007, 262, 0, 0, 0, 0, 209.136, -34.5668, 119.244, 1.50172, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539232
(9508384, 50485, 1007, 262, 0, 0, 0, 0, 209.288, -35.5793, 119.244, 0.58569, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539233
(9508385, 50485, 1007, 262, 0, 0, 0, 0, 209.451, -35.7085, 119.244, 3.49192, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539234
(9508386, 50485, 1007, 262, 0, 0, 0, 0, 209.726, 75.1443, 131.953, 4.69351, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539241
(9508387, 50485, 1007, 262, 0, 0, 0, 0, 209.764, 77.1337, 132.036, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539242
(9508388, 50485, 1007, 262, 0, 0, 0, 0, 209.816, 77.7148, 131.953, 4.46133, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539243
(9508389, 50485, 1007, 262, 0, 0, 0, 0, 209.877, 129.997, 113.39, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539249
(9508390, 50485, 1007, 262, 0, 0, 0, 0, 210.007, 130.456, 113.305, 3.97128, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539250
(9508391, 50485, 1007, 262, 0, 0, 0, 0, 210.621, 131.33, 113.301, 4.82033, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539251
(9508392, 50485, 1007, 262, 0, 0, 0, 0, 211.274, 130.626, 113.297, 5.19206, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539259
(9508393, 50485, 1007, 262, 0, 0, 0, 0, 211.653, 65.753, 131.953, 4.93408, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539260
(9508394, 50485, 1007, 262, 0, 0, 0, 0, 211.967, 125.67, 113.279, 3.07243, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539266
(9508395, 50485, 1007, 262, 0, 0, 0, 0, 212.641, 125.439, 113.269, 3.2712, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539271
(9508396, 58823, 1007, 262, 0, 0, 0, 0, 212.641, 21.4045, 118.989, 3.11733, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539272
(9508397, 50485, 1007, 262, 0, 0, 0, 0, 212.975, 125.654, 113.273, 3.83572, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539274
(9508398, 59368, 1007, 262, 0, 0, 0, 0, 213.316, 131.234, 113.248, 5.49779, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539275
(9508399, 59368, 1007, 262, 0, 0, 0, 0, 213.623, 170.354, 113.241, 0.907571, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539276
(9508400, 50485, 1007, 262, 0, 0, 0, 0, 213.639, 125.569, 113.323, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539277
(9508401, 59368, 1007, 262, 0, 0, 0, 0, 215.497, 131.349, 113.269, 3.9214, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539297
(9508402, 59368, 1007, 262, 0, 0, 0, 0, 215.701, 128.762, 113.241, 2.35619, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539298
(9508403, 59368, 1007, 262, 0, 0, 0, 0, 215.988, 172.569, 113.241, 4.24115, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539299
(9508404, 59394, 1007, 262, 0, 0, 0, 0, 216.823, 71.3412, 108.294, 2.50546, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539300
(9508405, 59394, 1007, 262, 0, 0, 0, 0, 216.958, 71.3914, 108.305, 2.31985, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539305
(9508406, 58822, 1007, 262, 0, 0, 0, 0, 221.456, 11.8262, 119.235, 1.5963, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 539343
(9508407, 58917, 1007, 262, 0, 0, 0, 0, 223.299, -10.8455, 123.282, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539352
(9508408, 59368, 1007, 262, 0, 0, 0, 0, 224.014, 175.158, 113.241, 1.81514, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539353
(9508409, 59368, 1007, 262, 0, 0, 0, 0, 224.195, 130.899, 113.212, 4.70553, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539354
(9508410, 59368, 1007, 262, 0, 0, 0, 0, 224.251, 139.068, 113.212, 4.70553, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539355
(9508411, 58823, 1007, 262, 0, 0, 0, 0, 225.394, -1.48611, 119.309, 5.07861, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539356
(9508412, 58917, 1007, 262, 0, 0, 0, 0, 226.472, -4.5191, 120.257, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539358
(9508413, 58757, 1007, 262, 0, 0, 0, 0, 228.16, -2.72743, 119.309, 3.33358, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539359
(9508414, 58823, 1007, 262, 0, 0, 0, 0, 228.855, 9.84263, 119.228, 1.42241, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539366
(9508415, 59368, 1007, 262, 0, 0, 0, 0, 229.205, 134.201, 113.241, 0.0872665, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539368
(9508416, 50485, 1007, 262, 0, 0, 0, 0, 229.559, 127.986, 113.177, 4.78475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539376
(9508417, 50485, 1007, 262, 0, 0, 0, 0, 229.806, 127.366, 113.241, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539389
(9508418, 50485, 1007, 262, 0, 0, 0, 0, 229.87, 128.598, 113.175, 5.76265, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539391
(9508419, 50485, 1007, 262, 0, 0, 0, 0, 230.246, 172.082, 113.173, 1.07628, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539400
(9508420, 50485, 1007, 262, 0, 0, 0, 0, 230.253, 172.333, 113.256, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539401
(9508421, 50485, 1007, 262, 0, 0, 0, 0, 230.631, 173.269, 113.17, 1.18714, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539412
(9508422, 59369, 1007, 260, 0, 0, 0, 0, 230.898, 152.122, 113.252, 6.20227, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539413
(9508423, 58757, 1007, 262, 0, 0, 0, 0, 231.038, 5.62674, 119.309, 5.46288, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539420
(9508424, 50485, 1007, 262, 0, 0, 0, 0, 231.125, 171.996, 113.167, 5.95201, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539421
(9508425, 58823, 1007, 262, 0, 0, 0, 0, 232.66, 26.5087, 119.326, 5.02224, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539434
(9508426, 58823, 1007, 262, 0, 0, 0, 0, 232.755, 12.8004, 119.33, 5.044, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539435
(9508427, 58917, 1007, 262, 0, 0, 0, 0, 233.427, 10.8038, 122.684, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539444
(9508428, 59359, 1007, 262, 0, 0, 0, 0, 233.696, 152.238, 113.247, 0.0943888, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539445
(9508429, 50485, 1007, 262, 0, 0, 0, 0, 234.79, 138.877, 113.255, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539446
(9508430, 50485, 1007, 262, 0, 0, 0, 0, 234.871, 139.052, 113.163, 1.19337, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539447
(9508431, 58823, 1007, 262, 0, 0, 0, 0, 235.41, 35.0382, 119.315, 5.05579, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539448
(9508432, 50485, 1007, 262, 0, 0, 0, 0, 235.455, 140.309, 113.165, 4.58898, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539449
(9508433, 50485, 1007, 262, 0, 0, 0, 0, 235.862, 140.495, 113.166, 6.21866, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539450
(9508434, 58757, 1007, 262, 0, 0, 0, 0, 237.476, 23.6129, 119.323, 4.60767, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539466
(9508435, 50485, 1007, 262, 0, 0, 0, 0, 237.483, 12.7365, 119.233, 3.10071, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539467
(9508436, 50485, 1007, 262, 0, 0, 0, 0, 237.681, 21.9861, 119.327, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539468
(9508437, 50485, 1007, 262, 0, 0, 0, 0, 237.717, 23.2507, 119.244, 1.81828, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539469
(9508438, 50485, 1007, 262, 0, 0, 0, 0, 237.933, 22.5521, 119.245, 5.48326, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539470
(9508439, 50485, 1007, 262, 0, 0, 0, 0, 238.081, 22.3539, 119.245, 4.87316, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539476
(9508440, 50485, 1007, 262, 0, 0, 0, 0, 238.096, 22.5311, 119.245, 4.08199, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539477
(9508441, 50485, 1007, 262, 0, 0, 0, 0, 238.272, 22.6514, 119.245, 3.15863, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539478
(9508442, 50485, 1007, 262, 0, 0, 0, 0, 238.297, 12.7153, 119.233, 3.48406, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539479
(9508443, 50485, 1007, 262, 0, 0, 0, 0, 238.386, 12.2067, 119.232, 5.08067, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539480
(9508444, 50485, 1007, 262, 0, 0, 0, 0, 238.568, 12.2812, 119.232, 3.83132, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539481
(9508445, 59368, 1007, 262, 0, 0, 0, 0, 238.599, 161.62, 113.248, 2.32129, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539482
(9508446, 50485, 1007, 262, 0, 0, 0, 0, 238.693, 12.73, 119.233, 3.28524, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539484
(9508447, 50485, 1007, 262, 0, 0, 0, 0, 238.699, 22.4625, 119.245, 0.563998, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539485
(9508448, 58822, 1007, 262, 0, 0, 0, 0, 239.024, -43.6706, 116.081, 3.13347, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 539486
(9508449, 50485, 1007, 262, 0, 0, 0, 0, 239.083, 12.5931, 119.233, 6.1815, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539487
(9508450, 50485, 1007, 262, 0, 0, 0, 0, 239.193, 50.838, 119.227, 1.99978, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539488
(9508451, 50485, 1007, 262, 0, 0, 0, 0, 239.323, 12.8212, 119.321, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539489
(9508452, 50485, 1007, 262, 0, 0, 0, 0, 240.314, 28.2145, 119.239, 5.26259, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539491
(9508453, 59193, 1007, 262, 0, 0, 0, 0, 240.418, 99.8247, 113.574, 6.21337, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539492
(9508454, 58757, 1007, 262, 0, 0, 0, 0, 240.469, 39.6875, 119.313, 0.896803, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539493
(9508455, 59193, 1007, 262, 0, 0, 0, 0, 240.578, 80.1441, 113.574, 6.24828, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539494
(9508456, 50485, 1007, 262, 0, 0, 0, 0, 240.583, 49.5573, 119.31, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539495
(9508457, 59193, 1007, 262, 0, 0, 0, 0, 240.609, 118.087, 113.574, 6.23082, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539496
(9508458, 59368, 1007, 262, 0, 0, 0, 0, 240.641, 140.764, 113.251, 6.19592, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539498
(9508459, 58917, 1007, 262, 0, 0, 0, 0, 240.688, 28.8212, 122.6, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539500
(9508460, 50485, 1007, 262, 0, 0, 0, 0, 240.958, 26.6026, 119.24, 3.88154, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539501
(9508461, 50485, 1007, 262, 0, 0, 0, 0, 241.127, 26.4132, 119.32, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539502
(9508462, 50485, 1007, 262, 0, 0, 0, 0, 241.309, 26.4586, 119.24, 5.06379, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539503
(9508463, 58757, 1007, 262, 0, 0, 0, 0, 241.906, 30.8108, 119.309, 4.60767, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539512
(9508464, 50485, 1007, 262, 0, 0, 0, 0, 241.999, 27.5559, 119.238, 0.0970755, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539513
(9508465, 50485, 1007, 262, 0, 0, 0, 0, 242.312, 25.5838, 119.24, 0.203276, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539514
(9508466, 50485, 1007, 262, 0, 0, 0, 0, 242.689, 26.6658, 119.239, 0.418121, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539515
(9508467, 59304, 1007, 262, 0, 0, 0, 0, 245.012, 81.7483, 113.481, 1.98968, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539530
(9508468, 59368, 1007, 262, 0, 0, 0, 0, 246.17, 140.238, 113.263, 3.07178, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539532
(9508469, 59316, 1007, 262, 0, 0, 0, 0, 246.26, 118.002, 113.809, 0.0207071, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539533
(9508470, 59316, 1007, 262, 0, 0, 0, 0, 246.319, 80.467, 113.808, 6.27411, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539534
(9508471, 59316, 1007, 262, 0, 0, 0, 0, 246.41, 99.8733, 113.812, 6.28311, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539535
(9508472, 45979, 1007, 262, 0, 0, 0, 0, 246.42, 118.182, 113.815, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539536
(9508473, 45979, 1007, 262, 0, 0, 0, 0, 246.512, 99.4271, 113.806, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539537
(9508474, 45979, 1007, 262, 0, 0, 0, 0, 246.609, 80.526, 113.811, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539538
(9508475, 59304, 1007, 262, 0, 0, 0, 0, 247.191, 120.835, 113.326, 0.15708, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539539
(9508476, 59304, 1007, 262, 0, 0, 0, 0, 247.851, 97.4323, 113.425, 4.97419, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539540
(9508477, 58822, 1007, 262, 0, 0, 0, 0, 256.794, -43.6136, 113.432, 3.13344, 7200, 0, 0, 1, 0, 2, 0, 0, 0), -- LoA 539553
(9508478, 54020, 1007, 262, 0, 0, 0, 0, 258.574, 101.518, 115.346, 3.93489, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539562
(9508479, 54020, 1007, 262, 0, 0, 0, 0, 258.688, 99.8263, 118.853, 4.34877, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539563
(9508480, 54020, 1007, 262, 0, 0, 0, 0, 259.122, 101.345, 116.373, 0.703563, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539565
(9508481, 54020, 1007, 262, 0, 0, 0, 0, 259.298, 96.6788, 114.489, 2.30894, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539566
(9508482, 59503, 1007, 262, 0, 0, 0, 0, 259.528, -14.0746, 113.492, 1.35239, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539570
(9508483, 59368, 1007, 262, 0, 0, 0, 0, 259.988, 162.764, 113.363, 1.71042, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539573
(9508484, 59501, 1007, 262, 0, 0, 0, 0, 260.799, 9.63368, 113.492, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539579
(9508485, 54020, 1007, 262, 0, 0, 0, 0, 261.039, 101.717, 114.489, 0.170095, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539582
(9508486, 59200, 1007, 262, 0, 0, 0, 0, 261.351, 98.8924, 113.572, 1.57661, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539587
(9508487, 54020, 1007, 262, 0, 0, 0, 0, 261.396, 96.5728, 115.346, 4.69644, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539588
(9508488, 54020, 1007, 262, 0, 0, 0, 0, 261.404, 95.8506, 117.282, 4.75872, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539589
(9508489, 59153, 1007, 262, 0, 0, 0, 0, 261.413, 99.6267, 113.572, 4.64258, 86400, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539590
(9508490, 54020, 1007, 262, 0, 0, 0, 0, 261.462, 98.7517, 114.326, 4.76475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539593
(9508491, 54020, 1007, 262, 0, 0, 0, 0, 261.462, 98.7517, 115.346, 4.76475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539594
(9508492, 54020, 1007, 262, 0, 0, 0, 0, 261.462, 98.7517, 116.373, 4.76475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539595
(9508493, 54020, 1007, 262, 0, 0, 0, 0, 261.462, 98.7517, 117.282, 4.76475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539596
(9508494, 54020, 1007, 262, 0, 0, 0, 0, 261.462, 98.7517, 118.853, 4.76475, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539597
(9508495, 54020, 1007, 262, 0, 0, 0, 0, 261.463, 98.3611, 117.282, 4.6875, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539598
(9508496, 54020, 1007, 262, 0, 0, 0, 0, 261.464, 98.3778, 115.346, 4.68892, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539599
(9508497, 54020, 1007, 262, 0, 0, 0, 0, 261.464, 98.492, 118.853, 4.69482, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539601
(9508498, 54020, 1007, 262, 0, 0, 0, 0, 261.466, 98.5129, 115.346, 4.70403, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539603
(9508499, 54020, 1007, 262, 0, 0, 0, 0, 261.475, 98.5884, 114.333, 4.81882, 7200, 0, 0, 1, 0, 0, 0, 0, 0); -- LoA 539604
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9508500, 54020, 1007, 262, 0, 0, 0, 0, 261.486, 98.4965, 118.182, 4.83086, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539606
(9508501, 54020, 1007, 262, 0, 0, 0, 0, 261.497, 98.4067, 116.373, 4.84108, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539608
(9508502, 54020, 1007, 262, 0, 0, 0, 0, 261.499, 98.4, 114.342, 4.84502, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539609
(9508503, 54020, 1007, 262, 0, 0, 0, 0, 261.503, 98.3554, 118.181, 4.84557, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539611
(9508504, 54020, 1007, 262, 0, 0, 0, 0, 261.736, 96.5261, 114.442, 4.76012, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539613
(9508505, 54020, 1007, 262, 0, 0, 0, 0, 261.752, 96.5536, 118.182, 4.80992, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539614
(9508506, 54020, 1007, 262, 0, 0, 0, 0, 261.753, 96.5426, 116.373, 4.80888, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539615
(9508507, 54020, 1007, 262, 0, 0, 0, 0, 261.787, 95.8866, 118.182, 4.69976, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539618
(9508508, 54020, 1007, 262, 0, 0, 0, 0, 261.914, 102.71, 117.282, 2.99457, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539619
(9508509, 54020, 1007, 262, 0, 0, 0, 0, 262.634, 102.018, 118.182, 5.93963, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539622
(9508510, 54020, 1007, 262, 0, 0, 0, 0, 263.064, 95.0201, 115.346, 0.509863, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539626
(9508511, 54020, 1007, 262, 0, 0, 0, 0, 263.064, 95.0201, 117.282, 0.509863, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539627
(9508512, 59503, 1007, 262, 0, 0, 0, 0, 263.08, 12.5504, 113.492, 1.80321, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539628
(9508513, 59503, 1007, 262, 0, 0, 0, 0, 263.179, -16.0047, 113.409, 3.75794, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539630
(9508514, 54020, 1007, 262, 0, 0, 0, 0, 263.844, 96.935, 118.853, 0.946581, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539633
(9508515, 59503, 1007, 262, 0, 0, 0, 0, 263.894, -15.4983, 113.492, 1.0571, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539635
(9508516, 59503, 1007, 262, 0, 0, 0, 0, 264.494, 12.5203, 113.409, 6.26194, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539636
(9508517, 50485, 1007, 262, 0, 0, 0, 0, 265.083, -49.117, 113.432, 3.22581, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539637
(9508518, 50485, 1007, 262, 0, 0, 0, 0, 265.509, -48.3355, 113.433, 0.0725474, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539638
(9508519, 50485, 1007, 262, 0, 0, 0, 0, 265.752, 161.026, 113.305, 4.12589, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539639
(9508520, 50485, 1007, 262, 0, 0, 0, 0, 266.005, -48.7481, 113.433, 5.80242, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539640
(9508521, 50485, 1007, 262, 0, 0, 0, 0, 266.02, 160.508, 113.306, 4.70996, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539641
(9508522, 50485, 1007, 262, 0, 0, 0, 0, 266.024, 162.391, 113.382, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539642
(9508523, 50485, 1007, 262, 0, 0, 0, 0, 266.033, 161.507, 113.305, 4.72182, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539643
(9508524, 50485, 1007, 262, 0, 0, 0, 0, 266.391, -49.0097, 113.433, 5.6714, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539644
(9508525, 50485, 1007, 262, 0, 0, 0, 0, 266.651, -49.25, 113.433, 5.76312, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539645
(9508526, 59503, 1007, 262, 0, 0, 0, 0, 269.002, -23.026, 113.492, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539656
(9508527, 50485, 1007, 262, 0, 0, 0, 0, 272.01, 162.372, 113.383, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539665
(9508528, 50485, 1007, 262, 0, 0, 0, 0, 272.217, 142.262, 113.316, 2.97641, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539666
(9508529, 50485, 1007, 262, 0, 0, 0, 0, 272.324, 161.23, 113.32, 4.99733, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539667
(9508530, 50485, 1007, 262, 0, 0, 0, 0, 273.009, 140.969, 113.317, 0.787627, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539670
(9508531, 59503, 1007, 262, 0, 0, 0, 0, 273.089, -19.6024, 113.492, 2.31693, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539673
(9508532, 59467, 1007, 262, 0, 0, 0, 0, 273.21, -1.9566, 113.492, 6.0912, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539674
(9508533, 50485, 1007, 262, 0, 0, 0, 0, 273.34, 160.953, 113.321, 2.46183, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539676
(9508534, 50485, 1007, 262, 0, 0, 0, 0, 273.517, 141.052, 113.385, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539677
(9508535, 59304, 1007, 262, 0, 0, 0, 0, 275.323, 98.5087, 113.439, 2.86234, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539681
(9508536, 59304, 1007, 262, 0, 0, 0, 0, 275.54, 120.674, 113.381, 1.64061, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539682
(9508537, 50485, 1007, 262, 0, 0, 0, 0, 276.319, 146.163, 113.319, 1.07934, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539683
(9508538, 59467, 1007, 262, 0, 0, 0, 0, 276.67, 29.9028, 113.492, 6.12646, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539684
(9508539, 45979, 1007, 262, 0, 0, 0, 0, 276.672, 99.8472, 113.809, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539686
(9508540, 59316, 1007, 262, 0, 0, 0, 0, 276.71, 99.7465, 113.808, 3.13334, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539687
(9508541, 59316, 1007, 262, 0, 0, 0, 0, 276.731, 118.252, 113.815, 3.13722, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539688
(9508542, 45979, 1007, 262, 0, 0, 0, 0, 276.75, 118.2, 113.814, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539693
(9508543, 50485, 1007, 262, 0, 0, 0, 0, 276.809, 146.068, 113.32, 4.16948, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539694
(9508544, 59316, 1007, 262, 0, 0, 0, 0, 276.879, 80.6406, 113.813, 3.16216, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539696
(9508545, 50485, 1007, 262, 0, 0, 0, 0, 276.936, 146.439, 113.32, 1.24145, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539697
(9508546, 45979, 1007, 262, 0, 0, 0, 0, 277.188, 80.7396, 113.818, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539702
(9508547, 59304, 1007, 262, 0, 0, 0, 0, 277.387, 78.2448, 113.498, 4.57276, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539703
(9508548, 50485, 1007, 262, 0, 0, 0, 0, 277.905, 158.704, 113.323, 2.30451, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539704
(9508549, 50485, 1007, 262, 0, 0, 0, 0, 277.961, 155.528, 113.322, 4.62902, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539705
(9508550, 50485, 1007, 262, 0, 0, 0, 0, 278.062, 158.554, 113.391, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539706
(9508551, 50485, 1007, 262, 0, 0, 0, 0, 278.144, 157.007, 113.322, 1.61632, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539707
(9508552, 50485, 1007, 262, 0, 0, 0, 0, 278.189, 156.014, 113.391, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539708
(9508553, 50485, 1007, 262, 0, 0, 0, 0, 278.238, 155.537, 113.322, 4.20866, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539709
(9508554, 50485, 1007, 262, 0, 0, 0, 0, 278.695, 158.82, 113.323, 5.81599, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539710
(9508555, 50485, 1007, 262, 0, 0, 0, 0, 278.89, 147.528, 113.321, 2.79782, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539712
(9508556, 50485, 1007, 262, 0, 0, 0, 0, 279.227, 148.252, 113.321, 1.18069, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539713
(9508557, 50485, 1007, 262, 0, 0, 0, 0, 279.905, 146.92, 113.393, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539730
(9508558, 50485, 1007, 262, 0, 0, 0, 0, 279.974, 148.569, 113.322, 1.08189, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539732
(9508559, 50485, 1007, 262, 0, 0, 0, 0, 280.05, 155.841, 113.323, 5.90273, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539733
(9508560, 50485, 1007, 262, 0, 0, 0, 0, 280.29, 155.024, 113.323, 0.291464, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539734
(9508561, 59481, 1007, 262, 0, 0, 0, 0, 280.345, -2.2066, 113.492, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539737
(9508562, 59503, 1007, 262, 0, 0, 0, 0, 281.395, -22.3001, 113.409, 4.39139, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539745
(9508563, 59193, 1007, 262, 0, 0, 0, 0, 282.309, 117.642, 113.574, 3.15905, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539748
(9508564, 59193, 1007, 262, 0, 0, 0, 0, 282.5, 99.6076, 113.574, 3.21141, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539750
(9508565, 59481, 1007, 262, 0, 0, 0, 0, 282.523, 29.6979, 113.492, 0.0352634, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539752
(9508566, 59193, 1007, 262, 0, 0, 0, 0, 282.589, 80.5747, 113.574, 3.14159, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539753
(9508567, 59467, 1007, 262, 0, 0, 0, 0, 282.865, 24.7205, 113.492, 1.58254, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539754
(9508568, 59503, 1007, 262, 0, 0, 0, 0, 283.843, -20.6798, 113.409, 0.230167, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539756
(9508569, 50485, 1007, 262, 0, 0, 0, 0, 286.423, 90.7448, 113.493, 6.21855, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539768
(9508570, 50485, 1007, 262, 0, 0, 0, 0, 286.486, 90.4948, 113.576, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539769
(9508571, 50485, 1007, 262, 0, 0, 0, 0, 286.545, 89.6208, 113.493, 6.0679, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539770
(9508572, 59501, 1007, 262, 0, 0, 0, 0, 287.102, -21.3285, 113.409, 0.289084, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539771
(9508573, 59467, 1007, 262, 0, 0, 0, 0, 288.038, -2.13542, 113.492, 3.22886, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539773
(9508574, 59467, 1007, 262, 0, 0, 0, 0, 289.231, 29.8646, 113.492, 3.04709, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539775
(9508575, 59503, 1007, 262, 0, 0, 0, 0, 293.427, -17.8464, 113.409, 1.12143, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539779
(9508576, 59503, 1007, 262, 0, 0, 0, 0, 293.966, -20.9572, 113.409, 5.94606, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539780
(9508577, 59503, 1007, 262, 0, 0, 0, 0, 295.134, 20.4254, 113.493, 2.618, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539782
(9508578, 59503, 1007, 262, 0, 0, 0, 0, 296.496, -20.3633, 113.409, 1.75495, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539784
(9508579, 59503, 1007, 262, 0, 0, 0, 0, 297.62, 28.2691, 113.494, 1.31431, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539788
(9508580, 59503, 1007, 262, 0, 0, 0, 0, 298.154, -20.3413, 113.409, 1.18808, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539790
(9508581, 59501, 1007, 262, 0, 0, 0, 0, 299.787, 29.1219, 113.41, 1.51027, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539798
(9508582, 59503, 1007, 262, 0, 0, 0, 0, 300.016, -20.9514, 113.492, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539800
(9508583, 59503, 1007, 262, 0, 0, 0, 0, 301.797, 16.9826, 113.493, 3.96019, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539809
(9508584, 59503, 1007, 262, 0, 0, 0, 0, 302.198, -5.89819, 113.409, 2.19182, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539810
(9508585, 59503, 1007, 262, 0, 0, 0, 0, 302.894, -6.87153, 113.492, 3.99775, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539814
(9508586, 59503, 1007, 262, 0, 0, 0, 0, 302.919, 5.48914, 113.409, 5.97555, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539815
(9508587, 59503, 1007, 262, 0, 0, 0, 0, 303.625, -9.48307, 113.409, 0.128573, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539816
(9508588, 59503, 1007, 262, 0, 0, 0, 0, 304.814, 2.3125, 113.492, 1.11635, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539820
(9508589, 59503, 1007, 262, 0, 0, 0, 0, 304.895, 23.0749, 113.409, 1.49422, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539821
(9508590, 59503, 1007, 262, 0, 0, 0, 0, 305.405, 4.61077, 113.409, 3.49267, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539822
(9508591, 59503, 1007, 262, 0, 0, 0, 0, 307.29, 29.7292, 113.492, 0.480527, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539825
(9508592, 59503, 1007, 262, 0, 0, 0, 0, 307.721, -20.5037, 113.409, 4.14476, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539828
(9508593, 59503, 1007, 262, 0, 0, 0, 0, 308.011, -19.2607, 113.409, 2.21608, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539829
(9508594, 59503, 1007, 262, 0, 0, 0, 0, 309.077, 11.1356, 113.41, 4.8988, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539834
(9508595, 59501, 1007, 262, 0, 0, 0, 0, 309.295, 27.9988, 113.408, 4.30523, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539838
(9508596, 59503, 1007, 262, 0, 0, 0, 0, 309.425, -21.1389, 113.492, 0, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539840
(9508597, 59501, 1007, 262, 0, 0, 0, 0, 310.505, -2.09028, 113.492, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539850
(9508598, 59503, 1007, 262, 0, 0, 0, 0, 310.98, 2.62867, 113.409, 0.831639, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539854
(9508599, 59503, 1007, 262, 0, 0, 0, 0, 311.459, 34.1376, 113.408, 1.88513, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539856
(9508600, 59503, 1007, 262, 0, 0, 0, 0, 311.467, 18.4427, 113.492, 2.08443, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539858
(9508601, 58875, 1007, 262, 0, 0, 0, 0, 261.313, 118.796, 117.595, 4.74816, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539860
(9508602, 59503, 1007, 262, 0, 0, 0, 0, 311.563, 10.1493, 113.411, 2.67859, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539861
(9508603, 59503, 1007, 262, 0, 0, 0, 0, 311.58, -15.1088, 113.411, 4.53166, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539862
(9508604, 59503, 1007, 262, 0, 0, 0, 0, 311.911, -13.2951, 113.492, 0, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539864
(9508605, 59503, 1007, 262, 0, 0, 0, 0, 312.866, 2.4849, 113.409, 0.313612, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539870
(9508606, 59503, 1007, 262, 0, 0, 0, 0, 313.247, -15.3198, 113.411, 1.3414, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 539871
(9508607, 59503, 1007, 262, 0, 0, 0, 0, 313.898, 34.2645, 113.408, 0.139162, 7200, 5, 0, 1, 0, 1, 0, 0, 0), -- LoA 539873
(9508608, 53488, 1007, 4, 0, 0, 0, 0, 199.876, 125.346, 138.43, 4.77173, 7200, 0, 0, 1, 0, 0, 0, 0, 0), -- LoA 545107
(9508609, 59184, 1007, 262, 0, 0, 0, 0, 285.839, 52.7989, 113.409, 1.61332, 86400, 0, 0, 5269900, 30936, 0, 0, 0, 0), -- LoA 568972
(9508610, 59167, 1007, 2, 0, 0, 0, 0, 32.6548, 145.927, 73.8782, 4.69684, 7200, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 570418
(9508611, 59167, 1007, 2, 0, 0, 0, 0, -60.4878, 61.9793, 69.0579, 0.322179, 7200, 0, 0, 393941, 0, 0, 0, 0, 0), -- LoA 570419
(9508612, 59167, 1007, 2, 0, 0, 0, 0, 30.5216, -23.9382, 73.5354, 1.56311, 7200, 0, 0, 393941, 0, 0, 0, 0, 0); -- LoA 570420

DELETE FROM `gameobject` WHERE `guid` BETWEEN 9508000 AND 9508122;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(9508000, 210792, 1007, 262, 0, 0, 280.309, 69.8067, 113.53, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534494
(9508001, 211647, 1007, 262, 0, 0, 105.292, 77.4514, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534495
(9508002, 211669, 1007, 262, 0, 0, 104.575, 78.7483, 102.564, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534496
(9508003, 211648, 1007, 262, 0, 0, 105.88, 84.4688, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534497
(9508004, 211648, 1007, 262, 0, 0, 117.321, 75.0226, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534498
(9508005, 211647, 1007, 262, 0, 0, 116.569, 74.6007, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534499
(9508006, 211647, 1007, 262, 0, 0, 110.618, 73.6667, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534500
(9508007, 211649, 1007, 262, 0, 0, 104.531, 85.8524, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534501
(9508008, 211648, 1007, 262, 0, 0, 109.576, 90.0781, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534502
(9508009, 211648, 1007, 262, 0, 0, 105.644, 86.2812, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534503
(9508010, 211648, 1007, 262, 0, 0, 110.531, 91.1753, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534504
(9508011, 211648, 1007, 262, 0, 0, 105.505, 83.4948, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534505
(9508012, 211649, 1007, 262, 0, 0, 117.194, 73.2309, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534506
(9508013, 211648, 1007, 262, 0, 0, 105.464, 76.2483, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534507
(9508014, 211647, 1007, 262, 0, 0, 104.595, 76.7031, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534508
(9508015, 214279, 1007, 262, 0, 0, 219.703, -21.3507, 120.219, 2.61176, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534509
(9508016, 214278, 1007, 262, 0, 0, 316.385, -13.5434, 115.313, 2.48663, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534510
(9508017, 210793, 1007, 262, 0, 0, 280.309, 127.922, 113.53, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534511
(9508018, 214279, 1007, 262, 0, 0, 193.896, -10.092, 120.157, 1.69201, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534512
(9508019, 210791, 1007, 262, 0, 0, 241.804, 69.8067, 113.53, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534513
(9508020, 175747, 1007, 262, 0, 0, 218.259, 63.2969, 109.617, 2.56861, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534514
(9508021, 210794, 1007, 262, 0, 0, 241.804, 127.922, 113.53, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534515
(9508022, 211278, 1007, 262, 0, 0, 168.33, 98.9497, 108.246, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534516
(9508023, 212899, 1007, 262, 0, 0, 186.708, 125.464, 143.247, 0.0160105, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534517
(9508024, 214280, 1007, 262, 0, 0, 174.741, 167.734, 114.233, 0.115568, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534518
(9508025, 211648, 1007, 262, 0, 0, 125.422, 107.158, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534519
(9508026, 211648, 1007, 262, 0, 0, 124.116, 106.344, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534520
(9508027, 211647, 1007, 262, 0, 0, 124.076, 89.0903, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534521
(9508028, 211648, 1007, 262, 0, 0, 117.302, 104.174, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534522
(9508029, 211647, 1007, 262, 0, 0, 125.361, 92.2847, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534523
(9508030, 211648, 1007, 262, 0, 0, 117.616, 105.031, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534524
(9508031, 211648, 1007, 262, 0, 0, 117.72, 90.7274, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534525
(9508032, 211647, 1007, 262, 0, 0, 124.554, 75.309, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534526
(9508033, 211647, 1007, 262, 0, 0, 109.578, 106.924, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534527
(9508034, 214277, 1007, 262, 0, 0, 110.774, 103.906, 103.922, 5.44266, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534528
(9508035, 211670, 1007, 262, 0, 0, 104.575, 78.7483, 102.564, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534529
(9508036, 211260, 1007, 262, 0, 0, 90.8002, 101.564, 101.06, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 0), -- LoA 534532
(9508037, 210783, 1007, 262, 0, 0, 30.8193, 78.8017, 74.4523, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534537
(9508038, 210784, 1007, 262, 0, 0, 9.87102, 57.8554, 74.4162, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534538
(9508039, 211257, 1007, 262, 0, 0, 261.18, -28.0247, 113.289, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 0), -- LoA 534539
(9508040, 210787, 1007, 262, 0, 0, 2.10381, 57.8011, 87.1949, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534541
(9508041, 210789, 1007, 262, 0, 0, 60.2856, 58.8929, 87.1381, 0, 0, 0, 1, -0.0000000437114, 7200, 255, 0), -- LoA 534542
(9508042, 210785, 1007, 262, 0, 0, 31.1231, 86.7699, 87.1883, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534543
(9508043, 210788, 1007, 262, 0, 0, 30.8193, 34.2149, 74.4523, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534544
(9508044, 210786, 1007, 262, 0, 0, 30.7366, 29.4764, 87.1958, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534545
(9508045, 214178, 1007, 262, 0, 0, 268.22, 158.262, 113.299, 0.731384, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534546
(9508046, 211648, 1007, 262, 0, 0, 110.618, 73.6667, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534547
(9508047, 211649, 1007, 262, 0, 0, 117.321, 75.0226, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534548
(9508048, 211648, 1007, 262, 0, 0, 117.194, 73.2309, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534549
(9508049, 211649, 1007, 262, 0, 0, 116.569, 74.6007, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534550
(9508050, 214279, 1007, 262, 0, 0, 226.273, -2.92708, 120.178, 0.83384, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534551
(9508051, 214278, 1007, 262, 0, 0, 287.871, 9.80556, 115.313, 2.39775, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534552
(9508052, 214280, 1007, 262, 0, 0, 176.694, 122.339, 114.379, 0.797715, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534553
(9508053, 214277, 1007, 262, 0, 0, 153.182, 96.4635, 109.158, 1.91776, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534554
(9508054, 211649, 1007, 262, 0, 0, 124.116, 106.344, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534555
(9508055, 211648, 1007, 262, 0, 0, 125.361, 92.2847, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534556
(9508056, 211647, 1007, 262, 0, 0, 125.422, 107.158, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534557
(9508057, 211648, 1007, 262, 0, 0, 124.554, 75.309, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534558
(9508058, 211649, 1007, 262, 0, 0, 117.302, 104.174, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534559
(9508059, 211648, 1007, 262, 0, 0, 124.076, 89.0903, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534560
(9508060, 211648, 1007, 262, 0, 0, 104.595, 76.7031, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534561
(9508061, 211647, 1007, 262, 0, 0, 105.644, 86.2812, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534562
(9508062, 211648, 1007, 262, 0, 0, 105.292, 77.4514, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534563
(9508063, 211647, 1007, 262, 0, 0, 105.505, 83.4948, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534564
(9508064, 211259, 1007, 262, 0, 0, 200.494, 57.1439, 132.128, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534565
(9508065, 211262, 1007, 262, 0, 0, 261.289, 135.66, 113.289, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534566
(9508066, 210771, 1007, 262, 0, 0, 173.889, 77.3736, 108.32, 3.14159, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534567
(9508067, 211261, 1007, 262, 0, 0, 200.016, 124.353, 113.289, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 0), -- LoA 534568
(9508068, 210781, 1007, 262, 0, 0, 171.933, 98.9145, 108.653, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534569
(9508069, 211256, 1007, 262, 0, 0, 261.269, 61.0236, 113.289, 4.71239, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534570
(9508070, 211649, 1007, 262, 0, 0, 125.422, 107.158, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534571
(9508071, 214277, 1007, 262, 0, 0, 153.635, 120.08, 108.881, 4.5576, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534572
(9508072, 214280, 1007, 262, 0, 0, 210.971, 166.177, 114.22, 4.45336, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534573
(9508073, 211258, 1007, 262, 0, 0, 214.828, -26.6222, 119.299, 1.5708, 0, 0, 1, -0.0000000437114, 7200, 255, 1), -- LoA 534574
(9508074, 211649, 1007, 262, 0, 0, 117.72, 90.7274, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534575
(9508075, 211649, 1007, 262, 0, 0, 109.578, 106.924, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534576
(9508076, 211647, 1007, 262, 0, 0, 109.576, 90.0781, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534577
(9508077, 211647, 1007, 262, 0, 0, 110.531, 91.1753, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534578
(9508078, 211648, 1007, 262, 0, 0, 116.569, 74.6007, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534579
(9508079, 211647, 1007, 262, 0, 0, 117.194, 73.2309, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534580
(9508080, 211647, 1007, 262, 0, 0, 104.531, 85.8524, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534581
(9508081, 211649, 1007, 262, 0, 0, 105.644, 86.2812, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534582
(9508082, 211649, 1007, 262, 0, 0, 110.618, 73.6667, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534583
(9508083, 211647, 1007, 262, 0, 0, 105.88, 84.4688, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534584
(9508084, 214278, 1007, 262, 0, 0, 310.722, 58.7413, 115.307, 3.92893, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534585
(9508085, 211649, 1007, 262, 0, 0, 125.361, 92.2847, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534586
(9508086, 211649, 1007, 262, 0, 0, 117.616, 105.031, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534587
(9508087, 214279, 1007, 262, 0, 0, 240.764, 44.9323, 120.147, 1.69201, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534588
(9508088, 211648, 1007, 262, 0, 0, 109.578, 106.924, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534589
(9508089, 211647, 1007, 262, 0, 0, 117.72, 90.7274, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534590
(9508090, 211649, 1007, 262, 0, 0, 124.554, 75.309, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534591
(9508091, 214280, 1007, 262, 0, 0, 213.016, 119.304, 114.364, 1.04092, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534592
(9508092, 214277, 1007, 262, 0, 0, 125.554, 74.2569, 106.995, 5.77329, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534593
(9508093, 211647, 1007, 262, 0, 0, 117.321, 75.0226, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534594
(9508094, 214278, 1007, 262, 0, 0, 316.339, 19.7726, 115.313, 3.01587, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534595
(9508095, 211649, 1007, 262, 0, 0, 105.505, 83.4948, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534596
(9508096, 214277, 1007, 262, 0, 0, 117.769, 92.3125, 105.222, 1.17729, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534597
(9508097, 214279, 1007, 262, 0, 0, 211.925, 37.1441, 120.619, 4.37138, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534598
(9508098, 211649, 1007, 262, 0, 0, 110.531, 91.1753, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534599
(9508099, 211647, 1007, 262, 0, 0, 105.464, 76.2483, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534600
(9508100, 211648, 1007, 262, 0, 0, 104.531, 85.8524, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534601
(9508101, 211649, 1007, 262, 0, 0, 105.292, 77.4514, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534602
(9508102, 211649, 1007, 262, 0, 0, 105.88, 84.4688, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534603
(9508103, 214278, 1007, 262, 0, 0, 255.33, -0.522569, 115.313, 5.72346, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534604
(9508104, 211649, 1007, 262, 0, 0, 124.076, 89.0903, 106.911, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534605
(9508105, 211277, 1007, 262, 0, 0, 168.33, 98.9497, 108.246, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534606
(9508106, 214106, 1007, 262, 0, 0, 219.74, 175.431, 114.258, 4.45336, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534607
(9508107, 211647, 1007, 262, 0, 0, 117.616, 105.031, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534608
(9508108, 211649, 1007, 262, 0, 0, 109.576, 90.0781, 103.851, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534609
(9508109, 214101, 1007, 262, 0, 0, 193.896, -10.092, 120.157, 1.69201, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534610
(9508110, 214107, 1007, 262, 0, 0, 104.483, 83.4271, 102.592, 4.08062, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534611
(9508111, 214105, 1007, 262, 0, 0, 310.722, 58.7413, 115.307, 3.92893, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534612
(9508112, 214101, 1007, 262, 0, 0, 169.726, 5.54167, 120.159, 0.964698, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534613
(9508113, 214105, 1007, 262, 0, 0, 255.198, 23.8976, 115.313, 5.60041, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534614
(9508114, 214106, 1007, 262, 0, 0, 213.016, 119.304, 114.364, 1.04092, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534615
(9508115, 214107, 1007, 262, 0, 0, 125.661, 104.812, 107.006, 5.83428, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534616
(9508116, 211649, 1007, 262, 0, 0, 105.464, 76.2483, 102.513, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534617
(9508117, 214277, 1007, 262, 0, 0, 104.483, 83.4271, 102.592, 4.08062, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534618
(9508118, 214280, 1007, 262, 0, 0, 219.74, 175.431, 114.258, 4.45336, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534619
(9508119, 214278, 1007, 262, 0, 0, 255.231, 46.8906, 115.313, 0.80381, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534620
(9508120, 211647, 1007, 262, 0, 0, 117.302, 104.174, 105.15, 0, 0, 0, 0, 1, 7200, 255, 1), -- LoA 534621
(9508121, 211674, 1007, 256, 0, 0, 199.99, 122.051, 138.429, 4.723, 0, 0, -0.703344, 0.710849, 7200, 255, 1), -- LoA 546717
(9508122, 211989, 1007, 256, 0, 0, 200.147, 107.681, 131.921, 4.723, 0, 0, -0.703344, 0.710849, 7200, 255, 1); -- LoA 546718

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 9508000 AND 9508612;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(9508325, 95083250, 0, 0, 0, 0, NULL), -- LoA 539057
(9508406, 95084060, 0, 0, 0, 0, NULL), -- LoA 539343
(9508448, 95084480, 0, 0, 0, 0, NULL), -- LoA 539486
(9508477, 95084770, 0, 0, 0, 0, NULL); -- LoA 539553

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 95080000 AND 95086120 OR `id` BETWEEN 9508000 AND 9508612;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_flag`, `action`, `action_chance`, `wpguid`) VALUES
(95083250, 1, 176.889, 11.6761, 119.226, 0, 0, 0, 0, 100, 0),
(95083250, 2, 176.954, 38.5824, 119.226, 0, 0, 0, 0, 100, 0),
(95084060, 1, 221.178, 38.6518, 119.227, 0, 0, 0, 0, 100, 0),
(95084060, 2, 221.518, 11.8758, 119.232, 0, 0, 0, 0, 100, 0),
(95084480, 1, 225.006, -44.0878, 119.24, 0, 0, 0, 0, 100, 0),
(95084480, 2, 212.869, -44.3552, 119.244, 0, 0, 0, 0, 100, 0),
(95084480, 3, 225.306, -43.8098, 119.24, 0, 0, 0, 0, 100, 0),
(95084480, 4, 250.396, -43.404, 113.432, 0, 0, 0, 0, 100, 0),
(95084480, 5, 265.779, -43.0771, 113.432, 0, 0, 0, 0, 100, 0),
(95084480, 6, 250.56, -43.8726, 113.431, 0, 0, 0, 0, 100, 0),
(95084480, 7, 239.133, -43.7185, 116.056, 0, 0, 0, 0, 100, 0),
(95084770, 1, 265.66, -43.3511, 113.432, 0, 0, 0, 0, 100, 0),
(95084770, 2, 250.633, -43.6788, 113.432, 0, 0, 0, 0, 100, 0),
(95084770, 3, 226.379, -43.6558, 119.132, 0, 0, 0, 0, 100, 0),
(95084770, 4, 210.28, -43.79, 119.245, 0, 0, 0, 0, 100, 0),
(95084770, 5, 225.05, -43.2854, 119.24, 0, 0, 0, 0, 100, 0),
(95084770, 6, 248.273, -43.4305, 113.851, 0, 0, 0, 0, 100, 0),
(95084770, 7, 256.568, -43.5383, 113.433, 0, 0, 0, 0, 100, 0),
(9508325, 1, 176.889, 11.6761, 119.226, 0, 0, 0, 0, 100, 0),
(9508325, 2, 176.954, 38.5824, 119.226, 0, 0, 0, 0, 100, 0),
(9508406, 1, 221.178, 38.6518, 119.227, 0, 0, 0, 0, 100, 0),
(9508406, 2, 221.518, 11.8758, 119.232, 0, 0, 0, 0, 100, 0),
(9508448, 1, 225.006, -44.0878, 119.24, 0, 0, 0, 0, 100, 0),
(9508448, 2, 212.869, -44.3552, 119.244, 0, 0, 0, 0, 100, 0),
(9508448, 3, 225.306, -43.8098, 119.24, 0, 0, 0, 0, 100, 0),
(9508448, 4, 250.396, -43.404, 113.432, 0, 0, 0, 0, 100, 0),
(9508448, 5, 265.779, -43.0771, 113.432, 0, 0, 0, 0, 100, 0),
(9508448, 6, 250.56, -43.8726, 113.431, 0, 0, 0, 0, 100, 0),
(9508448, 7, 239.133, -43.7185, 116.056, 0, 0, 0, 0, 100, 0),
(9508477, 1, 265.66, -43.3511, 113.432, 0, 0, 0, 0, 100, 0),
(9508477, 2, 250.633, -43.6788, 113.432, 0, 0, 0, 0, 100, 0),
(9508477, 3, 226.379, -43.6558, 119.132, 0, 0, 0, 0, 100, 0),
(9508477, 4, 210.28, -43.79, 119.245, 0, 0, 0, 0, 100, 0),
(9508477, 5, 225.05, -43.2854, 119.24, 0, 0, 0, 0, 100, 0),
(9508477, 6, 248.273, -43.4305, 113.851, 0, 0, 0, 0, 100, 0),
(9508477, 7, 256.568, -43.5383, 113.433, 0, 0, 0, 0, 100, 0);


-- Ice Wall stalker spawn (LoA 539160)
DELETE FROM `creature` WHERE `guid` = 9508613;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseId`, `phaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(9508613, 68291, 1007, 262, 0, 0, 0, 0, 199.988, -5.299, 119.225, 1.56, 7200, 0, 0, 1, 0, 0, 0, 0, 0);
