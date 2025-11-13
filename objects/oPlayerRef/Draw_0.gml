event_inherited()

// draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, dir, c_white, 1)
if items.highlight {
    SetTextAllign(fa_center, fa_middle)
    draw_set_color(global.items_text_colors[$ items.highlight.type])
    draw_text(items.highlight.x, items.highlight.y - 50, $"{items.highlight.name} x{items.highlight.quantity}")
    if items.highlight.cost != -1 {
        draw_text(items.highlight.x, items.highlight.y - 30, $"{items.highlight.cost}c")
    }
}

if aim_target {
    draw_line(
        x, y, 
        x + lengthdir_x(200, aim_angle), 
        y + lengthdir_y(200, aim_angle))
}

draw_set_color(c_white)
