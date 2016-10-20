_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if RequiredScript == "lib/managers/menumanager" then

end

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
end

if RequiredScript == "lib/managers/mutatorsmanager" then
	Hooks:PostHook(MutatorsManager, "set_enabled", "TMP_mutator_saving_set_enabled", function(mm, ...)
		for _, _mutator in ipairs(mm:mutators()) do
			TMP_mutator_saving.data[tostring(_mutator:id())] = _mutator:is_enabled()
		end
		TMP_mutator_saving:Save()
	end )
end