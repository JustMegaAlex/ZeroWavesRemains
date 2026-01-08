
if !active or activate_delay_timer.update() exit

var mouse_over_me_prev = mouse_over_me
mouse_over_me = MouseCollisionGUI(id)

alpha = Approach(alpha, alpha_to, 0.05)
yscale = Approach2(yscale, mouse_over_me ? yscale_hovered : 1, 0.3, 0.01)

alpha_to = 0
if mouse_over_me {
    if !mouse_over_me_prev {
        audio_play_sound(sfxButtonHover2, 2, false)
    }
    alpha_to = alpha_hover
    if oInput.Pressed("lclick") {
        alpha_to = alpha_pressed
        action()
    }
}
