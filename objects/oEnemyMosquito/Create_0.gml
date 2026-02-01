event_inherited()

macro_pause

hp = 80


battle_side = battle_side_enemy
long_range_dist = 2300
start_range_increase_dist = 1400
is_long_range_state = false
avoid_boundary_dist = oGameArea.radius * 0.5
avoid_boundary_zone_length = oGameArea.radius - avoid_boundary_dist

updateSpMax(36)

//image_blend = c_white


weapon = {
    dmg: 5,
    timer: MakeTimer(45),
    sp: 40,
    range: 2000,
    object: oBullet,
    knockback: 7,
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

mover_dir_simple = {
    id: id,
    dir: 0,
    accel_value: 1,
    finished: false, // never true
    step: function() {
        with id {
            accelerate(other.accel_value, other.dir)
        }
    },
    start: function(dir, dist_left) {
        self.dir = dir
    }
}

mover = mover_dir_simple
