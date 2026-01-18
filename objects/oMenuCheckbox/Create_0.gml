event_inherited()


action = function() {
    audio_play_sound(sfxClick2, 2, false)
    value = !value
    callback()
}
