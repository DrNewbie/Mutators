Hooks:Add("LocalizationManagerPostInit", "SafeHousePlus_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_medidozer"] = "BFFs Plus",
		["mutator_medidozer_desc"] = "Special enemies are replaced with others, normal enemies are replaced with Medic",
		["mutator_specials_override_phalanx"] = "Phalanx",
	})
end)

MutatorMediDozer = class(MutatorEnemyReplacer)

MutatorMediDozer._type = "MutatorMediDozer"
MutatorMediDozer.name_id = "mutator_medidozer"
MutatorMediDozer.desc_id = "mutator_medidozer_desc"
MutatorMediDozer.reductions = {money = 0.25, exp = 0.25}
MutatorMediDozer.categories = {"enemies"}
MutatorMediDozer.incompatibility_tags = {
	"replaces_units"
}
MutatorMediDozer.icon_coords = {8, 1}

function MutatorMediDozer:name(lobby_data)
	local name = MutatorMediDozer.super.name(self)
	if self:_mutate_name("bffs_override_enemy") then
		return string.format("%s - %s", name, managers.localization:text("mutator_specials_override_" .. tostring(self:value("bffs_override_enemy"))))
	else
		return name
	end
end

function MutatorMediDozer:register_values(mutator_manager)
	self:register_value("bffs_override_enemy", self:default_override_enemy(), "oe")
end

function MutatorMediDozer:get_override_enemy()
	return self:value("bffs_override_enemy")
end

function MutatorMediDozer:_update_selected_enemy(item)
	self:set_value("bffs_override_enemy", item:value())
end

function MutatorMediDozer:reset_to_default()
	self:clear_values()
	if self._node then
		local slider = self._node:item("bffs_pluse_enemy_selector_choice")
		if slider then
			slider:set_value(self:default_override_enemy())
		end
	end
end

function MutatorMediDozer:setup_options_gui(node)
	local params = {
		name = "bffs_pluse_enemy_selector_choice",
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
			text_id = "mutator_specials_override_phalanx",
			value = "phalanx"
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_value(self:get_override_enemy())
	node:add_item(new_item)
	self._node = node
	return new_item
end

function MutatorMediDozer:_get_unit_group_tank()
end

function MutatorMediDozer:_get_unit_group_taser()
end

function MutatorMediDozer:_get_unit_group_spooc()
end

function MutatorMediDozer:_get_unit_group_shield()
end

function MutatorMediDozer:_get_unit_group_medic()
end

local access_type_walk_only = {walk = true}
local access_type_all = {walk = true, acrobatic = true}
function MutatorMediDozer:modify_unit_categories(group_ai_tweak, difficulty_index)
	group_ai_tweak.special_unit_spawn_limits = {
		tank = 0,
		taser = 0,
		spooc = 0,
		shield = 0,
		medic = math.huge
	}
	if self:get_override_enemy() == "phalanx" then
		group_ai_tweak.special_unit_spawn_limits.shield = math.huge
	else
		group_ai_tweak.special_unit_spawn_limits[self:get_override_enemy()] = math.huge
	end
	group_ai_tweak.unit_categories.medic_R870 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4"),
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4")
			},
			russia = {
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4"),
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4")
			}
		},
		access = access_type_all,
		special_type = "medic"
	}
	group_ai_tweak.unit_categories.medic_R870 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870"),
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
			},
			russia = {
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870"),
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
			}
		},
		access = access_type_all,
		special_type = "medic"
	}
	local _unit_categories_type = {
		tank = "FBI_tank",
		taser = "CS_tazer",
		spooc = "spooc",
		shield = "FBI_shield",
		phalanx = "Phalanx_minion"
	}
	for group, units_data in pairs(group_ai_tweak.unit_categories) do
		if units_data.special_type then
			if units_data.special_type ~= self:get_override_enemy() and units_data.special_type ~= "medic" then
				group_ai_tweak.unit_categories[group] = group_ai_tweak.unit_categories[_unit_categories_type[self:get_override_enemy()]]
			end
		elseif string.find(group, "r870") then
			group_ai_tweak.unit_categories[group] = group_ai_tweak.unit_categories.medic_R870
		else
			group_ai_tweak.unit_categories[group] = group_ai_tweak.unit_categories.medic_M4
		end
	end
end