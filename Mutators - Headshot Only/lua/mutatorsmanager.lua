Hooks:PostHook(MutatorsManager, "init", "MutatorHeadshotOnly_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorHeadshotOnly:new(mm))
end )