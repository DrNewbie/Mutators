Hooks:PostHook(HUDManager, "set_enabled", "MutatorRealismBlockEnable", function(hudd, ...)
	hudd:set_disabled()
end )

Hooks:PostHook(HUDManager, "init", "MutatorRealismEnable", function(hudd, ...)
	hudd:set_disabled()
end )