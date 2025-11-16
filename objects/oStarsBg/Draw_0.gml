var scale = 1 + (oCamera.zoom - 1) * scale_parallax
var move_due_to_scale = (1 - scale) * 0.5

//draw
for (var i = 0; i < array_length(surfaces); ++i) {
    var parallax = parallaxes[i]
    var x_draw_stars = x_draw_stars_start
                   + (CamXCent(0) - x_ship_st) * parallax
                   + move_due_to_scale * surf_w
    var y_draw_stars = y_draw_stars_start
                   + (CamYCent(0) - y_ship_st) * parallax
                   + move_due_to_scale * surf_h
    var surf = surfaces[i]
    if surface_exists(surf)
        draw_surface_ext(surf, x_draw_stars, y_draw_stars, scale, scale, 0, c_white, 1)
}
