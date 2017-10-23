_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

CloneClass( ContourExt )

function ContourExt.init(self, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	return self.orig.init(self, ...)
end

function ContourExt.add(self, ...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	return self.orig.add(self, ...)
end