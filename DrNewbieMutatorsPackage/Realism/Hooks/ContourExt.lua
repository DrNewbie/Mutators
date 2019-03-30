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

local MutatorRealism_upd_color = ContourExt._upd_color

function ContourExt:_upd_color(...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	MutatorRealism_upd_color(self, ...)
end

local MutatorRealism_upd_opacity = ContourExt._upd_opacity

function ContourExt:_upd_opacity(...)
	if TMP_mutator_saving:Is_This_Enable("MutatorRealism", MutatorRealism) then
		return
	end
	MutatorRealism_upd_opacity(self, ...)
end