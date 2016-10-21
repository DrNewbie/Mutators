Hooks:PostHook(MutatorsManager, "init", "MutatorsProfessional_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorsProfessional:new(mm))
end )