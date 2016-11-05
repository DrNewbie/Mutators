_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function MutatorEnemyHealth:modify_character_tweak_data(character_tweak)
	if character_tweak then
		print("[Mutators] Mutating character tweak data: ", self:id())
		for i, character in ipairs(character_tweak:enemy_list()) do
			if character_tweak[character] then
				print("[Mutators] Mutating health:", character, character_tweak[character].HEALTH_INIT, self:get_health_multiplier(), character_tweak[character].HEALTH_INIT * self:get_health_multiplier())
				character_tweak[character].HEALTH_INIT = character_tweak[character].HEALTH_INIT * self:get_health_multiplier()
			end
		end
		if TMP_mutator_saving:Is_This_Enable("MutatorBeBulldozer", MutatorBeBulldozer) then
			for i, character in ipairs({"taser", "shield", "spooc", "medic"}) do
				if character_tweak[character] then
					character_tweak[character].HEALTH_INIT = character_tweak["tank"].HEALTH_INIT
					character_tweak[character].use_animation_on_fire_damage = character_tweak["tank"].use_animation_on_fire_damage
					character_tweak[character].flammable = character_tweak["tank"].flammable
					character_tweak[character].can_be_tased = character_tweak["tank"].can_be_tased
					character_tweak[character].immune_to_knock_down = character_tweak["tank"].immune_to_knock_down
					character_tweak[character].immune_to_concussion = character_tweak["tank"].immune_to_concussion
					character_tweak[character].ecm_vulnerability = character_tweak["tank"].ecm_vulnerability
					character_tweak[character].ecm_hurts = character_tweak["tank"].ecm_hurts
					character_tweak[character].explosion_damage_mul = character_tweak["tank"].explosion_damage_mul
					character_tweak[character].move_speed = character_tweak["tank"].move_speed
				end
			end
		end
	end
end