core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local TMP_mutator_saving = _G.TMP_mutator_saving or {}

if not TMP_mutator_saving then
	return
end

TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.IsInHeist = false
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Block = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Block or 0

local _MutatorDeathMatch_MissionScriptElement_on_executed = MissionScriptElement.on_executed

function MissionScriptElement:on_executed(...)
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		local _NowTime = math.round(TimerManager:game():time())
		if TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Block == 0 then
			if TMP_mutator_saving.TMP_Var.IsInHeist then
				TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Block = _NowTime + 10
			end
		else
			if _NowTime > TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Block then
				return
			end
		end
	end
	return _MutatorDeathMatch_MissionScriptElement_on_executed(self, ...)
end
	