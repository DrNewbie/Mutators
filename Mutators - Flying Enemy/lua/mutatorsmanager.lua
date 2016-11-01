Hooks:PostHook(MutatorsManager, "init", "MutatorFlyingEnemy_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorFlyingEnemy:new(mm))
end )