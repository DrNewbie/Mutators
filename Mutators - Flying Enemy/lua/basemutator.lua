Hooks:Add("LocalizationManagerPostInit", "MutatorFlyingEnemy_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_flyingenemy"] = "Flying Enemy",
		["mutator_flyingenemy_desc"] = "Enemies will move to somewhere around you",
		["mutator_flyingenemy_longdesc"] = "......",
	})
end)

MutatorFlyingEnemy = MutatorFlyingEnemy or class(BaseMutator)
MutatorFlyingEnemy._type = "MutatorFlyingEnemy"
MutatorFlyingEnemy.name_id = "mutator_flyingenemy"
MutatorFlyingEnemy.desc_id = "mutator_flyingenemy_desc"
MutatorFlyingEnemy.has_options = false
MutatorFlyingEnemy.reductions = {money = 0, exp = 0}
MutatorFlyingEnemy.categories = {"gameplay"}
MutatorFlyingEnemy.icon_coords = {10, 1}
MutatorFlyingEnemy.incompatiblities = {}