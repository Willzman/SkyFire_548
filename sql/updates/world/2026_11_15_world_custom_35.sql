-- Difficulty templates that still differ from their normal mode. Safe to run twice.

-- Aqua Dancer: difficulty 2 template gets the unit class of the normal mode (56865), like 900050
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` = 900051 AND `unit_class` = 1;

-- Alterac Valley quartermasters: the difficulty templates have the gossip flag but not the menu of the normal mode
UPDATE `creature_template` SET `gossip_menu_id` = 6261 WHERE `entry` IN (22736,31961,37279) AND `gossip_menu_id` = 0; -- Corporal Teeka Bloodsnarl (13776)
UPDATE `creature_template` SET `gossip_menu_id` = 6262 WHERE `entry` = 22759 AND `gossip_menu_id` = 0;               -- Sergeant Durgen Stormpike (13777)
UPDATE `creature_template` SET `gossip_menu_id` = 5441 WHERE `entry` = 22640 AND `gossip_menu_id` = 0;               -- Warmaster Laggrond (13840)
