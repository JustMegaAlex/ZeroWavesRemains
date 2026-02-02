

macro_pause
no_player_exit


if active {
    var player_dir = InstDir(oPlayer)
    var dist = InstDist(oPlayer)
    if !is_long_range_state {
        var center_dist = PointDist(0, 0)
        var dir_to = player_dir + 180
        if center_dist > avoid_boundary_dist {
            var dist_ratio = (center_dist - avoid_boundary_dist) / avoid_boundary_zone_length
            var angle = lerp(0, 110, dist_ratio) * sign(angle_difference(PointDir(0, 0), dir_to))
            dir_to += angle
        }
        dirApproach(dir_to)
        mover.dir = dir
        mover.step()
        if dist >= long_range_dist {
            is_long_range_state = true
        }
    } else {
        var player_in_shoot_range = dist < weapon_snipe.range
        accelerate(!player_in_shoot_range, player_dir)
        dirApproach(player_dir)
        if dist < start_range_increase_dist {
            is_long_range_state = false
        }
        if player_in_shoot_range and !weapon_snipe.timer.update() {
            shoot(player_dir)
            weapon_snipe.timer.reset()
        }
    }
}


if false {
    var too_far = false
    if instance_exists(oPlayer) and InstDist(oPlayer, mover.to) > move_around_player_dist {
        too_far = true
    }
    if mover.finished or too_far 
            or point_distance(mover.to.x, mover.to.y, 0, 0) > oGameArea.radius {
        accelerate(0, 0)
        if instance_exists(oPlayer) {
            var dir_from_player = point_direction(
                oPlayer.x, oPlayer.y, x, y
            ) + irandom_range(-90, 90)
            mover.to.setv(oPlayer).add_polar(move_around_player_dist, dir_from_player)
            mover.start(mover.to.x, mover.to.y)
        }
    } else {
        mover.step()
    }

    weapon.timer.update()

    if instance_exists(oPlayer) {
        dir_to = InstDir(oPlayer)
        dirApproach(dir_to)
        if !weapon.timer.timer and (InstDist(oPlayer) < (weapon.range * 1.1)) {
            shoot(Aim(oPlayer))
            weapon.timer.reset()
        }
    }
}

checkPushBackIntoCircle()

move()

event_inherited()
