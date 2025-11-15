draw_healthbar(30, 30, 400, 70, hp, c_grey, c_red, c_green, 0, true, true)
var ammo_percent = weapon.ammo/weapon.ammo_max * 100
draw_healthbar(30, 90, 400, 130, ammo_percent, c_grey, c_yellow, c_yellow, 0, true, true)
draw_set_font(fntUIBig)
SetTextAllign(0, 1)
draw_text(50, 50, "hp")
draw_set_color(c_green)
draw_text(50, 110, $"{weapon.name}")
draw_set_color(c_white)
draw_text(50, 160, $"Waves remains: {oWaveSpawner.waves_remains}")
draw_text(50, 200, $"Money: {money}")

if shop_item {
    SetTextAllign(1, 0)
    var xx = window_get_width() * 0.5
    var yy = window_get_height() * 0.75
    draw_text(xx, yy, shop_item.text)
    var col = shop_item.can_buy() ? c_yellow : c_red
    draw_set_color(col)
    draw_text(xx, yy + 30, shop_item.cost)
    draw_set_color(c_white)
}
