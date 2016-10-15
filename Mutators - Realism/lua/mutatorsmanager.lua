Hooks:PostHook(MutatorsManager, "init", "MutatorRealismNew", function(mm, ...)
	table.insert(mm._mutators, MutatorRealism:new(mm))
end )