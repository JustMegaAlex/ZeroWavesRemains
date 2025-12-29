

macro_pause

if active and instance_exists(oPlayer) {

    if !is_firing {
        weapon.recharge_timer.update()
    }

    // if is_long_distance_fire_state {
    // } else {
    // }

    weapon.angle_to = InstDir(oPlayer)
    weapon.angle = ApproachAngle(weapon.angle, weapon.angle_to, weapon.rotary_speed)
    main_weapon.image_angle = weapon.angle
    //// Long distance fire
    if !is_firing and !weapon.recharge_timer.timer
            and (abs(angle_difference(weapon.angle, weapon.angle_to)) < 3)
            and (InstDist(oPlayer) >= weapon.min_range) {
        is_firing = true
        shots_left = weapon.shots_count
    }
    if is_firing and !weapon.timer.update() {
        main_weapon.shoot(weapon.angle)
        weapon.timer.reset()
        shots_left--
        if shots_left <= 0 {
            is_firing = false
            weapon.recharge_timer.reset()
        }
    }

    if mover.finished
            or point_distance(mover.to.x, mover.to.y, 0, 0) > oGameArea.radius {
        accelerate(0, 0)
        mover.to.set(0, 0).add_polar(
            random_range(0.5, 0.8) * oGameArea.radius, random(360))
        mover.start(mover.to.x, mover.to.y)
    } else {
        dirApproach(InstDir(mover.to))
        mover.step()
    }

    //// Change state
    // if !state_timer.update() {
    //     if (InstDist(oPlayer) < switch_to_long_range_distance) and !is_firing {
    //         is_long_distance_fire_state = false
    //     } else {
    //         is_long_distance_fire_state = true
    //     }
    //     state_timer.time = state_timer_randomer()
    //     state_timer.reset()
    // }
}


move()
checkPushBackIntoCircle()


for (var i = 0; i < array_length(turrets); ++i) {
    var turret = turrets[i]
    turret_helper_vec.setv(turret.rel_vec).rotate(dir)
    turret.x = x + turret_helper_vec.x
    turret.y = y + turret_helper_vec.y
}
turret_helper_vec.setv(main_weapon_pos).rotate(dir)
main_weapon.x = x + turret_helper_vec.x
main_weapon.y = y + turret_helper_vec.y

event_inherited()
