MutatorShieldDozers = MutatorShieldDozers or class(BaseMutator)
MutatorShieldDozers._type = "MutatorShieldDozers"
MutatorShieldDozers.name_id = "mutator_shield_dozers"
MutatorShieldDozers.desc_id = "mutator_shield_dozers_desc"
MutatorShieldDozers.has_options = true
MutatorShieldDozers.reductions = {money = 0.5, exp = 0.5}
MutatorShieldDozers.categories = {"enemies"}
MutatorShieldDozers.icon_coords = {1, 2}
MutatorShieldDozers.shield_units = {
	"units/payday2/characters/ene_acc_shield_lights/ene_acc_shield_lights",
	"units/payday2/characters/ene_acc_shield_lights/ene_acc_shield_lights",
	"units/payday2/characters/ene_acc_shield_small/shield_small"
}
MutatorShieldDozers.allowed_tweak_datas = {"tank", "tank_mini", "tank_medic", "tank_hw"}
MutatorShieldDozers.all_toggle = {
	health_rebuff = true,
	use_mini = true,
	enable_medicdozer = true,
	enable_minidozer = true,
	can_be_tased = false,
	super_speed = true,
	steal_loot = true,
	immune_to_knock_down = true,
	immune_to_concussion = true,
	shield_knocked = false,
	immune_to_knockback = true,
	use_animation_on_fire_damage = false,
	flammable = true,
	rescue_hostages = true,
	use_shield = true
}

function MutatorShieldDozers:register_values(mutator_manager)
	for k, v in pairs(self.all_toggle) do
		self:register_value("overdozer_" .. k , v, "ms")
	end
end

for k, v in pairs(MutatorShieldDozers.all_toggle) do
	MutatorShieldDozers["get_overdozer_" .. k] = function(self, item)
		return tostring(self:value("overdozer_" .. k)) == "true" and true or false
	end

	MutatorShieldDozers["_update_overdozer_" .. k .. "_toggle"] = function(self, item)
		local value = item:value() == "on" and true or false
		self:set_value("overdozer_" .. k, value)
	end
end

function MutatorShieldDozers:name()
	local name = MutatorShieldDozers.super.name(self)
	for k, v in pairs(self.all_toggle) do
		if self:_mutate_name("overdozer_" .. k) then
			name = string.format("%s - %s", name, managers.localization:text("menu_mutator_overdozer_" .. k))
		end
	end
	return name
end

function MutatorShieldDozers:reset_to_default()
	self:clear_values()
	if self._node then
		local toggle = nil
		for k, v in pairs(self.all_toggle) do
			toggle = self._node:item("overdozer_" .. k .. "_toggle")
			if toggle then
				toggle:set_value(self:value("overdozer_" .. k) and "on" or "off")
			end
		end
	end
end

function MutatorShieldDozers:setup()
	self:modify_character_tweak_data(tweak_data.character)
	self:modify_unit_categories(tweak_data.group_ai)
end

