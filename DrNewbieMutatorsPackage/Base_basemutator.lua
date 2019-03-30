_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}


Hooks:Add("LocalizationManagerPostInit", "Dr_NewbieMutatorsPackage_loc", function()
	LocalizationManager:add_localized_strings({
		["mutator_bodyshotonly"] = "Bodyshot Only",
		["mutator_bodyshotonly_desc"] = "Only bodyshot will do damage",
		["mutator_bodyshotonly_longdesc"] = "Only bodyshot will do damage",
		["mutator_AprilFools"] = "April Fools",
		["mutator_AprilFools_desc"] = "Enable or Disable something that come April Fools",
		["mutator_AprilFools_longdesc"] = "Enable or Disable something that come April Fools",
		["mutator_deathmatch"] = "Deathmatch",
		["mutator_deathmatch_desc"] = "Block and stop something so you can do Deathmatch with your friends.",
		["mutator_deathmatch_longdesc"] = "This mutator require 'Friendly Fire'",
		["mutator_hardlinebreakout"] = "Hardline Breakout",
		["mutator_hardlinebreakout_desc"] = "Random bomb from nowhere",
		["mutator_hardlinebreakout_longdesc"] = "Random bomb from nowhere",
		["mutator_headshotonly"] = "Headshot Only",
		["mutator_headshotonly_desc"] = "Only headshot will do damage",
		["mutator_headshotonly_longdesc"] = "Only headshot will do damage",
		["mutator_hugepunch"] = "Huge Punch",
		["mutator_hugepunch_desc"] = "Bulldozer will give you a huge punch",
		["mutator_hugepunch_longdesc"] = "Bulldozer will give you a huge punch",
		["mutator_bebulldozer"] = "I want to be bulldozer",
		["mutator_bebulldozer_desc"] = "Sniper, Medic, Tazer, Shield, Cloaker have as much health as a Bulldozer",
		["mutator_bebulldozer_longdesc"] = "This mutator require 'Because of Training'",
		["mutator_professional"] = "Professional",
		["mutator_professional_desc"] = "You can't restart.",
		["mutator_professional_longdesc"] = "You can't restart.",
		["mutator_quickfix"] = "Quick-Fix",
		["mutator_quickfix_desc"] = "Decrease Medic cooldown. The more he saved, the less he required.",
		["mutator_quickfix_longdesc"] = "Decrease Medic cooldown. The more he saved, the less he required.",
		["mutator_randomizer"] = "Randomizer",
		["mutator_randomizer_desc"] = "Your loadout will be random.",
		["mutator_randomizer_longdesc"] = "Your loadout will be random.",
		["mutator_flyingenemy"] = "Flying Enemy",
		["mutator_flyingenemy_desc"] = "Enemies will move to somewhere around you",
		["mutator_flyingenemy_longdesc"] = "Enemies will move to somewhere around you",
		["mutator_zerodown"] = "Zero Down",
		["mutator_zerodown_desc"] = "You will directly go to custody when you down",
		["mutator_zerodown_longdesc"] = "You will directly go to custody when you down",
		["mutator_realism"] = "Realism",
		["mutator_realism_desc"] = "Outlines and HUD are disabled",
		["mutator_realism_longdesc"] = "Outlines and HUD are disabled",
		["mutator_rationing"] = "Rationing",
		["mutator_rationing_desc"] = "Enemies no longer drop ammo. Bulldozers have a chance to drop an ammo bag where they die.",
		["mutator_rationing_longdesc"] = "Enemies no longer drop ammo. Bulldozers have a chance to drop an ammo bag where they die."
	})
end)

