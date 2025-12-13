
alarm[0] = 30 /// always poll gamepad connection

if !gamepad_enabled { exit }

if gp_id != -1 and gamepad_is_connected(gp_id) {
    exit
}
if !DetectGamepadDevice() {
    gp_info = "No gamepad detected"
    gp_id = -1
} else {
    gamepad_set_axis_deadzone(gp_id, 0.25)
}
