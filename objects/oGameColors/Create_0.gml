
order = [
    oPlayer,
    oEnemyParent,
    oBullet,
    "space_bg",
    "stars",
    oCollectCoin,
    oShop,
    "item_choice",
    "item_weapon",
    "item_consumable",
    "item_add_to_shop",
    "arrow_enemy",
    "arrow_drone",
    "arrow_common",
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
