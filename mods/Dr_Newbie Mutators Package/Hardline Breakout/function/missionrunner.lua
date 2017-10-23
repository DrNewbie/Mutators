_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(DialogManager, "queue_dialog", "MutatorHardlineBreakout_missionrunner", function(dialog, id, ...)
	if not TMP_mutator_saving:Is_This_Enable("MutatorHardlineBreakout", MutatorHardlineBreakout) then
		return
	end
	local level_id = managers.job:current_level_id()
	if level_id == "hox_1" then
		if id == "Play_dr1_hb1_06" then
			managers.mission:HLBOSET(1)
		elseif id == "Play_dr1_hb1_10" then
			managers.mission:HLBOSET(0)
		elseif id == "Play_dr1_hb1_11" then
			managers.mission:HLBOSET(2)
		end
	elseif level_id == "hox_2" then
		if id == "Play_rb5_hb2_02" then
			managers.mission:HLBOSET(3)
		end
	elseif level_id == "rat" then
		if id == "pln_rat_stage1_16" then
			managers.mission:HLBOSET(1)
		end
		if managers.mission:HLBOGET() > 0 then
			managers.mission:HLBOSET(math.random(1, 2))
		end
	elseif (level_id == "jolly" and id == "Play_vld_as1_02") or 
		(level_id == "peta" and id == "Play_pln_pt1_05") or 
		(level_id == "peta2" and id == "Play_plt_pt2_01") or 
		(level_id == "pbr2" and id == "Play_loc_jr2_11") or 
		(level_id == "crojob3" and id == "Play_pln_cr3_01") then
		managers.mission:HLBOSET(1)
	end
	if managers.mission:HLBOGET() == 0 and managers.mission:HLBOGETRUNONCE() ~= -2 then
		if managers.mission:HLBOGETRUNONCE() == 0 then
			managers.mission:HLBOSETRUNONCE(math.round(TimerManager:game():time())+30)
		end
		if managers.mission:HLBOGETRUNONCE() > 0 and TimerManager:game():time() > managers.mission:HLBOGETRUNONCE() then
			managers.mission:HLBOSETRUNONCE(-1)
		end
		if managers.mission:HLBOGETRUNONCE() == -1 then
			managers.mission:HLBOSETRUNONCE(-2)
			if level_id == "arm_fac" or level_id == "arm_par" or level_id == "arm_hcm" or 
			level_id == "arm_cro" or level_id == "arm_und" or level_id == "arm_for" then
				managers.mission:HLBOSET(1)
			else
				managers.mission:HLBOSET(3)
			end
		end
	end
end)