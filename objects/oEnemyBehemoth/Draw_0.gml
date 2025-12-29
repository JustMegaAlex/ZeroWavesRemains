event_inherited()

// draw_line(x, y, mover.to.x, mover.to.y)
// draw_text(x, y - 300, state_timer.timer)
helper_vec.set(x, y).add_polar(300, weapon.angle)
draw_line(x, y, helper_vec.x, helper_vec.y)
