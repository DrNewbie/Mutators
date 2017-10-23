_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local _MutatorBankspook_MutatorEnemyReplacer_get_unit_group_spooc = MutatorEnemyReplacer._get_unit_group_spooc

function MutatorEnemyReplacer:_get_unit_group_spooc(...)
	local _res = _MutatorBankspook_MutatorEnemyReplacer_get_unit_group_spooc(self, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorBankspook", MutatorBankspook) then
		table.insert(_res.unit_types.america, "units/payday2/characters/civ_male_bank_1/civ_male_bank_1")
		table.insert(_res.unit_types.russia, "units/payday2/characters/civ_male_bank_2/civ_male_bank_2")
	end
	return _res
end

Hooks:Add("LocalizationManagerPostInit", "MutatorBankspook_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_bankspook"] = "Bankcloaker",
		["mutator_bankspook_desc"] = "...",
		["mutator_bankspook_longdesc"] = "Add 2 'Bank teller' into Cloaker group"
	})
end)

MutatorBankspook = MutatorBankspook or class(BaseMutator)
MutatorBankspook._type = "MutatorBankspook"
MutatorBankspook.name_id = "mutator_bankspook"
MutatorBankspook.desc_id = "mutator_bankspook_desc"
MutatorBankspook.has_options = false
MutatorBankspook.reductions = {money = 0, exp = 0}
MutatorBankspook.categories = {"enemies"}
MutatorBankspook.icon_coords = {10, 1}

function MutatorBankspook:setup()
	self._groups = self._groups or {}
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	self:modify_unit_categories(tweak_data.group_ai, difficulty_index)
end

function MutatorBankspook:modify_unit_categories(group_ai_tweak, difficulty_index)
	table.insert(group_ai_tweak.unit_categories.spooc.unit_types.america, "units/payday2/characters/civ_male_bank_1/civ_male_bank_1")
	table.insert(group_ai_tweak.unit_categories.spooc.unit_types.russia, "units/payday2/characters/civ_male_bank_2/civ_male_bank_2")
end