_G._tmp_mutator_saving = _G._tmp_mutator_saving or {}

Hooks:PostHook(HUDManager, "set_enabled", "MutatorRealismBlockEnable", function(hudd, ...)
	if MutatorRealism and _tmp_mutator_saving.MutatorRealism then
		hudd:set_disabled()
	end
end )

Hooks:PostHook(HUDManager, "init", "MutatorRealismEnable", function(hudd, ...)
	if MutatorRealism and _tmp_mutator_saving.MutatorRealism then
		hudd:set_disabled()
		local _Net = _G and _G.LuaNetworking or nil
		if _Net then
			_Net:SendToPeer(1, "MutatorRealism_Sync_Check", 1)
		end
	else
		hudd:set_enabled()
	end
end )