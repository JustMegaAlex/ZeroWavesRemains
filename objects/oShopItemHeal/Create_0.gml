event_inherited()

prompt_text = prompt_text + $"heal {global.heal_amount}"

can_buy = function() {
    return oPlayer.money >= cost and oPlayer.hp < oPlayer.hp_max
}

apply = function() {
    oPlayer.hp += global.heal_amount
    oPlayer.hp = min(oPlayer.hp_max, oPlayer.hp)
    oPlayer.heal_effect_timer.reset()
    audio_play_sound(sfxRepair, 2, false)
}
