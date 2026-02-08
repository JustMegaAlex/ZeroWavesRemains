event_inherited()

show_timer = MakeTimer(240, 0)
blink_period = 30
blink_rot_sp = 360 / blink_period

text = new Text(0, 0, "[Persistent progression]\nNew tech unlocked", {font: fntUI, color: c_lime})

show = function() {
    //text.alpha = 1
    show_timer.reset()
}

set_visible = function() {
    
}
