Hooks:PostHook(MutatorItem, "init", "MutatorBodyshotOnly_Icon", function(mm, parent_panel, mutator, index)
	if tostring(mutator:id()) == "MutatorBodyshotOnly" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				480,
				880,
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