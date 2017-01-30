CopMovement._action_variants["pilotdozer"] = CopMovement._action_variants["tank"]

Hooks:PostHook(CopMovement, "set_character_anim_variables", "pilotdozer_GetMask", function(cop, ...)
	if cop._unit:inventory().CUS_preload_mask ~= nil then
		cop._unit:inventory():CUS_preload_mask()
	end
end)