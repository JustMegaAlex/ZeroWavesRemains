
var draw_shield = false
if instance_exists(oPlayer) {
    value = oPlayer.hp / oPlayer.hp_max
    if oPlayer.shield != noone {
        draw_shield = true
        shield_value = oPlayer.shield.hp / oPlayer.shield.hp_max
    }
} else {
    value = 0
}

var top = sprite_height * (1 - value)
draw_sprite_part(
    sprite_index, 0,
    0, top,
    sprite_width, sprite_height,
    x, y + top
)

if draw_shield {
    top = sprite_height * (1 - shield_value)
    draw_sprite_part_ext(
        sUIShieldBar, 0,
        0, top,
        sprite_width, sprite_height,
        x, y + top, image_xscale, image_yscale,
        c_blue, 1
    )
}

