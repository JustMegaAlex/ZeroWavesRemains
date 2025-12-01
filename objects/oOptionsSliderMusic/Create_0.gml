event_inherited()

array = global.music_assets
array_of_initial_gains = []
for (var i = 0; i < array_length(array); ++i) {
    array_push(array_of_initial_gains, audio_sound_get_gain(array[i]))
}
name = "Music"
