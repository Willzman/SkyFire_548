-- G4: the last two spell_script_names rows that pointed at no script.
-- 7057 Haunting Spirits: spell_shadowfang_keep_haunting_spirits is now in shadowfang_keep.cpp (from TrinityCore cata_classic).
-- 69712 Ice Tomb (target): spell_sindragosa_ice_tomb already handles it and casts Frost Beacon itself, so the second
-- binding (TrinityCore's spell_sindragosa_ice_tomb_dummy, which would cast Frost Beacon again) goes.
DELETE FROM `spell_script_names` WHERE `spell_id` = 69712 AND `ScriptName` = 'spell_sindragosa_ice_tomb_dummy';
