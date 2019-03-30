_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(TeamAIDamage, "init", "MutatorDeathMatch_init_Init", function(aii, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		aii._char_dmg_tweak.DOWNED_TIME = 0
	end
end )