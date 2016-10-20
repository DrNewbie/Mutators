if managers.mutators:is_mutator_active(MutatorExplodingEnemies) then
	local _mm = managers.mutators:get_mutator(MutatorExplodingEnemies)
	if _mm and _mm:use_nuclear_allenemy() then
		Announcer:AddHostMod("All Enemy is Nuclear, All Enemy will do huge exploding when killed")
	end
end