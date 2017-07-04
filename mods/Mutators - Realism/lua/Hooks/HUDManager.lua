CloneClass( HUDManager )

Hooks:RegisterHook("HUDManagerPreAddWaypoint")
function HUDManager.add_waypoint(self, ...)
	local r = Hooks:ReturnCall("HUDManagerPreAddWaypoint", self, ...)
	if r then
		return
	end
	return self.orig.add_waypoint(self, ...)
end

Hooks:RegisterHook("HUDManagerPreAddNameLabel")
function HUDManager._add_name_label(self, ...)
	Hooks:Call("HUDManagerPreAddNameLabel", self, ...)
	return self.orig._add_name_label(self, ...)
end