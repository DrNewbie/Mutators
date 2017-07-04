Hooks:Add("LocalizationManagerPostInit", "MutatorDeathMatch_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_deathmatch"] = "Deathmatch",
		["mutator_deathmatch_desc"] = "Block and stop something so you can do Deathmatch with your friends.",
		["mutator_deathmatch_longdesc"] = "This mutator require 'Friendly Fire'"
	})
end)

MutatorDeathMatch = MutatorDeathMatch or class(BaseMutator)
MutatorDeathMatch._type = "MutatorDeathMatch"
MutatorDeathMatch.name_id = "mutator_deathmatch"
MutatorDeathMatch.desc_id = "mutator_deathmatch_desc"
MutatorDeathMatch.has_options = false
MutatorDeathMatch.reductions = {money = 1, exp = 1}
MutatorDeathMatch.categories = {"gameplay"}
MutatorDeathMatch.icon_coords = {10, 1}

Hooks:PostHook(MutatorDeathMatch, "set_enabled", "MutatorDeathMatch_set_enabled", function(mm, enable)
	if managers.mutators then
		_MM = managers.mutators:get_mutator_from_id("MutatorFriendlyFire") or nil
		if _MM then
			_MM:set_enabled(enable)
		end
	end
end )

function MutatorDeathMatch:request_player_spawn(peer_to_spawn, pos, rot, ai)
	if Network:is_client() then
		return
	else
		local pos_rot = managers.criminals:get_valid_player_spawn_pos_rot()
		if not pos_rot and managers.network then
			local spawn_point = managers.network:session() and managers.network:session():get_next_spawn_point() or managers.network:spawn_point(1)
			pos_rot = spawn_point and spawn_point.pos_rot
		end
		if pos_rot then
			pos_rot[1] = pos and pos or pos_rot[1]
			pos_rot[2] = rot and rot or pos_rot[2]
			if ai then
				local _criminals_to_respawn = managers.trade._criminals_to_respawn or {}
				local _crim = nil
				for _, crim in ipairs(_criminals_to_respawn) do
					if crim.ai then
						_crim = crim
						break
					end
				end
				if _crim then
					managers.trade:criminal_respawn(pos_rot[1], pos_rot[2], _crim)
				else
					local character_name = managers.criminals:get_free_character_name()
					local lvl_tweak_data = Global.level_data and Global.level_data.level_id and tweak_data.levels[Global.level_data.level_id]
					local unit_folder = lvl_tweak_data and lvl_tweak_data.unit_suit or "suit"
					local ai_character_id = managers.criminals:character_static_data_by_name(character_name).ai_character_id
					local unit_name = Idstring(tweak_data.blackmarket.characters[ai_character_id].npc_unit)
					local unit = World:spawn_unit(unit_name, pos_rot[1], pos_rot[2])
					managers.network:session():send_to_peers_synched("set_unit", unit, character_name, "", 0, 0, tweak_data.levels:get_default_team_ID("player"))
					managers.criminals:add_character(character_name, unit, nil, true)
					unit:movement():set_character_anim_variables()
					unit:brain():set_spawn_ai({
						init_state = "idle",
						params = {scan = true},
						objective = objective
					})
					unit:brain():set_active(true)
				end
				return
			end
			local peer_id = peer_to_spawn or 1
			local crim_name = managers.criminals:character_name_by_peer_id(peer_id)
			local first_crim = managers.trade:get_criminal_to_trade()
			if first_crim and first_crim.id == crim_name then
				managers.trade:cancel_trade()
			end
			managers.trade:sync_set_trade_spawn(crim_name)
			managers.network:session():send_to_peers_synched("set_trade_spawn", crim_name)
			local sp_id = "IngameWaitingForRespawnState"
			local spawn_point = {
				position = pos_rot[1],
				rotation = pos_rot[2]
			}
			managers.network:register_spawn_point(sp_id, spawn_point)
			managers.network:session():spawn_member_by_id(peer_id, sp_id, true)
			managers.network:unregister_spawn_point(sp_id)
		end
		local player_unit = managers.player:player_unit()
		if player_unit then
			managers.hud:set_teammate_weapon_firemode(HUDManager.PLAYER_PANEL, 1, player_unit:inventory():unit_by_selection(1):base():fire_mode())
			managers.hud:set_teammate_weapon_firemode(HUDManager.PLAYER_PANEL, 2, player_unit:inventory():unit_by_selection(2):base():fire_mode())
		end
	end
end