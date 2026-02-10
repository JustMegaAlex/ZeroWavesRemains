

macro_pause
no_player_exit

if is_emp_stunned {
    accelerate(0, 0)
} else if active {

    under_attack = max(under_attack - under_attack_decr, 0)

    if !blink.reload_timer.update() and (!blink.random_timer.update() or (under_attack > 200)) {
        state = "blink"
        blink.random_timer.time = 1000
        blink.random_timer.reset()
        mover.finished = true
    }

    switch state {
        case "engage": 
            dir_to = InstDir(oPlayer)
            dirApproach(dir_to)
            if !weapon_burst.shots_left and !weapon_burst.timer.update() and (InstDist(oPlayer) < (weapon_burst.range * 1.1)) {
                weapon_burst.shots_left = weapon_burst.burst_count
            }

            if hang_in_place_timer.update() {
                accelerate(0, 0)
                break
            }
            if mover.finished or point_distance(mover.to.x, mover.to.y, 0, 0) > oGameArea.radius {
                var dir_from_player = point_direction(
                    oPlayer.x, oPlayer.y, x, y
                ) + irandom_range(20, 40) * choose(-1, 1)
                mover.to.setv(oPlayer).add_polar(
                    move_around_player_dist * random_range(0.6, 1),
                    dir_from_player)
                mover.start(mover.to.x, mover.to.y)
                hang_in_place_timer.reset()
            } else {
                mover.step()
            }
        break
        case "blink":
            accelerate(0, 0)
            if !blink.initialized {
                var max_cycles = 20
                while true {
                    blink.to.setv(oPlayer).add_polar(missile_dist, random(360))
                    if point_distance(0, 0, blink.to.x, blink.to.y) < (oGameArea.radius * 0.9) {
                        blink.initialized = true
                        break
                    }
                    if !max_cycles-- {
                        break
                    }
                }
            }
            dirApproach(PointDir(blink.to.x, blink.to.y))
            if blink.startup_timer.update() {
                break
            }
            x = blink.to.x
            y = blink.to.y
            weapon_missiles.shots_left = weapon_missiles.burst_count
            blink.initialized = false
            state = "missiles"
            weapon_burst.shots_left = 0
            blink.reload_timer.reset()
            mover.finished = true
        break
        case "missiles":
            mover.accel_value = 0.5
            dir_to = InstDir(oPlayer)
            dirApproach(dir_to)
            
            if missiles_out and !weapon_missiles.shots_left {
                missile_out = false
                state = "engage"
                break
            }
            if !weapon_missiles.shots_left and !weapon_missiles.timer.update() {
                weapon_missiles.shots_left = weapon_missiles.burst_count
                missiles_out = true
            }

            if mover.finished or point_distance(mover.to.x, mover.to.y, 0, 0) > oGameArea.radius {
                var dir_from_player = point_direction(
                    oPlayer.x, oPlayer.y, x, y
                ) + irandom_range(20, 40) * choose(-1, 1)
                mover.to.setv(id).add_polar(500 * random_range(0.6, 1), random(360))
                mover.start(mover.to.x, mover.to.y)
                hang_in_place_timer.reset()
            } else {
                mover.step()
            }
        break
        case "":

        break
    }


}

if weapon_burst.shots_left {
    if !weapon_burst.burst_timer.update() {
        weapon = weapon_burst
        shoot(Aim(oPlayer))
        weapon_burst.shots_left--
        weapon_burst.burst_timer.reset()
    }
    if weapon_burst.shots_left <= 0 {
        weapon_burst.timer.reset()
    }
}

if weapon_missiles.shots_left {
    if !weapon_missiles.burst_timer.update() {
        weapon = weapon_missiles
        var missile = shoot(Aim(oPlayer))
        weapon_missiles.shots_left--
        weapon_missiles.burst_timer.reset()
        missile.dir = image_angle + choose(-90, 90)
        missile.sp = 30
    }
    if weapon_missiles.shots_left <= 0 {
        weapon_missiles.timer.reset()
    }
}
checkPushBackIntoCircle()

move()

event_inherited()
