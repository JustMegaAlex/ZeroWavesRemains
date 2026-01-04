

macro_pause

if active {
    // var too_far = false
    // if instance_exists(oPlayer) and InstDist(oPlayer, mover.to) > move_around_player_dist {
    //     too_far = true
    // }
    if is_swarm_mode {
        if swarm_leader == id {
            if swarm_fly_away_timer.update() {
                if mover.finished {
                    mover_point.start(0, 0)
                    mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
                }
            } else {
                mover_point.to.setv(oPlayer)
                if mover.finished or (PointDist(mover.to.x, mover.to.y) < swarm_switch_to_fly_away_dist) {
                    mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
                    swarm_fly_away_timer.reset()
                }
            }
        } else {

        }
        mover_point.step()
    } else {
        /// Circling mode
        if mover_circle_around.finished {
            accelerate(0, 0)
        } else {
            mover_circle_around.step()
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
}

checkPushBackIntoCircle()

move()

event_inherited()
