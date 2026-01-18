
event_inherited()

var key = string_lower(weapon.name) + "_ammo"
var conf = global.balance.items.costs[$ key]
cost = conf[0]
ammo_amount = conf[1]
text_struct.text = $"{press_f_prompt} buy {weapon.name} ammo +{ammo_amount}"
cost_text_struct.text = string(cost)
icon = sIconAmmo
image_blend = global.game_colors.item_add_to_shop


can_buy = function() {
    no_player_return
    return array_contains(oPlayer.weapons_array, weapon) and (weapon.ammo < weapon.ammo_max)
}


apply = function() {
    weapon.ammo += ammo_amount
    audio_play_sound(sfxWeaponReload, 2, false)
}
