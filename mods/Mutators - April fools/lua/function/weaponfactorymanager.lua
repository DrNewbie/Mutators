_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function WeaponFactoryManager:get_ammo_data_from_weapon(factory_id, blueprint)
	local factory = tweak_data.weapon.factory
	local t = {}
	for _, id in ipairs(self:get_assembled_blueprint(factory_id, blueprint)) do
		if factory.parts[id].type == "ammo" then
			local part = self:_part_data(id, factory_id)
			if not TMP_mutator_saving:Is_This_Enable("MutatorAprilFools", MutatorAprilFools) then
				if tostring(part.custom_stats.bullet_class) == "InstantRicochetBulletBase" then
				
				else
					t = part.custom_stats
				end
			else
				t = part.custom_stats
			end
		end
	end
	return t
end

function WeaponFactoryManager:_get_forced_parts(factory_id)
	return tweak_data.weapon.factory[factory_id].forced_parts or {}
end

function WeaponFactoryManager:_add_parts(p_unit, factory_id, factory_weapon, blueprint, forbidden, third_person, done_cb, skip_queue)
	self._tasks = self._tasks or {}
	local parts = {}
	local need_parent = {}
	local override = self:_get_override_parts(factory_id, blueprint)
	for _, forced_id in ipairs(self:_get_forced_parts(factory_id)) do
		local replaced = false
		local exists = false
		for i, part_id in ipairs(blueprint) do
			if part_id == forced_id then
				exists = true
			else
				local part_data = self:_part_data(part_id, factory_id)
				local forced_data = self:_part_data(forced_id, factory_id)
				if part_data.type == forced_data.type then
					blueprint[i] = forced_id
					replaced = true
				else
				end
			end
		end
		if not exists and not replaced then
			table.insert(blueprint, forced_id)
		end
	end
	if self._uses_tasks and not skip_queue then
		table.insert(self._tasks, {
			done_cb = done_cb,
			p_unit = p_unit,
			factory_id = factory_id,
			blueprint = blueprint,
			blueprint_i = 1,
			forbidden = forbidden,
			third_person = third_person,
			parts = parts,
			need_parent = need_parent,
			need_parent_i = 1,
			override = override
		})
	else
		local async_task_data
		if self._uses_streaming then
			async_task_data = {
				third_person = third_person,
				parts = parts,
				done_cb = done_cb,
				blueprint = blueprint,
				spawn = true
			}
			self._async_load_tasks = self._async_load_tasks or {}
			self._async_load_tasks[async_task_data] = true
		end
		for _, part_id in ipairs(blueprint) do
			self:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, need_parent, async_task_data)
		end
		for _, part_id in ipairs(need_parent) do
			self:_add_part(p_unit, factory_id, part_id, forbidden, override, parts, third_person, need_parent, async_task_data)
		end
		if async_task_data then
			async_task_data.all_requests_sent = true
			self:clbk_part_unit_loaded(async_task_data, false, Idstring(), Idstring())
		else
			done_cb(parts, blueprint)
		end
	end
	return parts, blueprint
end