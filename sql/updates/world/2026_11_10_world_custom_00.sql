-- P1 misc: scripts the world DB already binds but the core lacked.
-- Ported in C++ on this branch (no DB change needed): npc_novos_minion, npc_crystalline_tangler,
-- npc_void_zone, spell_the_lich_king_play_movie, go_soulwell, spell_gen_seaforium_blast,
-- spell_gen_replenishment, spell_gen_searching_for_artifacts, the Emerald Dragon scripts.

-- General Vezax, Mark of the Faceless (63276): the spell is already bound to SkyFire's own
-- spell_general_vezax_mark_of_the_faceless. The extra row names a LoA-only script that doesn't exist here.
DELETE FROM `spell_script_names` WHERE `spell_id` = 63276 AND `ScriptName` = 'spell_mark_of_the_faceless';
