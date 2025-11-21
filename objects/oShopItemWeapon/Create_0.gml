event_inherited()

text = prompt_text + $"buy {weapon.name}"

apply = function() {
    oPlayer.unlockWeapon(weapon)
    audio_play_sound(sfxWeaponPickup, 2, false)
}
