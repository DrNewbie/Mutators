Hooks:Add("LocalizationManagerPostInit", "MutatorBodyshotOnly_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_bodyshotonly"] = "Bodyshot Only",
		["mutator_bodyshotonly_desc"] = "Only bodyshot will do damage",
		["mutator_bodyshotonly_longdesc"] = "......",
	})
end)

MutatorBodyshotOnly = MutatorBodyshotOnly or class(BaseMutator)
MutatorBodyshotOnly._type = "MutatorBodyshotOnly"
MutatorBodyshotOnly.name_id = "mutator_bodyshotonly"
MutatorBodyshotOnly.desc_id = "mutator_bodyshotonly_desc"
MutatorBodyshotOnly.has_options = false
MutatorBodyshotOnly.reductions = {money = 0, exp = 0}
MutatorBodyshotOnly.categories = {"gameplay"}
MutatorBodyshotOnly.icon_coords = {10, 1}
MutatorBodyshotOnly.incompatiblities = {
	"MutatorHeadshotOnly"
}