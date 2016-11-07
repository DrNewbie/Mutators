Hooks:Add("LocalizationManagerPostInit", "MutatorRealism_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_realism"] = "Realism",
		["mutator_realism_desc"] = "Outlines and HUD are disabled",
		["mutator_realism_longdesc"] = "......Realism",
	})
end)

MutatorRealism = MutatorRealism or class(BaseMutator)
MutatorRealism._type = "MutatorRealism"
MutatorRealism.name_id = "mutator_realism"
MutatorRealism.desc_id = "mutator_realism_desc"
MutatorRealism.has_options = false
MutatorRealism.reductions = {money = 0, exp = 0}
MutatorRealism.categories = {"gameplay"}
MutatorRealism.icon_coords = {10, 1}

function MutatorRealism:setup()
	Hooks:Add("HUDManagerPreAddWaypoint", self._AddWaypointHook, function(hud, id, data)
		return true
	end)
	Hooks:Add("ContourExtPreInitialize", self._ContourInit, function(contour, unit)
		for k, v in pairs(ContourExt._types) do
			if v.color ~= nil then
				v.color = Color(0, 0, 0, 0)
			end
		end
	end)
	Hooks:Add("ContourExtPreAdd", self._ContourAdd, function(contour, type, sync, multiplier)
		contour._contour_list = contour._contour_list or {}
		return true
	end)
	Hooks:Add("BaseInteractionExtPreSetContour", self._BaseInteractionSetContour, function(int, color, opacity)
		return { color = color, opacity = 0 }
	end)
	Hooks:Add("HUDManagerPreAddNameLabel", self._AddNameLabel, function(hud, data)
		data.name = ""
	end)
end