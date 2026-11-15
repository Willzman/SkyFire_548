-- Wandering Isle: Master Shang Xi (53566) offered all seven class versions of
-- "Much to Learn" (30039-30045) to every class, because they had no class mask.
-- Give each the mask of the "The Lesson of the Iron Bough" quest it leads to
-- (30027, 30033-30038). Same values as pandaria_5.4.8's world DB.
UPDATE `quest_template` SET `RequiredClasses` = 512 WHERE `Id` = 30039; -- Monk    -> 30027
UPDATE `quest_template` SET `RequiredClasses` = 128 WHERE `Id` = 30040; -- Mage    -> 30033
UPDATE `quest_template` SET `RequiredClasses` = 4   WHERE `Id` = 30041; -- Hunter  -> 30034
UPDATE `quest_template` SET `RequiredClasses` = 16  WHERE `Id` = 30042; -- Priest  -> 30035
UPDATE `quest_template` SET `RequiredClasses` = 8   WHERE `Id` = 30043; -- Rogue   -> 30036
UPDATE `quest_template` SET `RequiredClasses` = 64  WHERE `Id` = 30044; -- Shaman  -> 30037
UPDATE `quest_template` SET `RequiredClasses` = 1   WHERE `Id` = 30045; -- Warrior -> 30038
