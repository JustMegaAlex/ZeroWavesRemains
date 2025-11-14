frames_since_start++
//
//if keyboard_check_pressed(vk_f1) {
	//show_debug_overlay(!is_debug_overlay_open(), false)
//}

if oInput.Pressed("reload") {
	room_restart()
}

if oInput.Pressed("escape") {
    if IsHtmlBuild() {
        global.pause = !global.pause
    } else {
        game_end()
    }
}

if oInput.Pressed("pause") {
    global.pause = !global.pause
}
