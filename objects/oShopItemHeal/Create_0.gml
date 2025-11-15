event_inherited()

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.hp += 10
    oPlayer.hp = min(oPlayer.hp_max, oPlayer.hp)
}
