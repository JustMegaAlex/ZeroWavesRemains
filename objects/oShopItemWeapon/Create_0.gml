event_inherited()

text = prompt_text + $"buy {weapon.name}"

apply = function() {
    oPlayer.unlockWeapon(weapon)
    // var ammo_item = instance_create
    audio_play_sound(sfxWeaponPickup, 2, false)
    instance_create_layer(x, y, layer, oShopItemWeaponUpgrade, {
        weapon: weapon, openx: openx, openy: openy,
        visible: true, is_unlocked: true
    })
    instance_destroy()
}

promptText = promptTextWeapon
