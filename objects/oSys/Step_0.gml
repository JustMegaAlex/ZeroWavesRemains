frames_since_start++
//
 if DEV and key_pressed(vk_f5) {
     show_debug_overlay(!is_debug_overlay_open())
 }

if (global.gameover or global.pause or global.win) and oInput.Pressed("reload") {
    Restart()
}

if false and oInput.Pressed("escape") {
    if IsHtmlBuild() or (os_type == os_gxgames) {
        global.pause = !global.pause
    } else {
        game_end()
    }
}

if oInput.Pressed("pause") {
    var dud = global.pause ? Unpause() : Pause()
}
