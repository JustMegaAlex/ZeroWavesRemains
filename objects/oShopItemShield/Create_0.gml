event_inherited()

if !is_purchased {
    cost = global.balance.items.costs.shield
    cost_text_struct.text = string(cost)
    text_struct.text = prompt_text + $"buy shield"
} else {
    cost = 0
    cost_text_struct.text = ""
    text_struct.text = $"You already have shield"
}
icon = sIconShield
image_blend = global.game_colors.item_weapon

can_buy = function() { return !is_purchased }

apply = function() {
    oPlayer.unlockShield()
    audio_play_sound(sfxWeaponPickup, 2, false)
    is_purchased = true
    show_cost = false
    cost_text_struct.text = ""
    text_struct.text = $"You already have shield"
}

is_unlocked = oGameState.techUnlocked("shield")
is_unlocked_initially = is_unlocked
