event_inherited()

macro_pause

battle_side = battle_side_enemy
move_around_player_dist = 1000

image_blend = c_white


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

mover_dir = {
    id: id,
    dir: 0,
    accel_value: 0.5,
    dist_left: 0,
    finished: false,
    step: function() {
        self.dist_left -= id.sp.len()
        if self.dist_left <= 0 {
            self.finished = true
            return;
        }
        with id {
            accelerate(other.accel_value, other.dir)
        }
    },
    start: function(dir, dist_left) {
        self.dir = dir
        self.dist_left = dist_left
        self.finished = false
    }
}

mover = mover_point
