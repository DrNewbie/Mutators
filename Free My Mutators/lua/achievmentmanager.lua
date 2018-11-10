function AchievmentManager:award_progress(stat, value)
	if Application:editor() then
		return
	end
	managers.challenge:on_achievement_progressed(stat)
	managers.custom_safehouse:on_achievement_progressed(stat, value)
	managers.generic_side_jobs:award(stat)
	if SystemInfo:platform() == Idstring("WIN32") then
		self.handler:achievement_store_callback(AchievmentManager.steam_unlock_result)
	end
	local unlocks = tweak_data.achievement.persistent_stat_unlocks[stat] or {}
	local old_value = managers.network.account:get_stat(stat)
	local unlock_check = table.filter_list(unlocks, function (v)
		local info = self:get_info(v.award)

		if info and info.awarded then
			return false
		end

		return old_value <= v.at
	end)
	local stats = {
		[stat] = {
			type = "int",
			value = value or 1
		}
	}
	managers.network.account:publish_statistics(stats, true)
	local new_value = managers.network.account:get_stat(stat)
	for _, d in pairs(unlock_check) do
		if d.at <= new_value then
			self:award(d.award)
		end
	end
end