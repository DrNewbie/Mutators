Hooks:Add("LocalizationManagerPostInit", "MutatorBeBulldozer_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_bebulldozer"] = "I want to be bulldozer",
		["mutator_bebulldozer_desc"] = "Sniper, Medic, Tazer, Shield, Cloaker have as much health as a Bulldozer",
		["mutator_bebulldozer_longdesc"] = "This mutator require 'Because of Training'"
	})
end)

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

MutatorBeBulldozer = MutatorBeBulldozer or class(BaseMutator)
MutatorBeBulldozer._type = "MutatorBeBulldozer"
MutatorBeBulldozer.name_id = "mutator_bebulldozer"
MutatorBeBulldozer.desc_id = "mutator_bebulldozer_desc"
MutatorBeBulldozer.has_options = false
MutatorBeBulldozer.reductions = {money = 0, exp = 0}
MutatorBeBulldozer.categories = {"enemies"}
MutatorBeBulldozer.icon_coords = {10, 1}

Hooks:PostHook(MutatorBeBulldozer, "set_enabled", "MutatorBeBulldozer_set_enabled", function(mm, enable)
	if managers.mutators then
		_MM = managers.mutators:get_mutator_from_id("MutatorEnemyHealth") or nil
		if _MM then
			_MM:set_enabled(enable)
		end
	end
end )