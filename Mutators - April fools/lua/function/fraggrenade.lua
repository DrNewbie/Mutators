_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if not TMP_mutator_saving:Is_This_Enable("MutatorAprilFools", MutatorAprilFools) then
	function FragGrenade:clbk_impact(tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity, new_velocity, direction, damage, ...)
		local reflect = other_unit and other_unit:vehicle() and other_unit:vehicle():is_active()
		if reflect then
			return
		end
		self:_detonate(tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity, new_velocity, direction, damage, ...)
	end

	function FragGrenade:_on_collision(col_ray)
		local reflect = col_ray and col_ray.unit:vehicle() and col_ray.unit:vehicle():is_active()
		if reflect then
			return
		end
		self:_detonate()
	end
end