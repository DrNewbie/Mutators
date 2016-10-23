Hooks:PostHook(MutatorsManager, "init", "MutatorHardlineBreakout_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorHardlineBreakout:new(mm))
end )