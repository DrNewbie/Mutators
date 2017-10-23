Hooks:Add("LocalizationManagerPostInit", "SafeHousePlus_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_specials_override_sniper"] = "Sniper",
	})
end)

function MutatorEnemyReplacer:setup_options_gui(node)
	local params = {
		name = "enemy_selector_choice",
		text_id = "mutator_specials_override_select",
		callback = "_update_mutator_value",
		update_callback = callback(self, self, "_update_selected_enemy"),
		filter = true
	}
	local data_node = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "mutator_specials_override_tank",
			value = "tank"
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_taser",
			value = "taser"
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_shield",
			value = "shield"
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_spooc",
			value = "spooc"
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_medic",
			value = "medic"
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_sniper",
			value = "sniper"
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_value(self:get_override_enemy())
	node:add_item(new_item)
	self._node = node
	return new_item
end

function MutatorEnemyReplacer:_get_unit_group_sniper(difficulty_index)
	if not self._groups.sniper then
		self._groups.sniper = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_sniper_2/ene_sniper_2"),
					Idstring("units/payday2/characters/ene_sniper_1/ene_sniper_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_sniper_svd_snp/ene_akan_cs_swat_sniper_svd_snp")
				}
			},
			access = {walk = true, acrobatic = true},
			special_type = "sniper"
		}
	end
	return self._groups.sniper
end