
if instance_exists(oPlayer) {
    value = oPlayer.hp / oPlayer.hp_max
}

var top = sprite_height * (1 - value)
draw_sprite_part(
    sprite_index, 0,
    0, top,
    sprite_width, sprite_height,
    x, y + top
)

