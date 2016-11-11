_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run or 0

Hooks:Add("GameSetupUpdate", "MutatorDeathMatchGameSetupUpdate", function(t, dt)
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		if Utils:IsInHeist() then
			if TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run > t then
				return
			end
			TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run = math.round(t) + 1
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit and alive(data.unit) and data.unit:brain() then
					data.unit:brain():set_active(false, true)
				else
					data.unit:set_slot(0)
				end
			end
		end
		TMP_mutator_saving.TMP_Var.IsInHeist = Utils:IsInHeist()
	end
end)