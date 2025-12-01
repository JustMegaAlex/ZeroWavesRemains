if !active {
    exit
}

var mx = window_mouse_get_x()
var my = window_mouse_get_y()
var cursor_over_bar = collision_point(
    mx, my, id, false, false
)

if oInput.Pressed("lclick") and cursor_over_bar {
	knob_is_dragged = true
}
if knob_is_dragged {
    if !oInput.Hold("lclick") {
        knob_is_dragged = false
    } else {
        knobx = mx
    }
    knobx = clamp(knobx, knob_xmin, knob_xmax)
}


if knob_is_dragged {
    controlFunction(Value())
}
