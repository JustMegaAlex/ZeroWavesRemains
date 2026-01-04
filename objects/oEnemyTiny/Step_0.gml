

macro_pause

if active {
    // var too_far = false
    // if instance_exists(oPlayer) and InstDist(oPlayer, mover.to) > move_around_player_dist {
    //     too_far = true
    // }
    if is_swarm_mode {
        if swarm_leader == id {
            /// Lead the swarm
            if swarm_fly_away_timer.update() {
                if mover_point.finished {
                    mover_point.start(0, 0)
                    mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
                }
            } else {
                mover_point.to.setv(oPlayer)
                if mover_point.finished or (PointDist(mover_point.to.x, mover_point.to.y) < swarm_switch_to_fly_away_dist) {
                    mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
                    swarm_fly_away_timer.reset()
                }
            }
        } else {
            /// Follow the leader
            if mover_point.finished {
                mover_point.start(0, 0)
            }
            mover_point.shift_vec.set_polar(
                swarm_shift_forward_dist*swarm_shift_forward_factor,
                swarm_leader.sp_dir + swarm_shift_angle)
            // if !swarm_update_shift_timer.update() {
            //     mover_point.shift_vec.set(swarm_flollow_shift_distance, random(360))
            // }
            var acc_dist_add = min(4, mover_point.dist_to * swarm_accel_add_factor)
            var acc_sp_add = swarm_leader.sp_len / swarm_leader.sp_max
            mover_point.accel_value = 1 + acc_dist_add * acc_sp_add
            mover_point.updatev(swarm_leader)
        }
        mover_point.step()
    } else {
        /// Circling mode
        if mover_circle_around.finished {
            accelerate(0, 0)
        } else {
            mover_circle_around.step()
        }
    }

    weapon.timer.update()

    if instance_exists(oPlayer) and InstDist(oPlayer) < (weapon.range * 1.3) {
        dir_to = InstDir(oPlayer)
        if !weapon.timer.timer {
            shoot(Aim(oPlayer))
            weapon.timer.reset()
        }
    } else {
        dir_to = sp_dir
    }
    dirApproach(dir_to)
}

checkPushBackIntoCircle()

move()

event_inherited()
