_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(MutatorEnemyHealth, "modify_character_tweak_data", "F_"..Idstring("MutatorBeBulldozer"):key(), function(self, character_tweak)
	if TMP_mutator_saving:Is_This_Enable("MutatorBeBulldozer", MutatorBeBulldozer) then
		for _, character in ipairs({"taser", "shield", "spooc", "medic", "sniper"}) do
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
end)