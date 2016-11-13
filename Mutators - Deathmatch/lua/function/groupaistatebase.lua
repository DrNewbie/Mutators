_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

TMP_mutator_saving.data = TMP_mutator_saving.data or {}

TMP_mutator_saving.TMP_Var = TMP_mutator_saving.TMP_Var or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement = TMP_mutator_saving.TMP_Var.MissionScriptElement or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch or {}
TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn = TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn or {}

Hooks:PostHook(GroupAIStateBase, "report_criminal_downed", "MutatorDeathMatch_report_criminal_downed_Init", function(gab, unit, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorDeathMatch", MutatorDeathMatch) then
		local _peer = managers.network:session():peer_by_unit(unit)
		if _peer then
			if _peer:id() == 1 then
				local player = managers.player:local_player()
				managers.player:force_drop_carry()
				managers.statistics:downed({ death = true })
				IngameFatalState.on_local_player_dead()
				game_state_machine:change_state_by_name("ingame_waiting_for_respawn")
				player:character_damage():set_invulnerable(true)
				player:character_damage():set_health(0)
				player:base():_unregister()
				player:base():set_slot(player, 0)
			else
				unit:network():send("sync_player_movement_state", "incapacitated", 0, unit:id())
				unit:network():send_to_unit({"spawn_dropin_penalty", true, nil, 0, nil, nil })
				managers.groupai:state():on_player_criminal_death(_peer:id())
			end
			TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn[_peer:id()] = {ready = true, t = 0, id = _peer:id()}
		else
			TMP_mutator_saving.TMP_Var.MissionScriptElement.MutatorDeathMatch.Respawn[unit:key()] = {ready = true, t = 0, id = 0}
		end
	end
end )