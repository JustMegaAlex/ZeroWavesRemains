
macro_pause

if key_pressed(ord("T")) {
    event_perform(ev_create, 0)
}

if active {
    mover.step()
    dirApproach(sp.dir())

    if mover.finished {
        updateTraj()
    }

    if PointDist(0, 0) > (oGameArea.radius * 1.2) {
        global.wave_enemies_count--
        instance_destroy()
    }
}


move()
catchBullet()
