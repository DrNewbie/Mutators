_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(MutatorsManager, "init", "MutatorZeroDown_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorZeroDown:new(mm))
	TMP_mutator_saving:New_Mutators_Init(mm)
end )