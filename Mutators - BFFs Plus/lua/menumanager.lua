if managers.mutators:is_mutator_active(MutatorMediDozer) then
	local _mm = managers.mutators:get_mutator(MutatorMediDozer)
	if _mm and _mm:get_override_enemy() then
		Announcer:AddHostMod("BFFs Plus, Special enemies are replaced with others, normal enemies are replaced with Medic")
	end
end