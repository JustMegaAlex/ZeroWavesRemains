
macro_pause

if key_pressed(ord("T")) {
    event_perform(ev_create, 0)
}


// x += sp.x
// y += sp.y
// dist_to_next_point -= sp_max

mover.step()
move()
dirApproach(sp.dir())

if mover.finished {
    updateTraj()
}

if PointDist(0, 0) > (oGameArea.radius * 1.2) {
    instance_destroy()
}

catchBullet()
