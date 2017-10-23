if managers.mutators and managers.mutators:is_mutator_active(MutatorMediDozer) then
	local _mm = managers.mutators:get_mutator(MutatorMediDozer) or nil
	if _mm and _mm:get_override_enemy() then
		Announcer:AddHostMod("BFFs Plus, Special enemies are replaced with one, normal enemies are replaced with other")
	end
end