core:import("CoreMissionScriptElement")
ElementPlayerSpawner = ElementPlayerSpawner or class(CoreMissionScriptElement.MissionScriptElement)

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}
local TMP_mutator_saving = _G.TMP_mutator_saving or {}

TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Spawn_Position = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Spawn_Position or {}

function ElementPlayerSpawner:on_executed(instigator)
	local _id = tostring(self._id)
	if not self._values.enabled then
		return
	end
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		table.insert(TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Spawn_Position, self._values.position)
	end
	managers.player:set_player_state(self._values.state or managers.player:default_player_state())
	managers.groupai:state():on_player_spawn_state_set(self._values.state or managers.player:default_player_state())
	managers.network:register_spawn_point(self._id, {
		position = self._values.position,
		rotation = self._values.rotation
	})
	ElementPlayerSpawner.super.on_executed(self, self._unit or instigator)
end