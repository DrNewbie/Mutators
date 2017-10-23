Hooks:Add("LocalizationManagerPostInit", "MutatorAprilFools_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_AprilFools"] = "April Fools",
		["mutator_AprilFools_desc"] = "Enable or Disable something that come April Fools",
		["mutator_AprilFools_longdesc"] = "......",
	})
end)

MutatorAprilFools = MutatorAprilFools or class(BaseMutator)
MutatorAprilFools._type = "MutatorAprilFools"
MutatorAprilFools.name_id = "mutator_AprilFools"
MutatorAprilFools.desc_id = "mutator_AprilFools_desc"
MutatorAprilFools.has_options = false
MutatorAprilFools.reductions = {money = 0, exp = 0}
MutatorAprilFools.categories = {"gameplay"}
MutatorAprilFools.icon_coords = {10, 1}