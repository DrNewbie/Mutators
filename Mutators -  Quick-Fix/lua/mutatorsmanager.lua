Hooks:PostHook(MutatorsManager, "init", "MutatorQuickFix_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorQuickFix:new(mm))
end )