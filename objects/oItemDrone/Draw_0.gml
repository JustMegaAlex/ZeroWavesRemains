// Inherit the parent event
// if global.debug_tiny == id {
//     draw_set_colour(c_red)
//     draw_circle(x, y, 40, false)
//     draw_set_colour(c_white)
// }

event_inherited()

if oDebug.draw {
    if failed { draw_set_colour(c_red) }
    for (var i = 0; i < array_length(trajectory)-1; ++i) {
        var p = trajectory[i]
        var pp = trajectory[i+1]
        draw_line(p.x, p.y, pp.x, pp.y)
    }
    draw_set_colour(c_white)
}
