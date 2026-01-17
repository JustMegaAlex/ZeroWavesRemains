
// draw_set_color(blend)
draw_sprite_ext(sprite_index, up, x, y + anim.y, 1, 1, 0, blend, 1)
draw_sprite_ext(sprite_index, down, x, y - anim.y, 1, 1, 0, blend, 1)

// draw_set_alpha(bg_alpha)
draw_sprite_ext(sprite_index, up_bg, x, y + anim.y, 1, 1, 0, blend, bg_alpha)
draw_sprite_ext(sprite_index, down_bg, x, y - anim.y, 1, 1, 0, blend, bg_alpha)
// draw_set_alpha(1)


draw_sprite_ext(sprite_index, coin, x, y + anim.y, 1, 1, 0, coin_color, 1)

SetTextAllign(1, 1)
draw_text_colour(x, y, coins, blend, blend, blend, blend, 1)

