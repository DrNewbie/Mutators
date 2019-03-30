core:import("CoreMissionScriptElement")
ElementSpawnCivilian = ElementSpawnCivilian or class(CoreMissionScriptElement.MissionScriptElement)

local _EnemyBob_ElementSpawnCivilian_produce = ElementSpawnCivilian.produce

function ElementSpawnCivilian:produce(...)
	if self._enemy_name:key() == Idstring("units/payday2/characters/civ_male_casual_1/civ_male_casual_1"):key() then
		return
	end
	return _EnemyBob_ElementSpawnCivilian_produce(self, ...)
end