_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local _MutatorHugePunch_PlayerDamage_damage_melee = PlayerDamage.damage_melee

function PlayerDamage:damage_melee(attack_data)
	if TMP_mutator_saving:Is_This_Enable("MutatorHugePunch", MutatorHugePunch) then
		if attack_data.attacker_unit and attack_data.attacker_unit:alive() then
			if attack_data.attacker_unit:base()._tweak_table == "tank" then
				mvector3.multiply(attack_data.push_vel, 3)
			end
		end
	end
	return _MutatorHugePunch_PlayerDamage_damage_melee(self, attack_data)
end