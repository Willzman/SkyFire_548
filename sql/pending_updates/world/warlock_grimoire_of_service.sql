-- Grimoire of Service (108501): AI for the demons summoned by Grimoire: Imp/Voidwalker/Succubus/Felhunter/Felguard.
-- The script only attaches to those guardians; the warlock's real pet and any other use of these entries keep their AI.
UPDATE `creature_template` SET `ScriptName` = 'npc_grimoire_of_service_pet' WHERE `entry` IN (416, 417, 1860, 1863, 17252);
