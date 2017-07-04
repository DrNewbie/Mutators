_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}
TMP_mutator_saving.data = TMP_mutator_saving.data or {}
_G.MutatorRandomizer_Data = _G.MutatorRandomizer_Data or {}
MutatorRandomizer_Data.ModPath = ModPath
MutatorRandomizer_Data.DataPath = MutatorRandomizer_Data.ModPath .. "Randomizer.txt"
MutatorRandomizer_Data.Possible_Data = {}
MutatorRandomizer_Data.Possible_Data_Size = 100
MutatorRandomizer_Data.Selected_Data = {
	character = "",
	primary = "",
	primary_mods = {},
	secondary = "",
	secondary_mods = {},
	armor = "",
	deployable = "",
	throwable = "",
	melee = ""
}

function MutatorRandomizer_Data:Data_Generator()
	local _size = MutatorRandomizer_Data.Possible_Data_Size
	if not tweak_data or not tweak_data.statistics or not tweak_data.weapon or not tweak_data.weapon.factory or not managers.weapon_factory then
		return
	end
	local _, _, _, _weapon_list, _melee_list, _grenade_list, _, _armor_list, _character_list, _deployable_list = tweak_data.statistics:statistics_table()
	local _primary, _secondary = {}, {}
	for _, _name in pairs(_weapon_list) do
		if tweak_data.weapon[_name] and tweak_data.weapon[_name].use_data then
			if tweak_data.weapon[_name].use_data.selection_index == 2 then
				table.insert(_primary, _name)
			elseif tweak_data.weapon[_name].use_data.selection_index == 1 then
				table.insert(_secondary, _name)
			end
		end
	end
	local _data_ready = {}
	for i = 1, _size do
		local _primary_selected = _primary[math.random(#_primary)]
		local _secondary_selected = _secondary[math.random(#_secondary)]
		local _primary_selected_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_primary_selected)
		local _secondary_selectedfactory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_secondary_selected)
		local _tweak_data_factory = tweak_data.weapon.factory
		local _primary_selected_factory_data = _tweak_data_factory[_primary_selected_factory_id].uses_parts
		local _secondary_selected_factory_data = _tweak_data_factory[_secondary_selectedfactory_id].uses_parts
		local _primary_mods, _secondary_mods, _used = {}, {}, {}
		local _added = 0
		for _, _factory_name in pairs(_primary_selected_factory_data) do
			if _added >= #_primary_selected_factory_data then
				break
			end
			local _dd = _primary_selected_factory_data[math.random(#_primary_selected_factory_data)]
			local _tt = _tweak_data_factory.parts[_dd].type
			if not _used[_tt] then
				_used[_tt] = true
				_primary_mods[#_primary_mods+1] = _dd
			end
			_added = _added + 1
		end
		_used = {}
		_added = 0
		for _, _factory_name in pairs(_secondary_selected_factory_data) do
			if _added >= #_secondary_selected_factory_data then
				break
			end
			local _dd = _secondary_selected_factory_data[math.random(#_secondary_selected_factory_data)]
			local _tt = _tweak_data_factory.parts[_dd].type
			if not _used[_tt] then
				_used[_tt] = true
				_secondary_mods[#_secondary_mods+1] = _dd
			end
			_added = _added + 1
		end
		local _armor_selected = _armor_list[math.random(#_armor_list)]
		local _deployable_selected = _deployable_list[math.random(#_deployable_list)]
		local _grenade_selected = _grenade_list[math.random(#_grenade_list)]
		local _melee_selected = _melee_list[math.random(#_melee_list)]
		local _character_selected = _character_list[math.random(#_character_list)]
		_data_ready[i] = {
			character = _character_selected,
			primary = _primary_selected_factory_id,
			primary_mods = _primary_mods,
			secondary = _secondary_selectedfactory_id,
			secondary_mods = _secondary_mods,
			armor = _armor_selected,
			deployable = _deployable_selected,
			throwable = _grenade_selected,
			melee = _melee_selected
		}
	end
	local _file = io.open(self.DataPath, "w+")
	if _file then
		_file:write( json.encode( _data_ready ) )
		_file:close()
	end
	return _data_ready
end

MutatorRandomizer_Data.Loaded = false
if TMP_mutator_saving:Is_This_Enable("MutatorRandomizer", MutatorRandomizer) and not MutatorRandomizer_Data.Loaded then
	MutatorRandomizer_Data.Loaded = true
	math.randomseed(os.time())
	local _file = io.open(MutatorRandomizer_Data.DataPath, "r")
	if not _file then
		MutatorRandomizer_Data.Possible_Data = MutatorRandomizer_Data:Data_Generator()	
	else
		MutatorRandomizer_Data.Possible_Data = json.decode(_file:read("*all"))
		_file:close()
	end
	_file = nil
	if MutatorRandomizer_Data.Possible_Data then
		local _selected = MutatorRandomizer_Data.Possible_Data[math.random(MutatorRandomizer_Data.Possible_Data_Size)]
		if _selected and Global.game_settings and Global.game_settings.level_id then
			tweak_data.levels[Global.game_settings.level_id].force_equipment = _selected
			MutatorRandomizer_Data.Selected_Data = _selected
		end
	end
end

function BlackMarketManager:forced_melee()
	local level_data = tweak_data.levels[managers.job:current_level_id()]
	return level_data and level_data.force_equipment and level_data.force_equipment.melee
end

function BlackMarketManager:equipped_melee_weapon()
	local forced_melee = self:forced_melee()
	if forced_melee then
		return forced_melee
	end
	local melee_weapon
	for melee_weapon_id, data in pairs(tweak_data.blackmarket.melee_weapons) do
		melee_weapon = Global.blackmarket_manager.melee_weapons[melee_weapon_id]
		if melee_weapon.equipped and melee_weapon.unlocked then
			return melee_weapon_id
		end
	end
	self:aquire_default_weapons()
	return self._defaults.melee_weapon
end

function BlackMarketManager:forced_character()
	if managers.network and managers.network:session() then
		local level_data = tweak_data.levels[managers.job:current_level_id()]
		if level_data and level_data.force_equipment then
			local peer = managers.network:session():local_peer()
			if peer and peer:character() ~= level_data.force_equipment.character then
				if managers.criminals:is_taken(level_data.force_equipment.character) then
					peer:set_character(managers.criminals:get_free_character_name())
				else
					peer:set_character(level_data.force_equipment.character)
				end
			end
			return level_data.force_equipment.character
		end
	end
end