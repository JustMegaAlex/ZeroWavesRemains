
if !active exit

draw_sprite_ext(
    sprite_index, 1, x, y, image_xscale, yscale,
    image_angle, image_blend, 1
)
draw_sprite_ext(
    sprite_index, 2, x, y, image_xscale, yscale,
    image_angle, image_blend, alpha
)

SetTextAllign(1, 1)
DrawText(x, y, text)
