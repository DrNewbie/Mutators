Hooks:PostHook(WeaponFactoryTweakData, "init", "Backup_wpn_fps_upg_pis_adam", function(self, ...)
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
	local weapons = {
		"wpn_fps_pis_rage",
		"wpn_fps_pis_peacemaker",
		"wpn_fps_pis_2006m",
		"wpn_fps_pis_usp",
		"wpn_fps_pis_g22c",
		"wpn_fps_pis_g26",
		"wpn_fps_pis_g17",
		"wpn_fps_pis_1911",
		"wpn_fps_pis_beretta",
		"wpn_fps_pis_pl14",
		"wpn_fps_pis_g18c",
		"wpn_fps_pis_deagle",
		"wpn_fps_pis_ppk",
		"wpn_fps_pis_p226",
		"wpn_fps_pis_c96",
		"wpn_fps_pis_hs2000",
		"wpn_fps_pis_sparrow",
		"wpn_fps_pis_packrat",
		"wpn_fps_jowi",
		"wpn_fps_x_1911",
		"wpn_fps_smg_x_akmsu",
		"wpn_fps_x_b92fs",
		"wpn_fps_x_deagle",
		"wpn_fps_pis_x_g17",
		"wpn_fps_pis_x_g22c",
		"wpn_fps_smg_x_mp5",
		"wpn_fps_smg_x_sr2",
		"wpn_fps_pis_x_usp",
		"wpn_fps_x_packrat",
		"wpn_fps_lmg_m134"
	}
	for _, factory_id in ipairs(weapons) do
		if self[factory_id] then
			if not self[factory_id].forced_parts then
				self[factory_id].forced_parts = {}
			end
			table.insert(self[factory_id].forced_parts, "wpn_fps_upg_pis_adam")
		end
	end
end)