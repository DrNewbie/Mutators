core:import("CoreMissionScriptElement")
ElementSpawnCivilianGroup = ElementSpawnCivilianGroup or class(CoreMissionScriptElement.MissionScriptElement)

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
	function ElementSpawnCivilianGroup:on_executed(instigator)
		return
	end
end