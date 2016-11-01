_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

local MutatorRealismBlockContourExtAdd = ContourExt.add

function ContourExt:add(_type, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	return MutatorRealismBlockContourExtAdd(self, _type, ...)
end