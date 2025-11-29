event_inherited()

text = prompt_text + $"upgrade {weapon.name} level 1"

apply = function() {
    var conf = weapon.upgrade_confs[weapon.upgrades]
    var keys = variable_struct_get_names(conf)
    for (var i = 0; i < array_length(keys); ++i) {
        var parameter = keys[i]
        var value = conf[$ parameter]
        weapon[$ parameter] = value
    }
    text = prompt_text + $"upgrade {weapon.name} to level {weapon.upgrades+1}"
    weapon.upgrades++
    audio_play_sound(sfxWeaponPickup, 2, false)
    if weapon.upgrades >= weapon.upgrades_max {
        instance_destroy()
    }
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
