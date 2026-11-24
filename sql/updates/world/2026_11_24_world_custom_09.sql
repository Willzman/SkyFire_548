-- G4: the last two spell_script_names rows that pointed at no script.
-- 7057 Haunting Spirits: spell_shadowfang_keep_haunting_spirits is now in shadowfang_keep.cpp (from TrinityCore cata_classic).
-- 69712 Ice Tomb (target): spell_sindragosa_ice_tomb already handles it and casts Frost Beacon itself, so the second
-- binding (TrinityCore's spell_sindragosa_ice_tomb_dummy, which would cast Frost Beacon again) goes.
DELETE FROM `spell_script_names` WHERE `spell_id` = 69712 AND `ScriptName` = 'spell_sindragosa_ice_tomb_dummy';

-- 62323 Hookshot (Flame Leviathan, Ulduar) only targets a Flame Leviathan Seat that has a turret and no player
-- (cond_hookshot in boss_flame_leviathan.cpp had no condition row; LoA and pandaria have this one).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` = 62323 AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` = 33114;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62323, 0, 0, 31, 0, 3, 33114, 0, 0, 0, 0, 'cond_hookshot', 'Hookshot targets Flame Leviathan Seat');
