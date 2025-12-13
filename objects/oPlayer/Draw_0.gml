
if heal_effect_timer.update() {
    draw_sprite_ext(
        sprite_index, 0, x, y,
        1.5, 1.5, dir, #65FF65,
        heal_effect_timer.timer/heal_effect_timer.time * 0.5
    )
}

event_inherited()

if !oInput.is_user_input_keyboard {
    draw_set_color(c_red)
    draw_line(oPlayer.x, oPlayer.y, gp_dir.vec.x, gp_dir.vec.y)
    draw_set_color(c_white)
}

if DEV {
    // with oEnemyParent {
    //     draw_line(x, y, other.x, other.y)
    // }
}
