// draw_healthbar(30, 30, 400, 70, hp, c_grey, c_red, c_green, 0, true, true)
// var ammo_percent = weapon.ammo/weapon.ammo_max * 100
// draw_healthbar(30, 90, 400, 130, ammo_percent, c_grey, c_yellow, c_yellow, 0, true, true)
// draw_set_font(fntUIBig)
// SetTextAllign(0, 1)
// draw_text(50, 50, "hp")
// draw_set_color(c_green)
// draw_text(50, 110, $"{weapon.name}")
// draw_set_color(c_white)
draw_text(50, 160, $"Waves remains: {oWaveSpawner.waves_remains}")
draw_text(50, 200, $"Money: {money}")

var w = display_get_gui_width()
var h = display_get_gui_height()
if shop_item {
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, shop_item.text)
    var col = shop_item.can_buy() ? c_yellow : c_red
    draw_set_color(col)
    draw_text(w*0.5, h*0.75 + 30, shop_item.cost)
    draw_set_color(c_white)
}

if global.wave_enemies_count <= 0 {
    draw_text(w*0.5, h*0.75 + 60, "Press Space for the next wave!")
}