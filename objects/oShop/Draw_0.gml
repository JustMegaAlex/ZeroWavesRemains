

draw_sprite_ext(sprite_index, 0, x, size, image_xscale, -image_yscale, 0, image_blend, 1)
draw_sprite_ext(sprite_index, 0, x, -size, image_xscale, image_yscale, 0, image_blend, 1)
draw_sprite_ext(sprite_index, 0, size, 0, image_xscale, -image_yscale, 90, image_blend, 1)
draw_sprite_ext(sprite_index, 0, -size, 0, image_xscale, image_yscale, 90, image_blend, 1)

if highlight {
    draw_sprite_ext(sShopHighlight, 0, x, size, image_xscale, -image_yscale, 0, c_white, 1)
    draw_sprite_ext(sShopHighlight, 0, x, -size, image_xscale, image_yscale, 0, c_white, 1)
    draw_sprite_ext(sShopHighlight, 0, size, 0, image_xscale, -image_yscale, 90, c_white, 1)
    draw_sprite_ext(sShopHighlight, 0, -size, 0, image_xscale, image_yscale, 90, c_white, 1)
}
