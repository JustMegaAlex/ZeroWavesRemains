event_inherited()

if global.debug_tiny == noone {
    global.debug_tiny = id
}

hp = 10

var scale = 1.3
image_xscale = scale
image_yscale = scale

move_around_player_dist = 400
sp_max = 24
acc_max = 0.4
updateDampening()

is_swarm_mode = false
swarm_leader = noone
swarm_fly_away_timer = MakeTimer(180, 0)
swarm_switch_to_fly_away_dist = 300
swarm_flollow_shift_distance = 200
swarm_update_shift_timer = MakeTimer(120, 0, true)
swarm_shift_forward_dist = 800
swarm_shift_forward_factor = 1 // from 0 to 1
swarm_shift_angle = 0
swarm_accel_add_factor = 1 / 2000


weapon = {
    dmg: 1,
    timer: MakeTimer(35),
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
mover_point.accel_value = 1

mover = mover_circle_around
mover.start()
mover.to = oPlayer

objectDie = function() {
    if swarm_leader == id {
        oAIEnemyControl.tiny.swarmTinyDeadHook()
    }
}
