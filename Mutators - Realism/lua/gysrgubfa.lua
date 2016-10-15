_G._tmp_mutator_saving = _G._tmp_mutator_saving or {}

Hooks:PostHook(HUDManager, "set_enabled", "MutatorRealismBlockEnable", function(hudd, ...)
	if MutatorRealism and _tmp_mutator_saving.MutatorRealism then
		hudd:set_disabled()
	end
end )

Hooks:PostHook(HUDManager, "init", "MutatorRealismEnable", function(hudd, ...)
	if MutatorRealism and _tmp_mutator_saving.MutatorRealism then
		hudd:set_disabled()
	else
		hudd:set_enabled()
	end
end )