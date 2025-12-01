/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited()

var ind = 0
array = []
array_of_initial_gains = []
while audio_exists(ind) {
    if !ArrayHas(global.music_assets, ind) {
        array_push(array, ind)
        array_push(array_of_initial_gains, audio_sound_get_gain(ind))
    }
    ind++
}

name = "SFX"
