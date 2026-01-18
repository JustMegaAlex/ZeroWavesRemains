event_inherited()

show_timer = MakeTimer(30, 0)
blink_period = 30
blink_rot_sp = 360 / blink_period

text = new Text(0, 0, "No ammo", {font: fntUI, color: c_red})

show = function() {
    //text.alpha = 1
    show_timer.reset()
}

set_visible = function() {
    
}
