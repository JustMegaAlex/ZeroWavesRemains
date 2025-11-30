event_inherited()

cost = global.item_costs.heal
text = press_f_prompt + $" heal {global.heal_amount}"
icon = sIconHeal

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.heal(global.heal_amount)
}

promptText = promptTextWeapon
