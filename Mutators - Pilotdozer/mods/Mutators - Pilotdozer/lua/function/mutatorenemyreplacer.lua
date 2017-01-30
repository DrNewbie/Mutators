_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local _MutatorPilotdozer_MutatorEnemyReplacer_get_unit_group_tank = MutatorEnemyReplacer._get_unit_group_tank

function MutatorEnemyReplacer:_get_unit_group_tank(...)
	local _res = _MutatorPilotdozer_MutatorEnemyReplacer_get_unit_group_tank(self, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorPilotdozer", MutatorPilotdozer) then
		table.insert(_res.unit_types.america, Idstring("units/payday2/characters/civ_male_pilot_1/civ_male_pilot_1"))
		table.insert(_res.unit_types.russia, Idstring("units/payday2/characters/civ_male_pilot_1/civ_male_pilot_1"))
	end
	return _res
end

Hooks:Add("LocalizationManagerPostInit", "MutatorPilotdozer_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_Pilotdozer"] = "Pilotdozer",
		["mutator_Pilotdozer_desc"] = "He is not your friend.",
		["mutator_Pilotdozer_longdesc"] = "Add 'Pilot' into Bulldozer group"
	})
end)

MutatorPilotdozer = MutatorPilotdozer or class(BaseMutator)
MutatorPilotdozer._type = "MutatorPilotdozer"
MutatorPilotdozer.name_id = "mutator_Pilotdozer"
MutatorPilotdozer.desc_id = "mutator_Pilotdozer_desc"
MutatorPilotdozer.has_options = false
MutatorPilotdozer.reductions = {money = 0, exp = 0}
MutatorPilotdozer.categories = {"enemies"}
MutatorPilotdozer.icon_coords = {10, 1}

function MutatorPilotdozer:setup()
	self._groups = self._groups or {}
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	self:modify_unit_categories(tweak_data.group_ai, difficulty_index)
end

function MutatorPilotdozer:modify_unit_categories(group_ai_tweak, difficulty_index)
	if TMP_mutator_saving:Is_This_Enable("MutatorPilotdozer", MutatorPilotdozer) then
		table.insert(group_ai_tweak.unit_categories.FBI_tank.unit_types.america, Idstring("units/payday2/characters/civ_male_pilot_1/civ_male_pilot_1"))
		table.insert(group_ai_tweak.unit_categories.FBI_tank.unit_types.russia, Idstring("units/payday2/characters/civ_male_pilot_1/civ_male_pilot_1"))
	end
end