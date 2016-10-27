local FreeMyMutators_NetworkMatchMakingSTEAM_set_attributes = NetworkMatchMakingSTEAM.set_attributes
function NetworkMatchMakingSTEAM:set_attributes(settings, ...)
	if settings and settings.numbers[3] == 1 then
		settings.numbers[3] = 2
	end
	return FreeMyMutators_NetworkMatchMakingSTEAM_set_attributes(self, settings, ...)
end

local FreeMyMutators_NetworkMatchMakingSTEAM_is_server_ok = NetworkMatchMakingSTEAM.is_server_ok
function NetworkMatchMakingSTEAM:is_server_ok(friends_only, room, attributes_numbers, ...)
	if attributes_numbers[3] == 1 then
		return false
	end
	return FreeMyMutators_NetworkMatchMakingSTEAM_is_server_ok(self, friends_only, room, attributes_numbers, ...)
end
