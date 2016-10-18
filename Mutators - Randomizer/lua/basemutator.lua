Hooks:Add("LocalizationManagerPostInit", "MutatorRandomizer_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_randomizer"] = "Randomizer",
		["mutator_randomizer_desc"] = "Your loadout will be random.",
		["mutator_randomizer_longdesc"] = "......",
	})
end)

MutatorRandomizer = MutatorRandomizer or class(BaseMutator)
MutatorRandomizer._type = "MutatorRandomizer"
MutatorRandomizer.name_id = "mutator_randomizer"
MutatorRandomizer.desc_id = "mutator_randomizer_desc"
MutatorRandomizer.has_options = false
MutatorRandomizer.reductions = {money = 0, exp = 0}
MutatorRandomizer.categories = {"gameplay"}
MutatorRandomizer.icon_coords = {10, 1}