-- Stormstout Brewery: keep two Aqua Dancers (56865), one per Sodden Hozen
-- Brawler (59605), as pandaria_5.4.8 and LoA do. 15918 and 15919 hover over the
-- two brawlers; the other four were 20+ yards off and had no brawler to bind.
DELETE FROM `creature` WHERE `guid` IN (15920, 15921, 15922, 15923) AND `id` = 56865;
DELETE FROM `creature_addon` WHERE `guid` IN (15920, 15921, 15922, 15923);
