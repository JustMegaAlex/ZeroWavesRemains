
event_inherited()

ammo_percent = global.balance.items.ammo_percent
ammo_amount = round(oPlayer.weapon.ammo_max * ammo_percent)
text = $"{press_f_prompt} buy {oPlayer.weapon.name} ammo + {ammo_amount}"
icon = sIconAmmo
cost = global.balance.items.costs.ammo
image_blend = global.game_colors.item_add_to_shop


apply = function() {
    oPlayer.weapon.ammo += ammo_amount
    audio_play_sound(sfxWeaponReload, 2, false)
}
