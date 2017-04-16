InstantRicochetBulletBase = InstantRicochetBulletBase or class(InstantBulletBase)
InstantRicochetBulletBase.TRAIL_EFFECT = Idstring("effects/particles/weapons/sniper_trail")
local idstr_trail = Idstring("trail")
local idstr_simulator_length = Idstring("simulator_length")
local idstr_size = Idstring("size")
local reflect_result = Vector3()
function InstantRicochetBulletBase:on_collision(col_ray, weapon_unit, user_unit, damage, blank, no_sound)
	local from_pos, to_pos, ignore_unit, latest_data
	from_pos = user_unit:position() + Vector3(0, 0, 150)
	to_pos = col_ray.hit_position
	ignore_unit = user_unit
	for i = 1, tweak_data.ammo.ricochet.max_ricochets + 1 do
		if i > 1 then
			local weapon_base = alive(weapon_unit) and weapon_unit:base()
			if weapon_base and weapon_base.check_autoaim then
				local autoaim = weapon_base:check_autoaim(from_pos, reflect_result, nil, nil, tweak_data.ammo.ricochet.autohit)
				if autoaim then
					mvector3.set(reflect_result, autoaim.ray)
					col_ray = autoaim
				end
			end
			if not self._trail_length then
				self._trail_length = World:effect_manager():get_initial_simulator_var_vector2(self.TRAIL_EFFECT, idstr_trail, idstr_simulator_length, idstr_size)
			end
			local trail = World:effect_manager():spawn({
				effect = self.TRAIL_EFFECT,
				position = from_pos,
				normal = reflect_result
			})
			if col_ray then
				mvector3.set_y(self._trail_length, col_ray.distance)
				World:effect_manager():set_simulator_var_vector2(trail, idstr_trail, idstr_simulator_length, idstr_size, self._trail_length)
			end
		end
		mvector3.set_zero(reflect_result)
		mvector3.set(reflect_result, col_ray.ray)
		mvector3.add(reflect_result, -2 * col_ray.ray:dot(col_ray.normal) * col_ray.normal)
		local ang = math.abs(mvector3.angle(col_ray.ray, reflect_result))
		local can_ricochet = not (ang < tweak_data.ammo.ricochet.angles[1]) and not (ang > tweak_data.ammo.ricochet.angles[2])
		mvector3.spread(reflect_result, math.random(tweak_data.ammo.ricochet.spread_angle[1], tweak_data.ammo.ricochet.spread_angle[2]))
		from_pos = col_ray.hit_position + col_ray.normal
		ignore_unit = col_ray.unit
		latest_data = InstantRicochetBulletBase.super.on_collision(self, col_ray, weapon_unit, user_unit, damage, blank, no_sound)
		managers.game_play_central:play_impact_sound_and_effects({col_ray = col_ray, no_sound = no_sound})
		if not can_ricochet then
			return latest_data
		end
		if alive(col_ray.unit) and col_ray.unit:character_damage() then
			return latest_data
		else
			local ray_data = World:raycast("ray", from_pos, from_pos + reflect_result * 50000, "slot_mask", self:bullet_slotmask())
			if ray_data then
				col_ray = ray_data
				to_pos = col_ray.hit_position
			else
				to_pos = false
				break
			end
		end
	end
	return latest_data
end
function InstantRicochetBulletBase:play_impact_sound_and_effects(col_ray, no_sound)
end