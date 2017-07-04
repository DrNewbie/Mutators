Hooks:Add("LocalizationManagerPostInit", "MutatorHardlineBreakout_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_hardlinebreakout"] = "Hardline Breakout",
		["mutator_hardlinebreakout_desc"] = "Random bomb from nowhere",
		["mutator_hardlinebreakout_longdesc"] = "......",
	})
end)

MutatorHardlineBreakout = MutatorHardlineBreakout or class(BaseMutator)
MutatorHardlineBreakout._type = "MutatorHardlineBreakout"
MutatorHardlineBreakout.name_id = "mutator_hardlinebreakout"
MutatorHardlineBreakout.desc_id = "mutator_hardlinebreakout_desc"
MutatorHardlineBreakout.has_options = false
MutatorHardlineBreakout.reductions = {money = 0, exp = 0}
MutatorHardlineBreakout.categories = {"gameplay"}
MutatorHardlineBreakout.icon_coords = {10, 1}