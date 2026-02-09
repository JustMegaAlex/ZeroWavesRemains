event_inherited()

updateText = function() {
    text = $"Upgrade shield to level {upgrade_level + 2}"
    var next_upgrade_cost = global.balance.items.costs.shield[upgrade_level + 1]
    var cur_dur = oPlayer.shield ? oPlayer.shield.hp : oPlayer.shield_default_hp
    var next_dur = oPlayer.shield_upgrades[upgrade_level + 1]
    text += $"\ndurability {cur_dur} -> {next_dur}"
    text_struct.text = text
    cost_text_struct.text = next_upgrade_cost
}

apply = function() {
    upgrade_level++
    oPlayer.shield.hp = oPlayer.shield_upgrades[upgrade_level]
    oPlayer.shield.hp_max = oPlayer.shield_upgrades[upgrade_level]
    audio_play_sound(sfxWeaponPickup, 2, false)
    if upgrade_level >= max_upgrades {
        text_struct.text = $"Shield fully upgraded"
        cost_text_struct.text = ""
        return;
    }
    cost = global.balance.items.costs.shield[upgrade_level + 1]
    updateText()
}

can_buy = function() {
    return upgrade_level < max_upgrades
}

image_blend = global.game_colors.item_weapon
max_upgrades = array_length(oPlayer.shield_upgrades) - 1

icon = sIconShield
upgrade_level = -1
updateText()
