
event_inherited()

var key = string_lower(weapon.name) + "_ammo"
var conf = global.balance.items.costs[$ key]
cost = conf[0]
ammo_amount = conf[1]
text_struct.text = $"{press_f_prompt} buy {weapon.name} ammo +{ammo_amount}"
icon = sIconAmmo
image_blend = global.game_colors.item_add_to_shop


apply = function() {
    oPlayer.weapon.ammo += ammo_amount
    audio_play_sound(sfxWeaponReload, 2, false)
}
