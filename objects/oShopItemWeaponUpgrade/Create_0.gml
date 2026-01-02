event_inherited()

_key_remap = {
    sp: "bullet speed",
    dmg: "damage"
}
updateText = function() {
    text = $"(Press F) Upgrade {weapon.name} {upgrade_conf.name} to level {upgrade_level + 2}"
    var next_upgrade_cost = upgrade_conf.costs[upgrade_level + 1]
    var keys = variable_struct_get_names(upgrade_conf.stats)
    /// Legacy structure: it's supposed to have only one stat
    for (var i = 0; i < array_length(keys); ++i) {
        var stat_name = keys[i]
        var next_value = upgrade_conf.stats[$ stat_name][upgrade_level + 1]
        var value = weapon[$ stat_name]
        var name = upgrade_conf.name
        if name == "fire rate" {
            next_value = 60 / next_value.time
            value = 60 / value.time
        }
        text += $"\n{value} -> {next_value}"
    }
}


cost = upgrade_conf.costs[0]
icon = weapon.sprite
upgrade_level = -1
updateText()

apply = function() {
    upgrade_level++
    var conf = upgrade_conf
    var keys = variable_struct_get_names(conf.stats)
    var max_upgrades = 0
    for (var i = 0; i < array_length(keys); ++i) {
        var stat_name = keys[i]
        var level_values = conf.stats[$ stat_name] // array
        var value = level_values[upgrade_level]
        weapon[$ stat_name] = value

        max_upgrades = array_length(level_values) - 1
    }
    audio_play_sound(sfxWeaponPickup, 2, false)
    if upgrade_level >= max_upgrades {
        instance_destroy()
        return;
    }
    cost = conf.costs[upgrade_level]
    updateText()
}

promptText = promptTextWeapon
image_blend = global.game_colors.item_weapon

var splitted = string_split(upgrade_string, ".")
var weapon_var_name = splitted[0]
var upgrade_conf_var_name = splitted[1]
weapon = inst_get(oPlayer, weapon_var_name)
upgrade_conf = weapon.upgrade_confs[$ upgrade_conf_var_name]
