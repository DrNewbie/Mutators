_G.TMP_mutator_saving = _G.TMP_mutator_saving or {}

Hooks:PostHook(ContourExt, "update", "MutatorRealismBlockContourExt", function(self)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		if type(self._contour_list) == "table" then
			while type(self._contour_list) == "table" and index <= #self._contour_list do
				self:_remove(index, true)
			end
		end
	end
end )