Hooks:PostHook(MissionManager, "init", "MutatorHardlineBreakout_missionnow", function(miss, ...)
	miss.hardlinebreakout = 0
	miss.hardlinebreakout_run_once = 0
end)

function MissionManager:HLBOSET(var)
	self.hardlinebreakout = var
end

function MissionManager:HLBOGET()
	return self.hardlinebreakout
end

function MissionManager:HLBOSETRUNONCE(var)
	self.hardlinebreakout_run_once = var
end

function MissionManager:HLBOGETRUNONCE()
	return self.hardlinebreakout_run_once
end