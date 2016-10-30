Hooks:Add("LocalizationManagerPostInit", "MutatorHeadshotOnly_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_headshotonly"] = "Headshot Only",
		["mutator_headshotonly_desc"] = "Only headshot will do damage",
		["mutator_headshotonly_longdesc"] = "......",
	})
end)

MutatorHeadshotOnly = MutatorHeadshotOnly or class(BaseMutator)
MutatorHeadshotOnly._type = "MutatorHeadshotOnly"
MutatorHeadshotOnly.name_id = "mutator_headshotonly"
MutatorHeadshotOnly.desc_id = "mutator_headshotonly_desc"
MutatorHeadshotOnly.has_options = false
MutatorHeadshotOnly.reductions = {money = 0, exp = 0}
MutatorHeadshotOnly.categories = {"gameplay"}
MutatorHeadshotOnly.icon_coords = {10, 1}