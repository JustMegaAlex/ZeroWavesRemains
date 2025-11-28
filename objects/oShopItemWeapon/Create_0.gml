event_inherited()

text = prompt_text + $"buy {weapon.name}"

apply = function() {
    oPlayer.unlockWeapon(weapon)
    // var ammo_item = instance_create
    audio_play_sound(sfxWeaponPickup, 2, false)
    instance_destroy()
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