event_inherited()

cost = global.balance.items.costs[$ string_lower(weapon.name)][0]
text = prompt_text + $"buy {weapon.name}"
icon = weapon.sprite
image_blend = global.game_colors.item_weapon

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
