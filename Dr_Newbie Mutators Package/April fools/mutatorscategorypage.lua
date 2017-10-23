Hooks:PostHook(MutatorItem, "init", "MutatorAprilFools_Icon", function(mm, parent_panel, mutator, index)
	if tostring(mutator:id()) == "MutatorAprilFools" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/blackmarket/icons/masks/smiley",
			texture_rect = {
				0,
				0,
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