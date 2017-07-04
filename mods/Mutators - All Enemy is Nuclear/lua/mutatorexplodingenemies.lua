Hooks:Add("LocalizationManagerPostInit", "SafeHousePlus_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["menu_mutator_creeps_nuclear_allenemy"] = "All Enemy is Nuclear",
	})
end)

function MutatorExplodingEnemies:register_values(mutator_manager)
	self:register_value("explosion_size", 4, "es")
	self:register_value("nuclear_dozers", false, "nd")
	self:register_value("nuclear_allenemy", false, "nd")
end

function MutatorExplodingEnemies:name()
	local name = MutatorExplodingEnemies.super.name(self)
	if self:_mutate_name("explosion_size") then
		name = string.format("%s - %.1fm", name, tonumber(self:value("explosion_size")))
	end
	if self:_mutate_name("nuclear_dozers") then
		name = string.format("%s - %s", name, managers.localization:text("menu_mutator_creeps_nuclear"))
	end
	if self:_mutate_name("nuclear_allenemy") then
		name = string.format("%s - %s", name, managers.localization:text("menu_mutator_creeps_nuclear_allenemy"))
	end
	return name
end

function MutatorExplodingEnemies:_toggle_nuclear_allenemy(item)
	self:set_value("nuclear_allenemy", item:value() == "on")
end

function MutatorExplodingEnemies:use_nuclear_allenemy()
	return self:value("nuclear_allenemy")
end

local _MutatorExplodingEnemies_detonate_PreHook = MutatorExplodingEnemies._detonate

local _small_cd_nuclear_allenemy = 0
local _bool_nuclear_allenemy = false

function MutatorExplodingEnemies:get_explosion_size()
	if _bool_nuclear_allenemy then
		_bool_nuclear_allenemy = false
		return self:use_nuclear_allenemy() and 2000 or self:value("explosion_size")
	else
		return self:value("explosion_size")
	end
end

function MutatorExplodingEnemies:_detonate(cop_damage, attack_data)
	local _t = math.round(TimerManager:game():time())
	if _t > _small_cd_nuclear_allenemy then
		_small_cd_nuclear_allenemy = _t + 1
		_bool_nuclear_allenemy = true
		if self:use_nuclear_allenemy() and cop_damage and attack_data then
			attack_data.raw_damage = cop_damage._HEALTH_INIT * 2.5
		end
	end
	return _MutatorExplodingEnemies_detonate_PreHook(self, cop_damage, attack_data)
end

Hooks:PostHook(MutatorExplodingEnemies, "setup_options_gui", "MutatorExplodingEnemies_setup_options_gui_Expand", function(mex, node, ...)
	local params = {
		name = "nuclear_allenemy_toggle",
		text_id = "menu_mutator_creeps_nuclear_allenemy",
		callback = "_update_mutator_value",
		update_callback = callback(mex, mex, "_toggle_nuclear_allenemy")
	}
	local data_node = {
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
	local new_item = node:create_item(data_node, params)
	new_item:set_value(mex:use_nuclear_allenemy() and "on" or "off")
	node:add_item(new_item)
	mex._node = node
	return new_item
end )