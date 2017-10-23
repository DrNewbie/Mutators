_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}
_G.MutatorRandomizer_Data = _G.MutatorRandomizer_Data or {}

Hooks:PostHook(MutatorsManager, "set_enabled", "MutatorRandomizer_Data_Data_Generator", function(mm, ...)
	if MutatorRandomizer_Data then
		MutatorRandomizer_Data:Data_Generator()
	end
end )

Hooks:PostHook(MutatorsManager, "init", "MutatorRandomizer_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorRandomizer:new(mm))
	TMP_mutator_saving:New_Mutators_Init(mm)
end )