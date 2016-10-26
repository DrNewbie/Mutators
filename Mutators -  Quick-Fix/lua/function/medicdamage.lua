_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(MedicDamage, "init", "MutatorQuickFix_MedicDamage_init", function(medic, ...)
	if MutatorQuickFix and TMP_mutator_saving.data and TMP_mutator_saving.data.MutatorQuickFix then
		medic._quickfix_times_used = 0
	end
end )

local MutatorQuickFix_MedicDamage_heal_unit = MedicDamage.heal_unit

function MedicDamage:heal_unit(...)
	local result = MutatorQuickFix_MedicDamage_heal_unit(self, ...)
	if result == true and MutatorQuickFix and TMP_mutator_saving.data and TMP_mutator_saving.data.MutatorQuickFix then
		self._quickfix_times_used = math.clamp(self._quickfix_times_used + 1, 0, 10)
		self._heal_cooldown_t = self._heal_cooldown_t - math.clamp((self._quickfix_times_used * 0.3), 0, 2.99)
	end
	return result
end