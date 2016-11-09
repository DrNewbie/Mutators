Hooks:PostHook(CopInventory, "init", "Bobdozer_SetMaskInit", function(cop, ...)
	cop._mask_visibility = false
	cop._mask_unit_name = "NONE"
	if cop._unit:name():key() == Idstring("units/payday2/characters/civ_male_casual_1/civ_male_casual_1"):key() then
		cop._mask_unit_name = "units/pd2_merchandise/masks/msk_bobblehead_dozer/msk_bobblehead_dozer"
	end
end)

function CopInventory:Can_I_Have_Mask()
	if not self._mask_unit_name or not self._mask_unit_name:find("masks") or self._mask_unit_name:find("NONE") then
		return false
	end
	return true
end

function CopInventory:preload_mask()
	if not self:Can_I_Have_Mask() then
		return
	end
	self._mask_visibility = true
	managers.dyn_resource:load(Idstring("unit"), Idstring(self._mask_unit_name), managers.dyn_resource.DYN_RESOURCES_PACKAGE, callback(self, self, "clbk_mask_unit_loaded"))
end

function CopInventory:clbk_mask_unit_loaded(status, asset_type, asset_name)
	self._mask_unit_loaded = status
	self:_reset_mask_visibility()
end

function CopInventory:is_mask_unit_loaded()
	return self._mask_unit_loaded
end

function CopInventory:_unload_mask()
	if not self:Can_I_Have_Mask() then
		return
	end
	managers.dyn_resource:unload(Idstring("unit"), Idstring(self._mask_unit_name), DynamicResourceManager.DYN_RESOURCES_PACKAGE, false)
	self._mask_unit_name = nil
end

function CopInventory:_reset_mask_visibility()
	self:set_mask_visibility(self._mask_visibility and true or false)
end

function CopInventory:pre_destroy(unit)
	CopInventory.super.pre_destroy(self, unit)
	self:_unload_mask()
end

function CopInventory:set_mask_visibility(state)
	if not self:Can_I_Have_Mask() then
		return
	end
	self._mask_visibility = state
	if alive(self._mask_unit) then
		if not state then
			for _, linked_unit in ipairs(self._mask_unit:children()) do
				linked_unit:unlink()
				World:delete_unit(linked_unit)
			end
			self._mask_unit:unlink()
			local name = self._mask_unit:name()
			World:delete_unit(self._mask_unit)
		end
		return
	end
	if not state then
		return
	end
	mask_unit_name = self._mask_unit_name
	local mask_align = self._unit:get_object(Idstring("Head"))
	local mask_unit = World:spawn_unit(Idstring(mask_unit_name), mask_align:position(), mask_align:rotation())
	self._unit:link(mask_align:name(), mask_unit, mask_unit:orientation_object():name())
	self._mask_unit = mask_unit
	local backside = World:spawn_unit(Idstring("units/payday2/masks/msk_backside/msk_backside"), mask_align:position(), mask_align:rotation())
	self._mask_unit:link(self._mask_unit:orientation_object():name(), backside, backside:orientation_object():name())
end