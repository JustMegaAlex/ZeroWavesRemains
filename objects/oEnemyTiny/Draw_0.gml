// Inherit the parent event
// if global.debug_tiny == id {
//     draw_set_colour(c_red)
//     draw_circle(x, y, 40, false)
//     draw_set_colour(c_white)
// }
event_inherited()

// draw_text(x, y - 200, sp.len())
draw_line(x, y, mover.to.x, mover.to.y)
