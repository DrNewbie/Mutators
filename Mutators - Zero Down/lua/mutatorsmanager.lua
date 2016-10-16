Hooks:PostHook(MutatorsManager, "init", "MutatorZeroDown_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorZeroDown:new(mm))
end )