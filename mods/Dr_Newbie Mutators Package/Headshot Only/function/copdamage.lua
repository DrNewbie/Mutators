_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(CopDamage, "init", "MutatorHeadshotOnly_CopDamage_init", function(cop, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorHeadshotOnly", MutatorHeadshotOnly) then
		cop:set_invulnerable(true)
	end
end )

local _MutatorHeadshotOnly_CopDamage_damage_bullet = CopDamage.damage_bullet

function CopDamage:damage_bullet(attack_data)
	if TMP_mutator_saving:Is_This_Enable("MutatorHeadshotOnly", MutatorHeadshotOnly) then
		local head = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		if head then
			self:set_invulnerable(false)
			local _r = _MutatorHeadshotOnly_CopDamage_damage_bullet(self, attack_data)
			self:set_invulnerable(true)
			return _r
		end
	end
	return _MutatorHeadshotOnly_CopDamage_damage_bullet(self, attack_data)
end