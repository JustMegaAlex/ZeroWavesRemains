// Inherit the parent event
// if global.debug_tiny == id {
//     draw_set_colour(c_red)
//     draw_circle(x, y, 40, false)
//     draw_set_colour(c_white)
// }
event_inherited()

// draw_text(x, y - 200, sp.len())
// draw_line(x, y, mover_point.to.x, mover_point.to.y)
if instance_exists(swarm_leader)
    draw_line(x, y, swarm_leader.x, swarm_leader.y)
