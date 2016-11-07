Hooks:PostHook(CharacterTweakData, "_init_tank", "Enemy_Bob_CharacterTweakData_init_tank", function(cc, ...)
	cc.enemy_bob = {}
	cc.enemy_bob = deep_clone(cc.tank)
	cc.enemy_bob.headshot_dmg_mul = 2
	local _FALLOFF = {
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}}
	}
	cc.enemy_bob.weapon.saiga.FALLOFF = deep_clone(_FALLOFF)
	cc.enemy_bob.weapon.beretta92.FALLOFF = deep_clone(_FALLOFF)		
	cc.enemy_bob.weapon.raging_bull.FALLOFF = deep_clone(_FALLOFF)		
	cc.enemy_bob.weapon.m4.FALLOFF = deep_clone(_FALLOFF)		
	cc.enemy_bob.weapon.ak47.FALLOFF = deep_clone(_FALLOFF)		
	cc.enemy_bob.weapon.r870.FALLOFF = deep_clone(_FALLOFF)		
	cc.enemy_bob.weapon.mossberg.FALLOFF = deep_clone(_FALLOFF)
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_hp", "Enemy_Bob_CharacterTweakData_multiply_all_hp", function(cc, ...)
	cc.enemy_bob.HEALTH_INIT = cc.tank.HEALTH_INIT * 1.5
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_speeds", "Enemy_Bob_CharacterTweakData_multiply_all_speeds", function(cc, ...)
	cc.enemy_bob.SPEED_RUN = cc.tank.SPEED_RUN * 2
	cc.enemy_bob.SPEED_WALK.hos = cc.tank.SPEED_WALK.hos * 2
	cc.enemy_bob.SPEED_WALK.cbt = cc.tank.SPEED_WALK.cbt * 2
end )