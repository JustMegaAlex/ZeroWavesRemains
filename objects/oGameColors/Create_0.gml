
order = [
    oPlayer,
    oEnemy,
    oBullet,
    "space_bg",
    "stars",
    oCoin,
    oShop,
]

cellw = 64

surf = surface_create(
    sprite_width, sprite_height
)

surface_set_target(surf)
draw_sprite(sprite_index, image_index, 0, 0)
surface_reset_target()

for (var i = 0; i < array_length(order); ++i) {
    var item = order[i]
    var xx = 4 + i * cellw
    var yy = cellw + 4
    if !is_string(item) {
        item = object_get_name(item)
    }
    var col = surface_getpixel(surf, xx, yy)
    global.game_colors[$ item] = col
}

surface_free(surf)
