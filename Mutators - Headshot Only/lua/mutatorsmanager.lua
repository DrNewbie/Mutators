_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(MutatorsManager, "init", "MutatorHeadshotOnly_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorHeadshotOnly:new(mm))
	TMP_mutator_saving:New_Mutators_Init(mm)
end )