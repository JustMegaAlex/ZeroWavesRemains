event_inherited()

text = prompt_text + $"buy {weapon.name}"

apply = function() {
    array_push(oPlayer.weapons_array, weapon)
    audio_play_sound(sfxWeaponPickup, 2, false)
}
