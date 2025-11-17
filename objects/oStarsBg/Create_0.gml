
parallaxes = [1, 1, 1]
parallaxes = [0.9, 0.89, 0.88]
surfaces = []
surf_count = arrlen(parallaxes)
//// background
var surf_scale = 3
surf_w = CamW() * surf_scale
surf_h = CamH() * surf_scale
var stars_num = 300
var stars_alpha = 0.65
var space_bg_filled = false
repeat surf_count {
    var surf_stars = surface_create(surf_w, surf_h)
    array_push(surfaces, surf_stars)
    surface_set_target(surf_stars)
    if !space_bg_filled {
        draw_clear(global.game_colors.space_bg)
        space_bg_filled = true
    }
    // draw stars
    draw_set_color(global.game_colors.stars)
    draw_set_alpha(stars_alpha)
    repeat(stars_num / surf_count) {
        draw_sprite(sStars, irandom(sprite_get_number(sStars)),
                    random(surf_w),
                    random(surf_h))
    }
    draw_set_color(c_white)
    draw_set_alpha(1)
    surface_reset_target()
}

// for surface drawing
x_ship_st = 0	// ship's starting location
y_ship_st = 0
if instance_exists(oCamera) {
	x_ship_st = oPlayer.x
	y_ship_st = oPlayer.y
}
x_draw_stars_start = x_ship_st - surf_w * 0.5
y_draw_stars_start = y_ship_st - surf_h * 0.5

x_draw_stars = x_draw_stars_start
y_draw_stars = y_draw_stars_start
scale_parallax = 1
