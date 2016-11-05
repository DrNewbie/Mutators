_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if RequiredScript == "lib/managers/localizationmanager" then
	TMP_mutator_saving.ModPath = ModPath
	TMP_mutator_saving.SaveFile = TMP_mutator_saving.SaveFile or SavePath .. "tmp_mutator_saving.txt"
	TMP_mutator_saving.data = TMP_mutator_saving.data or {}

	function TMP_mutator_saving:Load()
		local _file = io.open(self.SaveFile, "r")
		if _file then
			self.data = json.decode(_file:read("*all"))
			_file:close()
		end
	end

	TMP_mutator_saving:Load()

	function TMP_mutator_saving:Save()
		local _file = io.open(self.SaveFile, "w+")
		if _file then
			_file:write(json.encode(self.data))
			_file:close()
		end
	end
	
	function TMP_mutator_saving:Is_This_Enable(mutator_id, mm)
		local _MM = nil
		if mm then
			_MM = mm
		elseif managers.mutators then
			_MM = managers.mutators:get_mutator_from_id(mutator_id) or nil
		end
		if _MM then
			if TMP_mutator_saving.data and TMP_mutator_saving.data[mutator_id] then
				return true
			elseif managers.mutators and managers.mutators:is_mutator_active(_MM) then
				return true
			end
		end
		return false
	end
	
	function TMP_mutator_saving:Pre_Save()
		local mm = managers.mutators:mutators() or {}
		for _, _mutator in ipairs(mm) do
			TMP_mutator_saving.data[tostring(_mutator:id())] = _mutator:is_enabled()
		end
		self:Save()
	end
end

if RequiredScript == "lib/managers/mutatorsmanager" then
	Hooks:PostHook(MutatorsManager, "set_enabled", "TMP_mutator_saving_set_enabled", function(mm, ...)
		TMP_mutator_saving:Pre_Save()
	end )
end

Hooks:Add("MenuManagerOnOpenMenu", "TMP_mutator_saving_MenuManagerOnOpenMenu", function(menu_manager, menu, ...)
	if menu == "menu_main" then
		TMP_mutator_saving:Pre_Save()
	end
end)