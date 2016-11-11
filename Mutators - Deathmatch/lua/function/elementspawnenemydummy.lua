core:import("CoreMissionScriptElement")
ElementSpawnEnemyDummy = ElementSpawnEnemyDummy or class(CoreMissionScriptElement.MissionScriptElement)
ElementSpawnEnemyDummy._unit_destroy_clbk_key = "ElementSpawnEnemyDummy"
ElementSpawnEnemyDummy.ACCESSIBILITIES = {
	"any",
	"walk",
	"acrobatic"
}

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
	function ElementSpawnEnemyDummy:on_executed(instigator)
		return
	end
end