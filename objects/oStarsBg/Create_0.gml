//// background
var surf_scale = 4
var surf_w = CamW() * surf_scale
var surf_h = CamH() * surf_scale
var stars_num = 300
surf_stars = surface_create(surf_w, surf_h)
surface_set_target(surf_stars)
// draw stars
repeat(stars_num)
    draw_sprite(sStarsBg, irandom(sprite_get_number(sStarsBg)),
				random(surf_w),
				random(surf_h))
surface_reset_target()

// for surface drawing
x_ship_st = 0	// ship's starting location
y_ship_st = 0
if instance_exists(oCamera) {
	x_ship_st = oCamera.x
	y_ship_st = oCamera.y
}
x_draw_stars_start = x_ship_st - surf_w * 0.5
y_draw_stars_start = y_ship_st - surf_h * 0.5

x_draw_stars = x_draw_stars_start
y_draw_stars = y_draw_stars_start
stars_parallax = 0.9
