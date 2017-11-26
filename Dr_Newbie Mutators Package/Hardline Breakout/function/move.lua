_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

function _boolsomething()
	if Utils:IsInHeist() then
		if TMP_mutator_saving:Is_This_Enable("MutatorHardlineBreakout", MutatorHardlineBreakout) and managers.mission:HLBOGET() > 0 then
			return true
		end
	end
	return false
end

local _t_delay = 0
local _fire_date = {}
local _frag = "frag"
local _rocket_frag = "rocket_frag"

Hooks:Add("GameSetupUpdate", "HLBODGameSetupUpdate", function(t, dt)
	 local rand_vector3_use = function(hlbo, t, fire_set)
		local pos
		local result = {}
		local use_v3_list = {}
		for _, data in pairs(managers.groupai:state():all_player_criminals()) do
			use_v3_list[#use_v3_list+1] = data.unit:position()
		end
		if use_v3_list and #use_v3_list > 0 then
			for i = 1, fire_set do
				pos = use_v3_list[math.random(#use_v3_list)]
				local projectile_index
				if hlbo == 3 then
					pos = pos + Vector3(math.random(-400,400), math.random(-400,400), 100)
					projectile_index = _frag
				elseif hlbo == 2 then
					pos = pos + Vector3(math.random(-500,500), math.random(-500,500), 100)
					projectile_index = _frag
				else
					pos = pos + Vector3(math.random(-800,800), math.random(-800,800), 5000)
					projectile_index = _rocket_frag
				end
				local delay = t + math.random()*5
				result[#result+1] = {pos = pos, delay = delay, projectile_index = projectile_index}
			end
		end
		return result
	end
	if _boolsomething() then
		if t > _t_delay then
			local _t = math.round(t)
			_t_delay = _t + 10
			local hlbo = managers.mission:HLBOGET()
			if hlbo == 1 then
				_fire_date = rand_vector3_use(hlbo, _t, 7)
			elseif hlbo == 2 then
				_fire_date = rand_vector3_use(hlbo, _t, 10)
			elseif hlbo == 3 then
				_fire_date = rand_vector3_use(hlbo, _t, 10)
			end
			math.randomseed(os.time()+t)
		end
		if _fire_date and #_fire_date > 0 then
			for k, v in pairs(_fire_date) do
				if v and v ~= {} and t > v.delay and v.projectile_index and v.pos then
					ProjectileBase.throw_projectile(v.projectile_index, v.pos, Vector3(0, 0, -1), 1)
					_fire_date[k] = {}
					_fire_date[k] = nil
				end
			end
		end
	end
end)

tweak_data.blackmarket.projectiles.rocket_frag.time_cheat = 0.1