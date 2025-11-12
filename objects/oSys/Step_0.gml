frames_since_start++

if keyboard_check_pressed(vk_f1) {
	show_debug_overlay(!is_debug_overlay_open(), false)
}

if keyboard_check_pressed(vk_f2) {
    if oLevelEditor.active {
        oLevelEditor.Deactivate()
    } else {
        oLevelEditor.Activate()
    }
}
if keyboard_check_pressed(vk_f3) {
    if global.pause {
        oLevelEditor.UnpauseHook()
		global.pause = false
    } else {
		global.pause = true
        oLevelEditor.PauseHook()
    }
}

if oInput.Pressed("reload") {
	room_restart()
}

if oInput.Pressed("escape") {
    if room == rmStart {
        game_end()
    } else {
        room_goto(rmStart)
    }
}
