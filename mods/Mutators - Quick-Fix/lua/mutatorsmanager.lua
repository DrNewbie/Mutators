_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(MutatorsManager, "init", "MutatorQuickFix_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorQuickFix:new(mm))
	TMP_mutator_saving:New_Mutators_Init(mm)
end )