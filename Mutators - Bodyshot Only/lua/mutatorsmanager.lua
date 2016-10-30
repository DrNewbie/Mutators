Hooks:PostHook(MutatorsManager, "init", "MutatorBodyshotOnly_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorBodyshotOnly:new(mm))
end )