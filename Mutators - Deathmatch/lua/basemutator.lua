Hooks:Add("LocalizationManagerPostInit", "MutatorDeathMatch_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_deathmatch"] = "Deathmatch",
		["mutator_deathmatch_desc"] = "Block and stop something so you can do Deathmatch with your friends.",
		["mutator_deathmatch_longdesc"] = "This mutator require 'Friendly Fire'"
	})
end)

MutatorDeathMatch = MutatorDeathMatch or class(BaseMutator)
MutatorDeathMatch._type = "MutatorDeathMatch"
MutatorDeathMatch.name_id = "mutator_deathmatch"
MutatorDeathMatch.desc_id = "mutator_deathmatch_desc"
MutatorDeathMatch.has_options = false
MutatorDeathMatch.reductions = {money = 1, exp = 1}
MutatorDeathMatch.categories = {"gameplay"}
MutatorDeathMatch.icon_coords = {10, 1}

Hooks:PostHook(MutatorDeathMatch, "set_enabled", "MutatorDeathMatch_set_enabled", function(mm, enable)
	if managers.mutators then
		_MM = managers.mutators:get_mutator_from_id("MutatorFriendlyFire") or nil
		if _MM then
			_MM:set_enabled(enable)
		end
	end
end )