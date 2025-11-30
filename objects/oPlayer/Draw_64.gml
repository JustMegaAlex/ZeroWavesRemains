// draw_healthbar(30, 30, 400, 70, hp, c_grey, c_red, c_green, 0, true, true)
// var ammo_percent = weapon.ammo/weapon.ammo_max * 100
// draw_healthbar(30, 90, 400, 130, ammo_percent, c_grey, c_yellow, c_yellow, 0, true, true)
// draw_set_font(fntUIBig)
// SetTextAllign(0, 1)
// draw_text(50, 50, "hp")
// draw_set_color(c_green)
// draw_text(50, 110, $"{weapon.name}")
// draw_set_color(c_white)
SetTextAllign(0, 1)
if display_waves {
    draw_text(10, 160, $"Waves remains: {global.waves_remains}")
}
if display_money {
    draw_text(10, 200, $"Money: {money}")
}

var w = display_get_gui_width()
var h = display_get_gui_height()
var xx = w*0.5
var yy = h*0.75
SetTextAllign(1, 1)
if oShop.highlight {
    draw_text(xx, yy, "Press F to open shop")
}
SetTextAllign(1, 0)
if shop_item {
    shop_item.promptText()
} else if oWaveSpawner.active and global.wave_enemies_count <= 0 {
    draw_text(w*0.5, h*0.75 + 60, "Press Space for the next wave!")
}
