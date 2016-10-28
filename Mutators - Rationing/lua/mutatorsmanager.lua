Hooks:PostHook(MutatorsManager, "init", "MutatorRationing_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorRationing:new(mm))
end )