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