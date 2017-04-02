_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function WeaponFactoryManager:get_ammo_data_from_weapon(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local t = {}
	for _, id in ipairs(self:get_assembled_blueprint(factory_id, blueprint)) do
		if factory.parts[id].type == "ammo" then
			local part = self:_part_data(id, factory_id)
			if not TMP_mutator_saving:Is_This_Enable("MutatorAprilFools", MutatorAprilFools) then
				if tostring(part.custom_stats.bullet_class) == "InstantRicochetBulletBase" then
				
				else
					t = part.custom_stats
				end
			else
				t = part.custom_stats
			end
		end
	end
	return t
end