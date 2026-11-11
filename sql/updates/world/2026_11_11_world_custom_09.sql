-- C4: the 10% spell power raid buffs (SPELL_AURA_MOD_SPELL_POWER_PCT, now implemented) must not stack
-- with each other. Group 1200 uses SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT (3): every buff stays on
-- the target, but only the highest spell power % counts. Inner Fire (588) is a self buff and stacks.
-- Spells checked in the 5.4.8 client (aura 317, amount 10). Like LoA's group 1122/1133.
DELETE FROM `spell_group` WHERE `id` = 1200;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1200, 1459),   -- Arcane Brilliance
(1200, 61316),  -- Dalaran Brilliance
(1200, 130958), -- Arcane Brilliance
(1200, 133533), -- Arcane Brilliance
(1200, 109773), -- Dark Intent
(1200, 77747),  -- Burning Wrath (Shaman)
(1200, 126309); -- Still Water (Water Strider pet)

DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1200;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1200, 3);
