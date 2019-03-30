_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}
_G.MutatorRandomizer_Data = _G.MutatorRandomizer_Data or {}

Hooks:PostHook(MutatorsManager, "init", "MutatorZeroDown_Init", function(mm, ...)
	table.insert(mm._mutators, MutatorZeroDown:new(mm))
	table.insert(mm._mutators, MutatorFlyingEnemy:new(mm))
	table.insert(mm._mutators, MutatorRealism:new(mm))
	table.insert(mm._mutators, MutatorRationing:new(mm))
	table.insert(mm._mutators, MutatorRandomizer:new(mm))
	table.insert(mm._mutators, MutatorQuickFix:new(mm))
	table.insert(mm._mutators, MutatorsProfessional:new(mm))
	table.insert(mm._mutators, MutatorBeBulldozer:new(mm))
	table.insert(mm._mutators, MutatorHugePunch:new(mm))
	table.insert(mm._mutators, MutatorHeadshotOnly:new(mm))
	table.insert(mm._mutators, MutatorHardlineBreakout:new(mm))
	table.insert(mm._mutators, MutatorDeathMatch:new(mm))
	table.insert(mm._mutators, MutatorBodyshotOnly:new(mm))
	table.insert(mm._mutators, MutatorBobdozer:new(mm))
	table.insert(mm._mutators, MutatorBankspook:new(mm))
	table.insert(mm._mutators, MutatorAprilFools:new(mm))
	if MutatorRandomizer_Data then
		MutatorRandomizer_Data:Data_Generator()
	end
	TMP_mutator_saving:New_Mutators_Init(mm)
end )