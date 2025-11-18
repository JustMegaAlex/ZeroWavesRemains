
if heal_effect_timer.update() {
    draw_sprite_ext(
        sprite_index, 0, x, y,
        1.5, 1.5, dir, #65FF65,
        heal_effect_timer.timer/heal_effect_timer.time * 0.5
    )
}

event_inherited()


