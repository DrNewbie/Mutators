function CopBase:default_weapon_name()
	if managers.mutators:is_mutator_active(MutatorShieldDozers) then
		managers.mutators:modify_value("CopBase:default_weapon_name", self)
	end
	local default_weapon_id = self._default_weapon_id
	local weap_ids = tweak_data.character.weap_ids
	for i_weap_id, weap_id in ipairs(weap_ids) do
		if default_weapon_id == weap_id then
			return tweak_data.character.weap_unit_names[i_weap_id]
		end
	end
end