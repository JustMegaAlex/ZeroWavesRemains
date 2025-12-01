
for (var i = 0; i < max_num; ++i) {
    draw_sprite(sprite_index, 0, x + i * xstep, y)
    if (i+1) <= filled_bars_number {
        draw_sprite(sprite_index, 1, x + i * xstep, y)
    }
}
