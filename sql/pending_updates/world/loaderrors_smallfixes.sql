-- Small load-error fixes. Safe to run twice.

-- Spell target conditions that named an effect without an area/cone/nearby target (so the row was ignored):
-- 116711: effects 0 and 1 hit the caster, the area effect is effect 2
UPDATE `conditions` SET `SourceGroup` = 4 WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 116711 AND `SourceGroup` = 3;
-- 126642 Dragon Breath Cosmetic: the cone is effect 1
UPDATE `conditions` SET `SourceGroup` = 2 WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 126642 AND `SourceGroup` = 1;
-- 126022 Activate Artifact: only has effect 0
UPDATE `conditions` SET `SourceGroup` = 1 WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 126022 AND `SourceGroup` = 3;
-- 114379 has one effect on an explicit target, there is nothing for a condition to filter
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 114379 AND `SourceGroup` = 1;

-- SmartAI "area explored or event happens" credit for quests that are not event quests (the action was skipped):
-- 12575 The Lost Mistwhisper Treasure: the objective is killing Warlord Tartek himself, no extra credit needed
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28105 AND `source_type` = 0 AND `id` = 11 AND `action_type` = 15;
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 28105 AND `source_type` = 0 AND `id` = 10 AND `link` = 11;
-- 13949 Crossroads Caravan Pickup: the row before already gives the kill credit (53613)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 34258 AND `source_type` = 0 AND `id` = 1 AND `action_type` = 15;
UPDATE `smart_scripts` SET `link` = 2 WHERE `entryorguid` = 34258 AND `source_type` = 0 AND `id` = 0 AND `link` = 1;
-- 25924 Call of Duty: reaching Erunak Stonespeaker gives the quest's kill credit (36901)
UPDATE `smart_scripts` SET `action_type` = 33, `action_param1` = 36901 WHERE `entryorguid` = 41618 AND `source_type` = 0 AND `id` = 0 AND `action_type` = 15;

-- Difficulty templates: the normal mode's AI is always used, and unit_class has to match the normal mode
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 48835 AND `AIName` = 'NullCreatureAI';
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` = 900050 AND `unit_class` = 1;

-- Quest givers with a gossip menu but no gossip flag
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` IN (67997,69670) AND `gossip_menu_id` <> 0;

-- Skinning loot: 45 creatures had a group adding up to more than 100%, so the last rows of the group could never drop.
-- Plump Intestines (72201) gets its own roll, as on the other Pandaria beasts
UPDATE `skinning_loot_template` SET `groupid` = 0 WHERE `item` = 72201 AND `groupid` = 1 AND `entry` IN (54896,56201,56256,56272,56683,58427,58631,58641,59103,59104,59110,59540,59743,59753,59754,59769,59772,59796,60202,60564,61091,61446,62008,62023,62346,63827,65820,65823,66096,66164,66464,66587,66729,66750,66892,66895,66898,66935);
-- Leather rolls still over 100%: same proportions, scaled to 100
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 28.6 WHERE `entry` = 56239 AND `item` = 72120 AND `groupid` = 1; -- was 44 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 58.4 WHERE `entry` = 56239 AND `item` = 72162 AND `groupid` = 1; -- was 90 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 13 WHERE `entry` = 56239 AND `item` = 79101 AND `groupid` = 1; -- was 20 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 30.5 WHERE `entry` = 56523 AND `item` = 72120 AND `groupid` = 1; -- was 47 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 57.1 WHERE `entry` = 56523 AND `item` = 72162 AND `groupid` = 1; -- was 88 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 12.4 WHERE `entry` = 56523 AND `item` = 79101 AND `groupid` = 1; -- was 19 of 154
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 65.7 WHERE `entry` = 58424 AND `item` = 72120 AND `groupid` = 1; -- was 94 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 14 WHERE `entry` = 58424 AND `item` = 72162 AND `groupid` = 1; -- was 20 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 20.3 WHERE `entry` = 58424 AND `item` = 79101 AND `groupid` = 1; -- was 29 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 28.1 WHERE `entry` = 58427 AND `item` = 72120 AND `groupid` = 1; -- was 43 of 153
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 58.8 WHERE `entry` = 58427 AND `item` = 72162 AND `groupid` = 1; -- was 90 of 153
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 13.1 WHERE `entry` = 58427 AND `item` = 79101 AND `groupid` = 1; -- was 20 of 153
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 29.9 WHERE `entry` = 58895 AND `item` = 72120 AND `groupid` = 1; -- was 44 of 147
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 57.8 WHERE `entry` = 58895 AND `item` = 72162 AND `groupid` = 1; -- was 85 of 147
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 12.3 WHERE `entry` = 58895 AND `item` = 79101 AND `groupid` = 1; -- was 18 of 147
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 70.1 WHERE `entry` = 59295 AND `item` = 72120 AND `groupid` = 1; -- was 89 of 127
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 13.4 WHERE `entry` = 59295 AND `item` = 72162 AND `groupid` = 1; -- was 17 of 127
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 16.5 WHERE `entry` = 59295 AND `item` = 79101 AND `groupid` = 1; -- was 21 of 127
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 74.8 WHERE `entry` = 62346 AND `item` = 72120 AND `groupid` = 1; -- was 95 of 127
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 25.2 WHERE `entry` = 62346 AND `item` = 79101 AND `groupid` = 1; -- was 32 of 127
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 75.6 WHERE `entry` = 63827 AND `item` = 72120 AND `groupid` = 1; -- was 99 of 131
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 24.4 WHERE `entry` = 63827 AND `item` = 79101 AND `groupid` = 1; -- was 32 of 131
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 65.7 WHERE `entry` = 65627 AND `item` = 72120 AND `groupid` = 1; -- was 94 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 13.3 WHERE `entry` = 65627 AND `item` = 72162 AND `groupid` = 1; -- was 19 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 21 WHERE `entry` = 65627 AND `item` = 79101 AND `groupid` = 1; -- was 30 of 143
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 28.5 WHERE `entry` = 66096 AND `item` = 72120 AND `groupid` = 1; -- was 43 of 151
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 58.9 WHERE `entry` = 66096 AND `item` = 72162 AND `groupid` = 1; -- was 89 of 151
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 12.6 WHERE `entry` = 66096 AND `item` = 79101 AND `groupid` = 1; -- was 19 of 151
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 30.3 WHERE `entry` = 66213 AND `item` = 72120 AND `groupid` = 1; -- was 47 of 155
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 57.4 WHERE `entry` = 66213 AND `item` = 72162 AND `groupid` = 1; -- was 89 of 155
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance` = 12.3 WHERE `entry` = 66213 AND `item` = 79101 AND `groupid` = 1; -- was 19 of 155
