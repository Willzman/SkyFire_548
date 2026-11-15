-- Scripts that exist in the core but had no row pointing at them. Safe to run twice.

-- Area trigger scripts (rows as in LoA: Entry, Flags, CollisionType, Radius, ScaleX, ScaleY, ScriptName)
DELETE FROM `spell_areatrigger_template` WHERE `Entry` IN (229,306,343,440,465,474,1276,1277);
INSERT INTO `spell_areatrigger_template` (`Entry`,`Flags`,`CollisionType`,`Radius`,`ScaleX`,`ScaleY`,`ScriptName`) VALUES
(229,0,0,5,0,0,'sat_nullification_barrier'),      -- Feng the Accursed
(306,0,1,30,0,0,'sat_mv_energy_conduit'),         -- Elegon
(343,0,1,80,0,0,'sat_neronok_gusting_winds'),     -- Wing Leader Ner'onok
(440,0,1,1,0,0,'sat_magic_banana'),               -- Magic Banana (item)
(465,0,1,3.5,3.5,3.5,'sat_amethyst_pool'),        -- The Stone Guard
(474,0,1,1.5,0,0,'sat_spm_fire_arrow'),           -- Shado-Pan Monastery
(1276,0,0,2,2,2,'sat_noodles'),                   -- Sha of Doubt challenge: noodles
(1277,0,0,3,3,3,'sat_dsah_of_spice');             -- Sha of Doubt challenge: dash of spice

-- Spell scripts
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_loot_a_rang','spell_item_stay_of_execution');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(84421,'spell_item_loot_a_rang'),
(96988,'spell_item_stay_of_execution'),
(97145,'spell_item_stay_of_execution');

-- Tong the Fixer (the copy summoned for the Wrathion quests): had the innkeeper script, which does nothing without a gossip flag
UPDATE `creature_template` SET `ScriptName` = 'npc_tong_the_fixer_legend_in_the_making' WHERE `entry` = 64821 AND `ScriptName` = 'npc_innkeeper';
