Hooks:PostHook(MutatorsManager, "init", "MutatorBeBulldozer_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorBeBulldozer:new(mm))
end )