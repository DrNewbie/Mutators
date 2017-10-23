if managers.mutators and managers.mutators:is_mutator_active(MutatorEnemyReplacer) then
	local _mm = managers.mutators:get_mutator(MutatorEnemyReplacer) or nil
	if _mm and _mm:get_override_enemy() and _mm:get_override_enemy() == "sniper" then
		Announcer:AddHostMod("Sniper Rush , Replace all spawning units with Sniper")
	end
end