draw_self()

if highlight {
    draw_sprite(sprite_index, 1, x, y)
}

if oShop.is_open and icon {
    draw_sprite_ext(
        icon, 0, x, y,
        icon_scale, icon_scale, 0, c_white, 1
    )
}
