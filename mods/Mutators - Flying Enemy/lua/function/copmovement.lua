_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(CopMovement, "init", "MutatorFlyingEnemy_CopMovement_init", function(cop, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorFlyingEnemy", MutatorFlyingEnemy) then
		cop._fly_t = math.round(TimerManager:game():time()) + 3
	end
end )

Hooks:PostHook(CopMovement, "set_position", "MutatorFlyingEnemy_CopMovement_set_position", function(cop, pos)
	if TMP_mutator_saving:Is_This_Enable("MutatorFlyingEnemy", MutatorFlyingEnemy) then
		if not managers.enemy:is_enemy(cop._unit) then
			return
		end
		local enemyType = tostring(cop._unit:base()._tweak_table)
		if ( enemyType == "security" or enemyType == "gensec" or 
			enemyType == "cop" or enemyType == "fbi" or 
			enemyType == "swat" or enemyType == "heavy_swat" or 
			enemyType == "fbi_swat" or enemyType == "fbi_heavy_swat" or 
			enemyType == "city_swat" or enemyType == "sniper" or 
			enemyType == "gangster" or enemyType == "taser" or 
			enemyType == "tank" or enemyType == "spooc" or enemyType == "shield" or 
			enemyType == "medic" ) then
			local _t = math.round(TimerManager:game():time())
			if cop._fly_t > _t then
				return
			end
			cop._fly_t = _t + math.random()*10
			rand_vector3_use = function(_pos)
				local use_v3_list = {_pos, _pos, _pos, _pos}
				local z_offsett = {0, 0, 0, 0, 300, 400, 200, 500}
				local i = 0
				for _, data in pairs(managers.groupai:state():all_player_criminals()) do
					i = i + 1
					use_v3_list[i] = data.unit:position()
				end
				_pos = use_v3_list[math.random(#use_v3_list)]
				_pos = _pos + Vector3(math.random(-500,500), math.random(-500,500), z_offsett[math.random(#z_offsett)])
				return _pos
			end
			pos = rand_vector3_use(pos)
			cop:set_position(pos)
		end
	end
end )