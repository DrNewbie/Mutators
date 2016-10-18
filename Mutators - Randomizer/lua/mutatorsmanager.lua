_G.MutatorRandomizer_Data = _G.MutatorRandomizer_Data or {}

Hooks:PostHook(MutatorsManager, "set_enabled", "MutatorRandomizer_Data_Data_Generator", function(mm, ...)
	if MutatorRandomizer_Data then
		MutatorRandomizer_Data:Data_Generator()
	end
end )

Hooks:PostHook(MutatorsManager, "init", "MutatorRandomizer_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorRandomizer:new(mm))
end )