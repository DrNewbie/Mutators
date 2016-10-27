Hooks:PostHook(MutatorsManager, "init", "FreeMyMutators_MutatorsManager_init", function(mm, ...)
	for _, mutator in pairs(mm:mutators()) do
		mutator.disables_achievements = false
		mutator.reductions = {money = 0, exp = 0}
	end
end )