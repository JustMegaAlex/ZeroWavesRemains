event_inherited()

text = $"(Press F) Upgrade {weapon.name} to level 2"

if array_length(weapon.upgrade_confs) == 0 {
    show_debug_message($"No upgrades for weapon {weapon.name}")
    instance_destroy()
    exit
}

cost = weapon.upgrade_confs[0].cost

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
    cost = weapon.upgrade_confs[weapon.upgrades]
    text = $"(Press F) Upgrade {weapon.name} to level {weapon.upgrades+2}"
}

promptText = function() {
     var w = display_get_gui_width()
     var h = display_get_gui_height()
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, text)
    draw_set_color(c_white)
    var col = can_buy() ? c_yellow : c_red
    draw_set_color(col)
    draw_text(w*0.5, h*0.75 + 30, cost)
}
