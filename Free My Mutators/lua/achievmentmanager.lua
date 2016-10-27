function AchievmentManager:award_progress(stat, value)
	if Application:editor() then
		return
	end
	managers.challenge:on_achievement_progressed(stat)
	managers.custom_safehouse:on_achievement_progressed(stat, value)
	if game_state_machine:current_state_name() ~= "menu_main" then
		return
	end
	print("[AchievmentManager:award_progress]: ", stat .. " increased by " .. tostring(value or 1))
	if SystemInfo:platform() == Idstring("WIN32") then
		self.handler:achievement_store_callback(AchievmentManager.steam_unlock_result)
	end
	local stats = {}
	stats[stat] = {
		type = "int",
		value = value or 1
	}
	managers.network.account:publish_statistics(stats, true)
end