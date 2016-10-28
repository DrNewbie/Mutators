_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(CopDamage, "init", "MutatorRationing_CopDamage_init", function(copp, ...)
	if not TMP_mutator_saving:Is_This_Enable("MutatorRationing") then
		return
	end
	copp:set_pickup(nil)
end )

local Mutator_DozersKilledSinceAmmo = 0
local Mutator_DropAmmoChance = {
	[1] = 0.08,
	[2] = 0.15,
	[3] = 0.30,
	[4] = 0.65,
	[5] = 1.00,
}

Hooks:PostHook(CopDamage, "die", "MutatorRationing_CopDamage_die", function(copp, ...)
	if not TMP_mutator_saving:Is_This_Enable("MutatorRationing") then
		return
	end
	if copp._unit:base()._tweak_table == "tank" then
		if LuaNetworking:IsMultiplayer() and LuaNetworking:IsHost() then
			Mutator_DozersKilledSinceAmmo = Mutator_DozersKilledSinceAmmo + 1
			local dozers = Mutator_DozersKilledSinceAmmo
			if dozers > #Mutator_DropAmmoChance then
				dozers = #Mutator_DropAmmoChance
			end
			if Mutator_DropAmmoChance[Mutator_DozersKilledSinceAmmo] > math.random() then
				local pos = copp._unit:position()
				local rot = Rotation(copp._unit:movement():m_head_rot():yaw(), 0, 0)
				AmmoBagBase.spawn(pos, rot, 0)
				Mutator_DozersKilledSinceAmmo = 0
			end
		end
	end
end )