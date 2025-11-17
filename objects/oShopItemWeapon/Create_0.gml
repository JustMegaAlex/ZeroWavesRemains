event_inherited()

text = $"Buy {weapon.name}"

apply = function() {
    array_push(oPlayer.weapons_array, weapon)
    audio_play_sound(sfxWeaponReload, 2, false)
}
