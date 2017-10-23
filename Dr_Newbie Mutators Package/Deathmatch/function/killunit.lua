_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if Network:is_client() then
	return
end

TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run or 0
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn or {}

Hooks:Add("GameSetupUpdate", "MutatorDeathMatchGameSetupUpdate", function(t, dt)
	if Network:is_client() then
		return
	end
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		if Utils:IsInHeist() then
			if TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run > t then
				return
			end
			local _rt = math.round(t)
			TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Delay_Run = _rt + 5
			for _, data in pairs(managers.enemy:all_enemies()) do
				if data.unit and alive(data.unit) and data.unit:brain() then
					data.unit:brain():set_active(false, true)
				else
					data.unit:set_slot(0)
				end
			end
			if managers.mutators then
				_MM = managers.mutators:get_mutator_from_id("MutatorDeathMatch") or nil
			end
			if _MM then
				local _Respawn = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn or {}
				for id, data in pairs(_Respawn) do
					if data.ready then
						if data.t == 0 then
							TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn[id].t = _rt + 1
						elseif _rt > data.t then
							local _Spawn_Position_List = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Spawn_Position or {}
							local _Spawn_Position = _Spawn_Position_List[math.random(#_Spawn_Position_List)]
							TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn[id].ready = false
							if data.id > 0 then
								_MM:request_player_spawn(data.id, _Spawn_Position)
							else
								_MM:request_player_spawn(0, _Spawn_Position, _, true)
							end
						end
					end
				end
			end
		end
		TMP_mutator_saving.TMP_Var.IsInHeist = Utils:IsInHeist()
	end
end)