MutatorBodyshotOnly = MutatorBodyshotOnly or class(BaseMutator)
MutatorBodyshotOnly._type = "MutatorBodyshotOnly"
MutatorBodyshotOnly.name_id = "mutator_bodyshotonly"
MutatorBodyshotOnly.desc_id = "mutator_bodyshotonly_desc"
MutatorBodyshotOnly.has_options = false
MutatorBodyshotOnly.reductions = {money = 0, exp = 0}
MutatorBodyshotOnly.categories = {"gameplay"}
MutatorBodyshotOnly.icon_coords = {10, 1}
MutatorBodyshotOnly.incompatiblities = {
	"MutatorHeadshotOnly"
}

MutatorAprilFools = MutatorAprilFools or class(BaseMutator)
MutatorAprilFools._type = "MutatorAprilFools"
MutatorAprilFools.name_id = "mutator_AprilFools"
MutatorAprilFools.desc_id = "mutator_AprilFools_desc"
MutatorAprilFools.has_options = false
MutatorAprilFools.reductions = {money = 0, exp = 0}
MutatorAprilFools.categories = {"gameplay"}
MutatorAprilFools.icon_coords = {10, 1}

MutatorDeathMatch = MutatorDeathMatch or class(BaseMutator)
MutatorDeathMatch._type = "MutatorDeathMatch"
MutatorDeathMatch.name_id = "mutator_deathmatch"
MutatorDeathMatch.desc_id = "mutator_deathmatch_desc"
MutatorDeathMatch.has_options = false
MutatorDeathMatch.reductions = {money = 1, exp = 1}
MutatorDeathMatch.categories = {"gameplay"}
MutatorDeathMatch.icon_coords = {10, 1}

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

MutatorHardlineBreakout = MutatorHardlineBreakout or class(BaseMutator)
MutatorHardlineBreakout._type = "MutatorHardlineBreakout"
MutatorHardlineBreakout.name_id = "mutator_hardlinebreakout"
MutatorHardlineBreakout.desc_id = "mutator_hardlinebreakout_desc"
MutatorHardlineBreakout.has_options = false
MutatorHardlineBreakout.reductions = {money = 0, exp = 0}
MutatorHardlineBreakout.categories = {"gameplay"}
MutatorHardlineBreakout.icon_coords = {10, 1}

MutatorHeadshotOnly = MutatorHeadshotOnly or class(BaseMutator)
MutatorHeadshotOnly._type = "MutatorHeadshotOnly"
MutatorHeadshotOnly.name_id = "mutator_headshotonly"
MutatorHeadshotOnly.desc_id = "mutator_headshotonly_desc"
MutatorHeadshotOnly.has_options = false
MutatorHeadshotOnly.reductions = {money = 0, exp = 0}
MutatorHeadshotOnly.categories = {"gameplay"}
MutatorHeadshotOnly.icon_coords = {10, 1}
MutatorHeadshotOnly.incompatiblities = {
	"MutatorBodyshotOnly"
}

MutatorHugePunch = MutatorHugePunch or class(BaseMutator)
MutatorHugePunch._type = "MutatorHugePunch"
MutatorHugePunch.name_id = "mutator_hugepunch"
MutatorHugePunch.desc_id = "mutator_hugepunch_desc"
MutatorHugePunch.has_options = false
MutatorHugePunch.reductions = {money = 0, exp = 0}
MutatorHugePunch.categories = {"gameplay"}
MutatorHugePunch.icon_coords = {10, 1}

MutatorBeBulldozer = MutatorBeBulldozer or class(BaseMutator)
MutatorBeBulldozer._type = "MutatorBeBulldozer"
MutatorBeBulldozer.name_id = "mutator_bebulldozer"
MutatorBeBulldozer.desc_id = "mutator_bebulldozer_desc"
MutatorBeBulldozer.has_options = false
MutatorBeBulldozer.reductions = {money = 0, exp = 0}
MutatorBeBulldozer.categories = {"enemies"}
MutatorBeBulldozer.icon_coords = {10, 1}

