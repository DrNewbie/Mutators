Hooks:Add("LocalizationManagerPostInit", "MutatorMediDozer_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_medidozer"] = "BFFs Plus",
		["mutator_medidozer_desc"] = "Special enemies are replaced with one, normal enemies are replaced with other",
		["mutator_specials_override_phalanx"] = "Phalanx",
		["mutator_specials_override_select_normal"] = "Normal Unit",
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
	if self:_mutate_name("bffs_override_enemy_special") then
		local _special = managers.localization:text("mutator_specials_override_" .. tostring(self:value("bffs_override_enemy_special")))
		local _normal = managers.localization:text("mutator_specials_override_" .. tostring(self:value("bffs_override_enemy_normal")))
		return string.format("%s - %s + %s", name, _special, _normal)
	else
		return name
	end
end

function MutatorMediDozer:register_values(mutator_manager)
	self:register_value("bffs_override_enemy_special", self:default_override_enemy_special(), "oe")
	self:register_value("bffs_override_enemy_normal", self:default_override_enemy_normal(), "oe")
end

function MutatorMediDozer:get_override_enemy_special()
	return self:value("bffs_override_enemy_special")
end

function MutatorMediDozer:get_override_enemy_normal()
	return self:value("bffs_override_enemy_normal")
end

function MutatorMediDozer:_update_selected_enemy_special(item)
	self:set_value("bffs_override_enemy_special", item:value())
end

function MutatorMediDozer:_update_selected_enemy_normal(item)
	self:set_value("bffs_override_enemy_normal", item:value())
end

function MutatorMediDozer:default_override_enemy_special()
	return "tank"
end

function MutatorMediDozer:default_override_enemy_normal()
	return "medic"
end

function MutatorMediDozer:reset_to_default()
	self:clear_values()
	if self._node then
		local slider = self._node:item("bffs_pluse_enemy_selector_choice_special")
		if slider then
			slider:set_value(self:default_override_enemy_special())
		end
		slider = self._node:item("bffs_pluse_enemy_selector_choice_normal")
		if slider then
			slider:set_value(self:default_override_enemy_normal())
		end
	end
end

function MutatorMediDozer:setup_options_gui(node)
	local params = {
		name = "bffs_pluse_enemy_selector_choice_special",
		text_id = "mutator_specials_override_select",
		callback = "_update_mutator_value",
		update_callback = callback(self, self, "_update_selected_enemy_special"),
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
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_medic",
			value = "medic"
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_value(self:get_override_enemy_special())
	node:add_item(new_item)
	self._node = node
	
	local params = {
		name = "bffs_pluse_enemy_selector_choice_normal",
		text_id = "mutator_specials_override_select_normal",
		callback = "_update_mutator_value",
		update_callback = callback(self, self, "_update_selected_enemy_normal"),
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
		},
		{
			_meta = "option",
			text_id = "mutator_specials_override_medic",
			value = "medic"
		}
	}
	local new_item = node:create_item(data_node, params)
	new_item:set_value(self:get_override_enemy_normal())
	node:add_item(new_item)
	self._node = node
	return new_item
end

local access_type_walk_only = {walk = true}
local access_type_all = {walk = true, acrobatic = true}
function MutatorMediDozer:modify_unit_categories(group_ai_tweak, difficulty_index)
	group_ai_tweak.special_unit_spawn_limits = {
		tank = 0,
		taser = 0,
		spooc = 0,
		shield = 0,
		medic = 0
	}
	local _special = self:get_override_enemy_special()
	local _normal = self:get_override_enemy_normal()
	if _special == "phalanx" then
		group_ai_tweak.special_unit_spawn_limits.shield = math.huge
	else
		group_ai_tweak.special_unit_spawn_limits[_special] = math.huge
	end
	if _normal == "phalanx" then
		group_ai_tweak.special_unit_spawn_limits.shield = math.huge
	else
		group_ai_tweak.special_unit_spawn_limits[_normal] = math.huge
	end
	local _unit_categories = {
		tank = self:_get_unit_group_tank(difficulty_index),
		taser = self:_get_unit_group_taser(difficulty_index),
		spooc = self:_get_unit_group_spooc(difficulty_index),
		shield = self:_get_unit_group_shield(difficulty_index),
		medic = self:_get_unit_group_medic(difficulty_index),
		phalanx = group_ai_tweak.unit_categories["Phalanx_minion"]
	}
	for group, units_data in pairs(group_ai_tweak.unit_categories) do
		if units_data.special_type then
			if units_data.special_type ~= _special then
				group_ai_tweak.unit_categories[group] = _unit_categories[_special]
			end
		else
			group_ai_tweak.unit_categories[group] = _unit_categories[_normal]
		end
	end
end