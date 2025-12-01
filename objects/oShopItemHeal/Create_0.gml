event_inherited()

cost = global.item_costs.heal
text = press_f_prompt + $" heal {global.heal_amount}"
icon = sIconHeal
image_blend = global.game_colors.item_heal

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.heal(global.heal_amount)
}

promptText = promptTextWeapon
