
if !active or activate_delay_timer.update() exit

mouse_over_me = MouseCollisionGUI(id)

alpha = Approach(alpha, alpha_to, 0.05)
yscale = Approach2(yscale, mouse_over_me ? yscale_hovered : 1, 0.2, 0.01)

alpha_to = 0
if mouse_over_me {
    alpha_to = alpha_hover
    if oInput.Pressed("lclick") {
        alpha_to = alpha_pressed
        action()
    }
}
