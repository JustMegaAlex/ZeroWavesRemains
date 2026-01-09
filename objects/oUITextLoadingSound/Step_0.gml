
if !animation_timer.update() {
    animation_timer.reset()
    if dots >= 3 {
        text = text_base
        dots = 0
    } else {
        text += "."
        dots++
    }
}

if audio_group_is_loaded(audiogroup_load_after) {
    instance_destroy()
}
