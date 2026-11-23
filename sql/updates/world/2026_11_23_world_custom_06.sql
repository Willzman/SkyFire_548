-- S3 (part 2): bindings for the holiday spell scripts ported from TrinityCore
-- (Love is in the Air, Lunar Festival, and Hallow's End, Midsummer and Brewfest spells that had no script).
-- Safe to run twice.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN (
'spell_love_is_in_the_air_heavily_perfumed','spell_love_is_in_the_air_recently_analyzed','spell_love_is_in_the_air_sample_satisfaction',
'spell_love_is_in_the_air_cancel_service_uniform','spell_love_is_in_the_air_perfume_cologne_immune',
'spell_lunar_festival_elunes_blessing',
'spell_hallow_end_candy','spell_hallow_end_candy_pirate','spell_hallow_end_create_water_bucket',
'spell_midsummer_cleansing_flames','spell_midsummer_stamp_out_bonfire_event','spell_midsummer_remove_torches',
'spell_brewfest_dismount_ram','spell_brewfest_mole_machine_portal_schedule','spell_brewfest_botm_nauseous');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(71507,'spell_love_is_in_the_air_heavily_perfumed'),
(71508,'spell_love_is_in_the_air_recently_analyzed'),
(69438,'spell_love_is_in_the_air_sample_satisfaction'),
(71522,'spell_love_is_in_the_air_cancel_service_uniform'),
(71539,'spell_love_is_in_the_air_cancel_service_uniform'),
(68529,'spell_love_is_in_the_air_perfume_cologne_immune'),
(68530,'spell_love_is_in_the_air_perfume_cologne_immune'),
(26393,'spell_lunar_festival_elunes_blessing'),
(24930,'spell_hallow_end_candy'),
(24926,'spell_hallow_end_candy_pirate'),
(42144,'spell_hallow_end_create_water_bucket'),
(29126,'spell_midsummer_cleansing_flames'),
(29135,'spell_midsummer_cleansing_flames'),
(29136,'spell_midsummer_cleansing_flames'),
(29137,'spell_midsummer_cleansing_flames'),
(29138,'spell_midsummer_cleansing_flames'),
(29139,'spell_midsummer_cleansing_flames'),
(46671,'spell_midsummer_cleansing_flames'),
(46672,'spell_midsummer_cleansing_flames'),
(45443,'spell_midsummer_stamp_out_bonfire_event'),
(46074,'spell_midsummer_remove_torches'),
(43876,'spell_brewfest_dismount_ram'),
(49466,'spell_brewfest_mole_machine_portal_schedule'),
(49869,'spell_brewfest_botm_nauseous');
