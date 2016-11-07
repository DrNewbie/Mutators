CloneClass( ContourExt )

Hooks:RegisterHook("ContourExtPreInitialize")
Hooks:RegisterHook("ContourExtPostInitialize")
function ContourExt.init(self, ...)
	Hooks:Call("ContourExtPreInitialize", self, ...)
	self.orig.init(self, ...)
	Hooks:Call("ContourExtPostInitialize", self, ...)
end

Hooks:RegisterHook("ContourExtPreAdd")
function ContourExt.add(self, ...)
	local r = Hooks:ReturnCall("ContourExtPreAdd", self, ...)
	if r ~= nil then
		return
	end
	return self.orig.add(self, ...)
end