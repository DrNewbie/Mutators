_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if Network:is_client() then
	return
end

TMP_mutator_saving.data = TMP_mutator_saving.data or {}
TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn or {}

Hooks:PreHook(UnitNetworkHandler, "sync_contour_state", "MutatorDeathMatch_Client_Down", function(unet, unit, ...)
	if not Network:is_client() and TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		local _peer = managers.network:session():peer_by_unit(unit)
		if _peer then
			TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn[_peer:id()] = {ready = true, t = 0, id = _peer:id()}
			unit:network():send("sync_player_movement_state", "incapacitated", 0, unit:id())
			unit:network():send_to_unit({"spawn_dropin_penalty", true, nil, 0, nil, nil })
			managers.groupai:state():on_player_criminal_death(_peer:id())
		end
	end
end)