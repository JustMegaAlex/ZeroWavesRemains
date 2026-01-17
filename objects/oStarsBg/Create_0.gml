
parallaxes = [1, 1, 1]
parallaxes = [0.9, 0.89, 0.88]
parallaxes = [0.97, 0.95, 0.94]
surfaces = []
surf_count = arrlen(parallaxes)
//// background
var surf_scale = 3
surf_w = CamW() * surf_scale
surf_h = CamH() * surf_scale

function createSurfaces() {
    for (var i = 0; i < array_length(surfaces); ++i) {
        var surf = surfaces[i]
        if surface_exists(surf) {
            surface_free(surf)
        }
    }
    ArrayClear(surfaces)
    var stars_num = 300
    var stars_alpha = 0.65
    var space_bg_filled = true
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
}

_updateBackground = function(name) {
    layer_x(name, CamX() * 0.9)
    layer_y(name, CamY() * 0.9)
    var layid = layer_background_get_id(layer_get_id(name))
    var bgzoom = oCamera.zoom / 2
    layer_background_xscale(layid, bgzoom)
    layer_background_yscale(layid, bgzoom)
}

updateBackground = function() {
    _updateBackground("Backgrounds_1")
    _updateBackground("Backgrounds_2")
    _updateBackground("Backgrounds_3")
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

createSurfaces()
