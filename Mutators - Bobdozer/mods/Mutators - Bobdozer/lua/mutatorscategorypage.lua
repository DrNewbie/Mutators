Hooks:PostHook(MutatorItem, "init", "MutatorBobdozer_Icon", function(mm, parent_panel, mutator, index)
	if tostring(mutator:id()) == "MutatorBobdozer" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/dlcs/merchandise/textures/pd2/blackmarket/icons/masks/bobblehead_dozer",
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