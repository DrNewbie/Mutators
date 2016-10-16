Hooks:Add("LocalizationManagerPostInit", "MutatorZeroDown_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_zerodown"] = "Zero Down",
		["mutator_zerodown_desc"] = "You will directly go to custody when you down",
		["mutator_zerodown_longdesc"] = "......",
	})
end)

MutatorZeroDown = MutatorZeroDown or class(BaseMutator)
MutatorZeroDown._type = "MutatorZeroDown"
MutatorZeroDown.name_id = "mutator_zerodown"
MutatorZeroDown.desc_id = "mutator_zerodown_desc"
MutatorZeroDown.has_options = false
MutatorZeroDown.reductions = {money = 0, exp = 0}
MutatorZeroDown.categories = {"gameplay"}
MutatorZeroDown.icon_coords = {10, 1}