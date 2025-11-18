
event_inherited()

text = prompt_text + $"buy {weapon.name} ammo +{ammo}"

apply = function() {
    weapon.ammo += ammo
    audio_play_sound(sfxWeaponReload, 2, false)
}
