_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

TMP_mutator_saving.data = TMP_mutator_saving.data or {}

Hooks:PostHook(GroupAIStateBase, "report_criminal_downed", "MutatorZeroDown_report_criminal_downed_Init", function(gab, unit, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorZeroDown") then
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
		end
	end
end )