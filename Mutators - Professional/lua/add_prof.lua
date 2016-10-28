_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

if not tweak_data or not tweak_data.narrative or not tweak_data.narrative._jobs_index then
	return	
end

local _bool4onoff = TMP_mutator_saving:Is_This_Enable("MutatorsProfessional")
for _, _job_name in ipairs(tweak_data.narrative._jobs_index) do
	if _bool4onoff then
		tweak_data.narrative.jobs[_job_name].professional = true
		tweak_data.narrative.jobs[_job_name].region = "professional"
	else
		tweak_data.narrative.jobs[_job_name].professional = false
		tweak_data.narrative.jobs[_job_name].region = "street"
	end
end