event_inherited()

if !show_timer.update() {
    visible = false
} else {
    // 0.5 .. 1
    visible = true
    text.alpha = 0.75 + lengthdir_x(0.25, oSys.frames_since_start * blink_rot_sp)
}
