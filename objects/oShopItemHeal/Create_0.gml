event_inherited()

cost = global.item_costs.heal
prompt_text = prompt_text + $"heal {global.heal_amount}"

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.heal(global.heal_amount)
}
