Hooks:PostHook(MutatorsManager, "init", "MutatorRealismNew", function(mm, ...)
	table.insert(mm._mutators, MutatorRealism:new(mm))
end )

_G._tmp_mutator_saving = _G._tmp_mutator_saving or {}

local _file = io.open(SavePath .. "tmp_mutator_saving.txt", "r")
if _file then
	_tmp_mutator_saving = json.decode(_file:read("*all"))
	_file:close()
end

function MutatorsManager:set_enabled(mutator, enabled)
	if enabled == nil then
		enabled = true
	end
	if type(mutator) == "string" then
		mutator = self:get_mutator_from_id(mutator)
	end
	if not mutator then
		return false
	end
	if enabled and self:can_enable_mutator(mutator) then
		mutator:set_enabled(enabled)	
		_tmp_mutator_saving[tostring(mutator:id())] = enabled
	else
		mutator:set_enabled(false)
		_tmp_mutator_saving[tostring(mutator:id())] = false
	end	
	local _file = io.open(SavePath .. "tmp_mutator_saving.txt", "w+")
	if _file then
		_file:write(json.encode(_tmp_mutator_saving))
		_file:close()
	end
end