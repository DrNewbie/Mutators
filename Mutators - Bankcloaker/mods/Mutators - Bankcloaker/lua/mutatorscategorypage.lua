Hooks:PostHook(MutatorItem, "init", "MutatorBankspook_Icon", function(mm, parent_panel, mutator, index)
	if tostring(mutator:id()) == "MutatorBankspook" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/hud_icons",
			texture_rect = {
				288,
				144,
				48,
				48
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	end
end )