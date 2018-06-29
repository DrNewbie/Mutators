Hooks:PostHook(WeaponFactoryTweakData, "init", "Backup_wpn_fps_upg_pis_adam", function(self)
	self.parts.wpn_fps_upg_pis_adam = {
		pcs = {},
		type = "ammo",
		name_id = "bm_wp_upg_a_ricochet",
		a_obj = "a_body",
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		texture_bundle_folder = "mmo",
		is_a_unlockable = false,
		stats = {},
		custom_stats = {
			bullet_class = "InstantRicochetBulletBase"
		},
		internal_part = true,
		sub_type = "adam"
	}
	for factory_id, _ in pairs(self) do
		if self[factory_id] and self[factory_id].default_blueprint then
			if not self[factory_id].forced_parts then
				self[factory_id].forced_parts = {}
			end
			table.insert(self[factory_id].forced_parts, "wpn_fps_upg_pis_adam")
		end
	end
end)