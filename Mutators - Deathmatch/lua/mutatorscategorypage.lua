Hooks:PostHook(MutatorItem, "init", "MutatorDeathMatch_Icon", function(mm, parent_panel, mutator, index)
	if tostring(mutator:id()) == "MutatorDeathMatch" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				880,
				400,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	end
end )