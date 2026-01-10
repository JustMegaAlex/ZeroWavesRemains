// draw_healthbar(30, 30, 400, 70, hp, c_grey, c_red, c_green, 0, true, true)
// var ammo_percent = weapon.ammo/weapon.ammo_max * 100
// draw_healthbar(30, 90, 400, 130, ammo_percent, c_grey, c_yellow, c_yellow, 0, true, true)
// draw_set_font(global.ui_fontBig)
// SetTextAllign(0, 1)
// draw_text(50, 50, "hp")
// draw_set_color(c_green)
// draw_text(50, 110, $"{weapon.name}")
// draw_set_color(c_white)
// DebugDrawVar("dir")
// DebugDrawVar("pull_angle", gp_dir.pull_angle)
// DebugDrawVar("last", keyboard_lastkey)
// DebugDrawVar("key", keyboard_key)


SetTextAllign(0, 1)
draw_set_font(global.ui_font)
if display_waves {
    draw_text(10, 160, $"Waves remains: {global.waves_remains}")
}
if display_money {
    draw_text(10, 200, $"Money: {money}")
}
