_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local Remove_add = ContourExt.add

function ContourExt:add(...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
	
	else
		return Remove_add(self, ...)
	end
end

local CleanContour_t = nil
local units_check = {}
local ids_contour_opacity = Idstring("contour_opacity")
local ids_material = Idstring("material")

Hooks:Add("GameSetupUpdate", "MutatorRealismCleanContour", function(t, dt)
	if World and TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		local unit_list = World:find_units_quick("all")
		if unit_list then
			if not CleanContour_t then
				for _, unit in ipairs(unit_list) do
					if unit and alive(unit) and not units_check[unit:key()] and unit.get_objects_by_type then
						units_check[unit:key()] = true
						local materials = unit:get_objects_by_type(ids_material)
						if materials then
							for _, m in ipairs(materials) do
								m:set_variable(ids_contour_opacity, 0)
							end
						end
						if unit.contour and unit:contour() then
							unit:contour().add = function()
							
							end
						end
					end
				end
				CleanContour_t = 0.3
			else
				CleanContour_t = CleanContour_t - dt
				if CleanContour_t < 0 then
					CleanContour_t = nil
				end
			end
		end
	end
end)