function MutatorShieldDozers:modify_unit_categories(gai)
	if gai and gai.unit_categories then
		for k, v in pairs(gai.unit_categories) do
			if v.unit_types and v.unit_types.america and v.unit_types.russia and k == "FBI_tank" then
				table.insert(gai.unit_categories[k].unit_types.america, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic"))
				table.insert(gai.unit_categories[k].unit_types.russia, Idstring("units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun"))
			end
		end
	end
end

function MutatorShieldDozers:modify_character_tweak_data(character_tweak)
	if character_tweak then
		if self:get_overdozer_health_rebuff() then
			character_tweak.tank_medic.HEALTH_INIT = character_tweak.tank.HEALTH_INIT
			character_tweak.tank_mini.HEALTH_INIT = character_tweak.tank.HEALTH_INIT
		end
		local _can_be_tased = self:get_overdozer_can_be_tased()
		local _super_speed = self:get_overdozer_super_speed()
		local _steal_loot = self:get_overdozer_steal_loot()
		local _immune_to_knock_down = self:get_overdozer_immune_to_knock_down()
		local _immune_to_concussion = self:get_overdozer_immune_to_concussion()
		local _shield_knocked = self:get_overdozer_shield_knocked()
		local _immune_to_knockback = self:get_overdozer_immune_to_knockback()
		local _use_animation_on_fire_damage = self:get_overdozer_use_animation_on_fire_damage()
		local _flammable = self:get_overdozer_flammable()
		local _rescue_hostages = self:get_overdozer_rescue_hostages()
		local _use_mini = self:get_overdozer_use_mini()
		for i, character in ipairs(character_tweak:enemy_list()) do
			if character_tweak[character] then
				character_tweak[character] = character_tweak[character] or {}
				character_tweak[character].can_be_tased = _can_be_tased
				character_tweak[character].can_be_tased = _steal_loot
				character_tweak[character].immune_to_knock_down = _immune_to_knock_down
				character_tweak[character].immune_to_concussion = _immune_to_concussion
				character_tweak[character].damage = character_tweak[character].damage or {}
				character_tweak[character].damage.shield_knocked = _shield_knocked
				character_tweak[character].damage.immune_to_knockback = _immune_to_knockback
				character_tweak[character].use_animation_on_fire_damage = _use_animation_on_fire_damage
				character_tweak[character].flammable = _flammable
				character_tweak[character].rescue_hostages = _rescue_hostages
				if _super_speed then
					character_tweak[character].move_speed = character_tweak.spooc.move_speed
				end
				if _use_mini then
					character_tweak[character].weapon.mini = character_tweak.tank_mini.weapon.mini
				end
			end
		end
	end
end

function MutatorShieldDozers:setup_options_gui(node)
	for k, v in pairs(self.all_toggle) do
		local params = {
			name = "overdozer_" .. k .. "_toggle",
			text_id = "menu_mutator_overdozer_" .. k,
			callback = "_update_mutator_value",
			update_callback = callback(self, self, "_update_overdozer_" .. k .. "_toggle")
		}
		local data = {
			type = "CoreMenuItemToggle.ItemToggle",
			{
				_meta = "option",
				icon = "guis/textures/menu_tickbox",
				value = "on",
				x = 24,
				y = 0,
				w = 24,
				h = 24,
				s_icon = "guis/textures/menu_tickbox",
				s_x = 24,
				s_y = 24,
				s_w = 24,
				s_h = 24
			},
			{
				_meta = "option",
				icon = "guis/textures/menu_tickbox",
				value = "off",
				x = 0,
				y = 0,
				w = 24,
				h = 24,
				s_icon = "guis/textures/menu_tickbox",
				s_x = 0,
				s_y = 24,
				s_w = 24,
				s_h = 24
			}
		}
		local new_item = node:create_item(data, params)
		new_item:set_value(self["get_overdozer_" .. k .. ""](self) and "on" or "off")
		node:add_item(new_item)
		self._node = node
	end
	return new_item
end

MutatorShieldDozers.allowed_tweak_datas = {"tank", "tank_hw", "tank_medic", "tank_mini"}
function MutatorShieldDozers:modify_value(id, value)
	if id == "CopInventory:add_unit_by_name" then
		if self:get_overdozer_use_shield() then
			local unit_type = value._unit:base()._tweak_table
			if table.contains(self.allowed_tweak_datas, unit_type) then
				local len = #self.shield_units
				local rand = math.clamp(value._unit:id() % len + 1, 1, len)
				local shield = self.shield_units[rand]
				value._shield_unit_name = self.shield_units[rand]
				value._shield_align_name = Idstring("a_weapon_left_front")
			end
		end
	end
	if id == "CopBase:default_weapon_name" then
		local unit_type = value._tweak_table
		if table.contains(self.allowed_tweak_datas, unit_type) then
			if self:get_overdozer_use_mini() then
				value._default_weapon_id = "mini"
			end
		end
	end
	if id == "MutatorEnemyReplacer:_get_unit_group_tank" then
		return self:get_overdozer_enable_medicdozer(), self:get_overdozer_enable_minidozer()
	end
end