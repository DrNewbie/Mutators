_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

CloneClass( BaseInteractionExt )

function BaseInteractionExt.set_contour(self, color, opacity)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	self.orig.set_contour(self, color, opacity)
end