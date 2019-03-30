Hooks:PostHook(MutatorItem, "init", "Dr_NewbieMutatorsPackage_Icon", function(mm, parent_panel, mutator, index)
	local _mutator_id = tostring(mutator:id())
	if _mutator_id == "MutatorAprilFools" then
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
	elseif _mutator_id == "MutatorBankspook" then
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
	elseif _mutator_id == "MutatorBobdozer" then
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
	elseif _mutator_id == "MutatorBodyshotOnly" then
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
	elseif _mutator_id == "MutatorDeathMatch" then
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
	elseif _mutator_id == "MutatorHardlineBreakout" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				720,
				720,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorHeadshotOnly" then
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
	elseif _mutator_id == "MutatorHugePunch" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				880,
				560,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorBeBulldozer" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				640,
				800,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorsProfessional" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				800,
				560,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorQuickFix" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				80,
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
	elseif _mutator_id == "MutatorRandomizer" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				720,
				320,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorRationing" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				880,
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
	elseif _mutator_id == "MutatorFlyingEnemy" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				160,
				80,
				80,
				80
			},
			blend_mode = "add",
			alpha = mm:icon_alpha(),
			w = mm._icon_panel:w(),
			h = mm._icon_panel:h()
		})
		mm:refresh()
	elseif _mutator_id == "MutatorZeroDown" then
		mm._icon = mm._icon_panel:bitmap({
			name = "icon",
			texture = "guis/textures/pd2/skilltree_2/icons_atlas_2",
			texture_rect = {
				720,
				720,
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