event_inherited()

cost = global.balance.items.costs[$ string_lower(weapon.name)].weapon_cost
text_struct.text = prompt_text + $"buy {weapon.name}"
icon = weapon.sprite
image_blend = global.game_colors.item_weapon
is_purchased = false

can_buy = function() { return !is_purchased }

apply = function() {
    oPlayer.unlockWeapon(weapon)
    audio_play_sound(sfxWeaponPickup, 2, false)
    is_purchased = true
    show_cost = false
    cost_text_struct.text = ""
    text_struct.text = $"You already have {weapon.name}"
}
