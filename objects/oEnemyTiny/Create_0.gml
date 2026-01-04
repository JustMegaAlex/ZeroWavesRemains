event_inherited()

if global.debug_tiny == noone {
    global.debug_tiny = id
}

hp = 10

move_around_player_dist = 400
sp_max = 24
acc_max = 0.4
updateDampening()

is_swarm_mode = false

image_xscale = 0.3
image_yscale = 0.3

weapon = {
    dmg: 1,
    timer: MakeTimer(15),
    sp: 40,
    range: 600,
    object: oBullet,
    image_xscale: 0.5,
    image_yscale: 0.5,
    knockback: 0,
}




//// Movers
mover_template = {
    id: id,
    to: new Vec2(0, 0),
    finished: false,
    step: function() {
        
    },
    start: function() {
        
    }
}
mover_circle_around = {
    id: id,
    to: new Vec2(0, 0),
    actual_to: new Vec2(2, 0),
    radius: 300,
    threshold_radius_mult: random_range(1.7, 2.3),
    dist_to: 0,
    dir_to: 0,
    circling_dir: 1,
    finished: true,
    accel_value: 1,
    change_dir_timer: MakeTimer(60),
    step: function() {
        if !is_struct and !instance_exists(to) {
            finished = true
            return;
        }
        dir_to = point_direction(id.x, id.y, to.x, to.y)
        dist_to = point_distance(id.x, id.y, to.x, to.y)
        if !change_dir_timer.update() and (dist_to > (radius * 3)) {
            circling_dir = choose(-1, 1)
            change_dir_timer.reset()
        }


        var rotation_factor = max(0, (threshold_radius_mult * radius - dist_to) / radius) // from 0 to 1
        dir_to += 90 * circling_dir * rotation_factor
        id.accelerate(accel_value, dir_to)
    },
    start: function(x, y) {
        to.set(x, y)
        finished = false
        circling_dir = choose(1, -1)
    }
}

mover = mover_circle_around
mover.start()
mover.to = oPlayer


/// Aim
function Aim(target) {
    var sight_angle = point_direction(x, y, target.x, target.y)
    var evasion_angle = angle_difference(target.sp.dir(), sight_angle)
    var target_sp_len = target.sp.len()
    if (abs(evasion_angle) < 5) or (target_sp_len == 0) {
        return sight_angle
    }
    var beta_angle = 180 - abs(evasion_angle)
    var evasion_dir = sign(evasion_angle)
    var bullet_sp = weapon.sp
    var aim_angle_sin = target_sp_len/bullet_sp * lengthdir_y(-1, beta_angle)
    if abs(aim_angle_sin) > 1 {
        return sight_angle
    }
    var aim_angle = radtodeg(arcsin(aim_angle_sin)) * evasion_dir
	if (abs(aim_angle) + beta_angle) >= 180 {
        return sight_angle
    }
    return sight_angle + aim_angle + choose(0, 3, 4, 5, 6, 7, 8, 9, 10) * choose(1, -1)
}
