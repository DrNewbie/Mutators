Hooks:PostHook(CharacterTweakData, "_init_tank", "Enemy_Bob_CharacterTweakData_init_tank", function(cc, ...)
	local _FALLOFF = {
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}},
		{r = 10000, acc = {1, 1}, dmg_mul = 7, recoil = {0.1, 0.1}, mode = {50, 50, 50, 50}}
	}
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_hp", "Enemy_Bob_CharacterTweakData_multiply_all_hp", function(cc, ...)
end )

Hooks:PostHook(CharacterTweakData, "_multiply_all_speeds", "Enemy_Bob_CharacterTweakData_multiply_all_speeds", function(cc, ...)
end )
