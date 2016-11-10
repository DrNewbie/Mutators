CopMovement._action_variants["bobdozer"] = CopMovement._action_variants["tank"]

Hooks:PostHook(CopMovement, "set_character_anim_variables", "Bobdozer_GetMask", function(cop, ...)
	if cop._unit:inventory().preload_mask ~= nil then
		cop._unit:inventory():preload_mask()
	end
end)