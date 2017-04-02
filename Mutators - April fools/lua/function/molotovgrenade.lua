_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function MolotovGrenade:clbk_impact(tag, unit, body, other_unit, other_body, position, normal, collision_velocity, velocity, other_velocity)
	if not TMP_mutator_saving:Is_This_Enable("MutatorAprilFools", MutatorAprilFools) then
		self:_detonate(normal)
	else
		self._unit:push_at(1, normal * math.random(50, 100), self._unit:position())
	end
	return
end