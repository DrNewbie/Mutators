local access_type_all = {walk = true, acrobatic = true}

function MutatorEnemyReplacer:_get_unit_group_tank(difficulty_index)
	if not self._groups.tank then
		if difficulty_index < 6 then
			self._groups.tank = {
				unit_types = {
					america = {
						Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
						Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2")
					},
					russia = {
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870")
					}
				},
				access = access_type_all,
				special_type = "tank"
			}
		elseif difficulty_index <= 7 then
			self._groups.tank = {
				unit_types = {
					america = {
						Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"),
						Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3")
					},
					russia = {
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"),
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg")
					}
				},
				access = access_type_all,
				special_type = "tank"
			}
		else
			self._groups.tank = {
				unit_types = {
					america = {
						Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"),
						Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"),
						Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3")
					},
					russia = {
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"),
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
						Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg")
					}
				},
				access = access_type_all,
				special_type = "tank"
			}
		end
	end
	if managers.mutators:is_mutator_active(MutatorShieldDozers) then
		local _enable_medicdozer, _enable_minidozer = managers.mutators:modify_value("MutatorEnemyReplacer:_get_unit_group_tank")
		if _enable_medicdozer then
			table.insert(self._groups.tank.unit_types.america, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
			table.insert(self._groups.tank.unit_types.russia, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
		end
		if _enable_minidozer then
			table.insert(self._groups.tank.unit_types.america, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun"))
			table.insert(self._groups.tank.unit_types.russia, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun"))
		end
	end
	return self._groups.tank
end