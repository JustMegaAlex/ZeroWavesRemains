

macro_pause

if active {
    // var too_far = false
    // if instance_exists(oPlayer) and InstDist(oPlayer, mover.to) > move_around_player_dist {
    //     too_far = true
    // }
    if mover.finished {
        accelerate(0, 0)
    } else {
        mover.step()
    }

    weapon.timer.update()

    if instance_exists(oPlayer) {
        dir_to = InstDir(oPlayer)
        dirApproach(dir_to)
        if !weapon.timer.timer {
            shoot(Aim(oPlayer))
            weapon.timer.reset()
        }
    }
}

checkPushBackIntoCircle()

move()

event_inherited()
