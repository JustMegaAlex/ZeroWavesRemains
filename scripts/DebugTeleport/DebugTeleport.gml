
function DbgTeleport(label, obj) {
	with oDebugTeleport {
		if self.label == label {
			if UsesPhysics(obj) {
				obj.phy_position_x = x
				obj.phy_position_y = y
			} else {
				obj.x = x
				obj.y = y
			}
			show_debug_message("Success")
			return;
		}
	}
	show_debug_message($"Teleport object not found: {label}")
}

function DbgTeleportLs() {
	if !instance_exists(oDebugTeleport) {
		show_debug_message("No teleports in this room")
	}
	with oDebugTeleport {
		show_debug_message($"{self.label} x={x} y={y}")
	}
}