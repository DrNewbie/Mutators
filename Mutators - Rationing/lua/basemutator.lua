Hooks:Add("LocalizationManagerPostInit", "MutatorRationing_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_rationing"] = "Rationing",
		["mutator_rationing_desc"] = "Enemies no longer drop ammo. Bulldozers have a chance to drop an ammo bag where they die.",
		["mutator_rationing_longdesc"] = "......",
	})
end)

MutatorRationing = MutatorRationing or class(BaseMutator)
MutatorRationing._type = "MutatorRationing"
MutatorRationing.name_id = "mutator_rationing"
MutatorRationing.desc_id = "mutator_rationing_desc"
MutatorRationing.has_options = false
MutatorRationing.reductions = {money = 0, exp = 0}
MutatorRationing.categories = {"gameplay"}
MutatorRationing.icon_coords = {10, 1}