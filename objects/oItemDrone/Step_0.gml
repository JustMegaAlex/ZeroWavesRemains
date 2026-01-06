
macro_pause

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
