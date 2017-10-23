core:import("CoreMissionScriptElement")
ElementSpawnCivilian = ElementSpawnCivilian or class(CoreMissionScriptElement.MissionScriptElement)

local _Bankspook_ElementSpawnCivilian_produce = ElementSpawnCivilian.produce

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function ElementSpawnCivilian:produce(...)
	local _res = _Bankspook_ElementSpawnCivilian_produce(self, ...)
	local _Is_Enable = TMP_mutator_saving:Is_This_Enable("MutatorBankspook", MutatorBankspook)
	local _SP = {}
	_SP[Idstring("units/payday2/characters/civ_male_bank_1/civ_male_bank_1"):key()] = true
	_SP[Idstring("units/payday2/characters/civ_male_bank_2/civ_male_bank_2"):key()] = true
	if _SP[self._enemy_name:key()] then
		if _Is_Enable then
			local _team = "combatant"
			local _team_id = tweak_data.levels:get_default_team_ID(_team)
			_res:movement():set_team(managers.groupai:state():team_data(_team_id))
			managers.groupai:state():_clear_criminal_suspicion_data()
		else
			_res:set_slot(0)
		end
	end
	return _res
end