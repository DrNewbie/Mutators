core:import("CoreMissionScriptElement")
ElementLootBag = ElementLootBag or class(CoreMissionScriptElement.MissionScriptElement)

if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
	function ElementLootBag:on_executed(instigator)
		return
	end
end