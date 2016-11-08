core:import("CoreMissionScriptElement")
ElementSpawnCivilian = ElementSpawnCivilian or class(CoreMissionScriptElement.MissionScriptElement)

local _Bankspook_ElementSpawnCivilian_produce = ElementSpawnCivilian.produce

function ElementSpawnCivilian:produce(...)
	local _res = _Bankspook_ElementSpawnCivilian_produce(self, ...)
	local _SP = {}
	_SP[Idstring("units/payday2/characters/civ_male_bank_1/civ_male_bank_1"):key()] = true
	_SP[Idstring("units/payday2/characters/civ_male_bank_2/civ_male_bank_2"):key()] = true
	if _res and alive(_res) and _SP[_res:name():key()] then
		local _team = "combatant"
		local _team_id = tweak_data.levels:get_default_team_ID(_team)
		_res:movement():set_team(managers.groupai:state():team_data(_team_id))		
		managers.groupai:state():_clear_criminal_suspicion_data()
	end
	return _res
end