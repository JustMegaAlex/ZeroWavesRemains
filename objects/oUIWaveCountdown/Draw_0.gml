
if instance_exists(oWaveSpawner) {
    value = oWaveSpawner.getSpawnCycleProgress()
} else {
    value = 0
}

if !surface_exists(surf) {
    surf = surface_create(sprite_width, sprite_height)
}

surface_set_target(surf)
draw_clear_alpha(c_white, 0)

left = sprite_width * (1 - value)
draw_sprite_part(
    sprite_index, 0,
    left, 0,
    sprite_width, sprite_height,
    left, 0
)

surface_reset_target()

draw_surface(surf, x, y)
draw_surface_ext(surf, x, y, 1, 1, 0, image_blend, image_alpha)
draw_surface_ext(surf, x - 2 * symm_delta_x, y, -1, 1, 0, image_blend, image_alpha)
draw_surface_ext(surf, x - 2 * symm_delta_x, y - 2 * symm_delta_y, -1, -1, 0, image_blend, image_alpha)
draw_surface_ext(surf, x, y - 2 * symm_delta_y, 1, -1, 0, image_blend, image_alpha)