MutatorsProfessional = MutatorsProfessional or class(BaseMutator)
MutatorsProfessional._type = "MutatorsProfessional"
MutatorsProfessional.name_id = "mutator_professional"
MutatorsProfessional.desc_id = "mutator_professional_desc"
MutatorsProfessional.has_options = false
MutatorsProfessional.reductions = {money = 0, exp = 0}
MutatorsProfessional.categories = {"gameplay"}
MutatorsProfessional.icon_coords = {10, 1}

MutatorQuickFix = MutatorQuickFix or class(BaseMutator)
MutatorQuickFix._type = "MutatorQuickFix"
MutatorQuickFix.name_id = "mutator_quickfix"
MutatorQuickFix.desc_id = "mutator_quickfix_desc"
MutatorQuickFix.has_options = false
MutatorQuickFix.reductions = {money = 0, exp = 0}
MutatorQuickFix.categories = {"gameplay"}
MutatorQuickFix.icon_coords = {10, 1}

MutatorRandomizer = MutatorRandomizer or class(BaseMutator)
MutatorRandomizer._type = "MutatorRandomizer"
MutatorRandomizer.name_id = "mutator_randomizer"
MutatorRandomizer.desc_id = "mutator_randomizer_desc"
MutatorRandomizer.has_options = false
MutatorRandomizer.reductions = {money = 0, exp = 0}
MutatorRandomizer.categories = {"gameplay"}
MutatorRandomizer.icon_coords = {10, 1}

MutatorRationing = MutatorRationing or class(BaseMutator)
MutatorRationing._type = "MutatorRationing"
MutatorRationing.name_id = "mutator_rationing"
MutatorRationing.desc_id = "mutator_rationing_desc"
MutatorRationing.has_options = false
MutatorRationing.reductions = {money = 0, exp = 0}
MutatorRationing.categories = {"gameplay"}
MutatorRationing.icon_coords = {10, 1}

MutatorRealism = MutatorRealism or class(BaseMutator)
MutatorRealism._type = "MutatorRealism"
MutatorRealism.name_id = "mutator_realism"
MutatorRealism.desc_id = "mutator_realism_desc"
MutatorRealism.has_options = false
MutatorRealism.reductions = {money = 0, exp = 0}
MutatorRealism.categories = {"gameplay"}
MutatorRealism.icon_coords = {10, 1}

function MutatorRealism:setup()
end

MutatorFlyingEnemy = MutatorFlyingEnemy or class(BaseMutator)
MutatorFlyingEnemy._type = "MutatorFlyingEnemy"
MutatorFlyingEnemy.name_id = "mutator_flyingenemy"
MutatorFlyingEnemy.desc_id = "mutator_flyingenemy_desc"
MutatorFlyingEnemy.has_options = false
MutatorFlyingEnemy.reductions = {money = 0, exp = 0}
MutatorFlyingEnemy.categories = {"gameplay"}
MutatorFlyingEnemy.icon_coords = {10, 1}
MutatorFlyingEnemy.incompatiblities = {}

MutatorZeroDown = MutatorZeroDown or class(BaseMutator)
MutatorZeroDown._type = "MutatorZeroDown"
MutatorZeroDown.name_id = "mutator_zerodown"
MutatorZeroDown.desc_id = "mutator_zerodown_desc"
MutatorZeroDown.has_options = false
MutatorZeroDown.reductions = {money = 0, exp = 0}
MutatorZeroDown.categories = {"gameplay"}
MutatorZeroDown.icon_coords = {10, 1}

Hooks:PostHook(MutatorDeathMatch, "set_enabled", "Dr_NewbieMutatorsPackage_set_enabled", function(mm, enable)
	if managers.mutators then
		_MM = managers.mutators:get_mutator_from_id("MutatorFriendlyFire") or nil
		if _MM then
			_MM:set_enabled(enable)
		end
		_MM = managers.mutators:get_mutator_from_id("MutatorEnemyHealth") or nil
		if _MM then
			_MM:set_enabled(enable)
		end
	end
end )