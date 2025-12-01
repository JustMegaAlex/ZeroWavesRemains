event_inherited()

_key_remap = {
    sp: "bullet speed",
    dmg: "damage"
}
updateText = function() {
    text = $"(Press F) Upgrade {weapon.name} to level 2"
    var next_upgrade_conf = weapon.upgrade_confs[weapon.upgrades]
    var keys = variable_struct_get_names(next_upgrade_conf)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        if key == "cost" {
            continue
        }
        var next_value = next_upgrade_conf[$ key]
        var value = weapon[$ key]
        if struct_has(_key_remap, key) {
            key = _key_remap[$ key]
        }
        if key == "timer" {
            next_value = 60 / next_value.time
            value = 60 / value.time
            key = "fire rate"
        }
        text += $"\n{key} {value} -> {next_value}"
    }
}


if array_length(weapon.upgrade_confs) == 0 {
    show_debug_message($"No upgrades for weapon {weapon.name}")
    instance_destroy()
    exit
}

cost = weapon.upgrade_confs[0].cost
updateText()

apply = function() {
    var conf = weapon.upgrade_confs[weapon.upgrades]
    var keys = variable_struct_get_names(conf)
    for (var i = 0; i < array_length(keys); ++i) {
        var parameter = keys[i]
        var value = conf[$ parameter]
        weapon[$ parameter] = value
    }
    weapon.upgrades++
    audio_play_sound(sfxWeaponPickup, 2, false)
    if weapon.upgrades >= weapon.upgrades_max {
        instance_destroy()
        return;
    }
    cost = weapon.upgrade_confs[weapon.upgrades].cost
    updateText()
}

promptText = promptTextWeapon
image_blend = global.game_colors.item_weapon
