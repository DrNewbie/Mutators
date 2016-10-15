Hooks:Add("NetworkReceivedData", "NetworkReceivedData_MutatorRealism_Sync_Check", function(sender, sync_asked, data)
	if not Network:is_client() and sync_asked and data == 1 and sender ~= 1 then
		local _Net = _G and _G.LuaNetworking or nil
		if _Net and sync_asked == "MutatorRealism_Sync_Check" then
			managers.chat:feed_system_message(ChatManager.GAME, "[MutatorRealism] " .. _Net:GetNameFromPeerID(sender) .. " is online")
		end
	end
end)