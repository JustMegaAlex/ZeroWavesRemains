
macro_pause

if is_emp_stunned {
    accelerate(0, 0)
} else if active {
    mover.step()
    dirApproach(sp.dir())

    if mover.finished {
        updateTraj()
    }

    if traj_ended and (PointDist(0, 0) > (oGameArea.radius * 1.2)) {
        global.wave_enemies_count--
        instance_destroy()
    }
}


move()
catchBullet()

event_inherited()
