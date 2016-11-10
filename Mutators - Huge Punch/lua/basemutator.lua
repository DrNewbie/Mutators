Hooks:Add("LocalizationManagerPostInit", "MutatorHugePunch_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_hugepunch"] = "Huge Punch",
		["mutator_hugepunch_desc"] = "Bulldozer will give you a huge punch",
		["mutator_hugepunch_longdesc"] = "..."
	})
end)

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

MutatorHugePunch = MutatorHugePunch or class(BaseMutator)
MutatorHugePunch._type = "MutatorHugePunch"
MutatorHugePunch.name_id = "mutator_hugepunch"
MutatorHugePunch.desc_id = "mutator_hugepunch_desc"
MutatorHugePunch.has_options = false
MutatorHugePunch.reductions = {money = 0, exp = 0}
MutatorHugePunch.categories = {"gameplay"}
MutatorHugePunch.icon_coords = {10, 1}