Hooks:PostHook(CharacterTweakData, "_init_tank", "Enemy_Bob_CharacterTweakData_init_tank", function(cc, ...)
	cc.bobdozer = {}
	cc.bobdozer = deep_clone(cc.tank)
	cc.bobdozer.headshot_dmg_mul = 2
	local _FALLOFF = {
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.3, 0.5}, mode = {30, 30, 30, 30}, autofire_rounds = {500, 700}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.3, 0.5}, mode = {30, 30, 30, 30}, autofire_rounds = {500, 700}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.3, 0.5}, mode = {30, 30, 30, 30}, autofire_rounds = {500, 700}}
	}
	cc.bobdozer.weapon.mini.FALLOFF = _FALLOFF
	cc.bobdozer.weapon.mini.focus_delay = 1
	cc.bobdozer.weapon.mini.focus_dis = 8000
	cc.bobdozer.weapon.mini.spread = 10
	cc.bobdozer.weapon.mini.miss_dis = 8000
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_hp", "Enemy_Bob_CharacterTweakData_multiply_all_hp", function(cc, ...)
	cc.bobdozer.HEALTH_INIT = cc.tank.HEALTH_INIT * 1.75
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_speeds", "Enemy_Bob_CharacterTweakData_multiply_all_speeds", function(cc, ...)
	cc.bobdozer.SPEED_RUN = cc.tank.SPEED_RUN * 2
	cc.bobdozer.SPEED_WALK.hos = cc.tank.SPEED_WALK.hos * 2
	cc.bobdozer.SPEED_WALK.cbt = cc.tank.SPEED_WALK.cbt * 2
end )