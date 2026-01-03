event_inherited()

cost = global.balance.items.costs.heal
heal_amount = global.balance.items.heal_amount
text_struct.text = press_f_prompt + $" heal {heal_amount}"
icon = sIconHeal
image_blend = global.game_colors.item_add_to_shop

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.heal(heal_amount)
}
