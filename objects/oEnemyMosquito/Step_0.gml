

macro_pause
no_player_exit


if active {
    var player_dir = InstDir(oPlayer)
    var dist = InstDist(oPlayer)
    if !is_long_range_state {
        weapon_snipe.timer.timer = Approach(weapon_snipe.timer.timer, 0, 1)
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
        if (dist < start_range_increase_dist) or run {
            is_long_range_state = false
            run = false
        }
        if player_in_shoot_range and !weapon_snipe.timer.update() {
            shoot(player_dir)
            weapon_snipe.timer.reset()
        }
    }
}


checkPushBackIntoCircle()

move()

event_inherited()
