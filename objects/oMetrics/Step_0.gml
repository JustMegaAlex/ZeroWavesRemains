
if !is_dev and oInput.Pressed("lclick") {
    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();
    if point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom) {
        is_dev_secret_input++
        is_dev = is_dev_secret_input >= 10
        if is_dev {
            image_alpha = 0.5
        }
    }
}
image_alpha = max(0, image_alpha - 0.01)
