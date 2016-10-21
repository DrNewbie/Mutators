Hooks:Add("LocalizationManagerPostInit", "MutatorsProfessional_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["mutator_professional"] = "Professional",
		["mutator_professional_desc"] = "You can't restart.",
		["mutator_professional_longdesc"] = "......",
	})
end)

MutatorsProfessional = MutatorsProfessional or class(BaseMutator)
MutatorsProfessional._type = "MutatorsProfessional"
MutatorsProfessional.name_id = "mutator_professional"
MutatorsProfessional.desc_id = "mutator_professional_desc"
MutatorsProfessional.has_options = false
MutatorsProfessional.reductions = {money = 0, exp = 0}
MutatorsProfessional.categories = {"gameplay"}
MutatorsProfessional.icon_coords = {10, 1}