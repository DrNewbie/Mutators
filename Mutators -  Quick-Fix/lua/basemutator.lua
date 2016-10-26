Hooks:Add("LocalizationManagerPostInit", "MutatorQuickFix_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_quickfix"] = "Quick-Fix",
		["mutator_quickfix_desc"] = "Decrease Medic cooldown. The more he saved, the less he required.",
		["mutator_quickfix_longdesc"] = "......",
	})
end)

MutatorQuickFix = MutatorQuickFix or class(BaseMutator)
MutatorQuickFix._type = "MutatorQuickFix"
MutatorQuickFix.name_id = "mutator_quickfix"
MutatorQuickFix.desc_id = "mutator_quickfix_desc"
MutatorQuickFix.has_options = false
MutatorQuickFix.reductions = {money = 0, exp = 0}
MutatorQuickFix.categories = {"gameplay"}
MutatorQuickFix.icon_coords = {10, 1}