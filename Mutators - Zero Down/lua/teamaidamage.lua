_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

TMP_mutator_saving.data = TMP_mutator_saving.data or {}

Hooks:PostHook(TeamAIDamage, "init", "MutatorZeroDown_init_Init", function(aii, ...)
	if MutatorZeroDown and TMP_mutator_saving.data and TMP_mutator_saving.data.MutatorZeroDown then
		aii._char_dmg_tweak.DOWNED_TIME = 0
	end
end )