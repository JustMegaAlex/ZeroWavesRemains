var scale_change = (oCamera.zoom - 1) * scale_parallax
var move_due_to_scale = (scale_change) * 0.5

//draw
for (var i = 0; i < array_length(surfaces); ++i) {
    var parallax = parallaxes[i]
    var plx_x = (CamXCent(0) - x_ship_st) * parallax
    var plx_y = (CamYCent(0) - y_ship_st) * parallax
    var move_x_default_scale = -(surf_w * 0.5)
    var move_y_default_scale = -(surf_h * 0.5)

    var dx = (CamXCent(0) - x_ship_st)
    var dy = (CamYCent(0) - y_ship_st)
    
    var move_x = plx_x - (surf_w * 0.5) * oCamera.zoom - dx * (1 - parallax) * (oCamera.zoom - 1)
    var move_y = plx_y - (surf_h * 0.5) * oCamera.zoom - dy * (1 - parallax) * (oCamera.zoom - 1)

    var x_draw_stars = x_ship_st + move_x
    var y_draw_stars = y_ship_st + move_y
    var surf = surfaces[i]
    if !surface_exists(surf) {
        createSurfaces()
        surf = surfaces[i]
    }
    draw_surface_ext(surf, x_draw_stars, y_draw_stars, 1 + scale_change, 1 + scale_change, 0, c_white, 1)
}
