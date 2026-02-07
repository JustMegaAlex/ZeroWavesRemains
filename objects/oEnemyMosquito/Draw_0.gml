//event_inherited()

no_player_exit

if is_long_range_state {
    draw_set_color(c_red)
    draw_set_alpha((1 - weapon_snipe.timer.ratio()) * 0.7)

    if abs(InstDir(oPlayer) - dir) > 2 {
        help_vec.setv(id).add_polar(5000, dir)
    } else {
        help_vec.setv(oPlayer)
    }
    draw_line_width(x, y, help_vec.x, help_vec.y, 10)
    
    draw_set_alpha(1)
    draw_set_color(c_white)
}
