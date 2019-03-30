_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(HUDManager, "set_enabled", "MutatorRealismBlockEnable", function(hudd)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		hudd:set_disabled()
	end
end )

Hooks:PostHook(HUDManager, "init", "MutatorRealismEnable", function(hudd)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		hudd:set_disabled()
	else
		hudd:set_enabled()
	end
end )