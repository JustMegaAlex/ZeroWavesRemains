event_inherited()

cost = global.item_costs[$ string_lower(weapon.name)][0]
text = prompt_text + $"buy {weapon.name}"
icon = weapon.sprite

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
