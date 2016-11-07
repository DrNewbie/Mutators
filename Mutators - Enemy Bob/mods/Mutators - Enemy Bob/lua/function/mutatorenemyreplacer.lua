_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local _MutatorEnemyBob_MutatorEnemyReplacer_get_unit_group_tank = MutatorEnemyReplacer._get_unit_group_tank

function MutatorEnemyReplacer:_get_unit_group_tank(...)
	local _res = _MutatorEnemyBob_MutatorEnemyReplacer_get_unit_group_tank(self, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorEnemyBob", MutatorEnemyBob) then
		table.insert(_res.unit_types.america, "units/payday2/characters/civ_male_casual_1/civ_male_casual_1")
		table.insert(_res.unit_types.russia, "units/payday2/characters/civ_male_casual_1/civ_male_casual_1")
	end
	return _res
end

Hooks:Add("LocalizationManagerPostInit", "MutatorEnemyBob_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_enemybob"] = "Enemy Bob",
		["mutator_enemybob_desc"] = "He is not your friend.",
		["mutator_enemybob_longdesc"] = "Add 'Bobblehead Bob' into Bulldozer group"
	})
end)

MutatorEnemyBob = MutatorEnemyBob or class(BaseMutator)
MutatorEnemyBob._type = "MutatorEnemyBob"
MutatorEnemyBob.name_id = "mutator_enemybob"
MutatorEnemyBob.desc_id = "mutator_enemybob_desc"
MutatorEnemyBob.has_options = false
MutatorEnemyBob.reductions = {money = 0, exp = 0}
MutatorEnemyBob.categories = {"enemies"}
MutatorEnemyBob.icon_coords = {10, 1}

function MutatorEnemyBob:setup()
	self._groups = self._groups or {}
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	self:modify_unit_categories(tweak_data.group_ai, difficulty_index)
end

function MutatorEnemyBob:modify_unit_categories(group_ai_tweak, difficulty_index)
	table.insert(group_ai_tweak.unit_categories.FBI_tank.unit_types.america, "units/payday2/characters/civ_male_casual_1/civ_male_casual_1")
	table.insert(group_ai_tweak.unit_categories.FBI_tank.unit_types.russia, "units/payday2/characters/civ_male_casual_1/civ_male_casual_1")
end