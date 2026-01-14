event_inherited()

macro_pause

battle_side = battle_side_enemy
move_around_player_dist = 2800

hp = 80

weapon = {
    dmg: 5,
    timer: MakeTimer(90),
    sp: 14,
    range: 4000,
    object: oBullet,
    knockback: 5,
    sprite_index: sProjectileCircle,
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
mover_point = {
    id: id,
    to: new Vec2(0, 0),
    treshold_dist: 400,
    dist_to: 0,
    finished: true,
    accel_value: 0.5,
    step: function() {
        dist_to = point_distance(id.x, id.y, to.x, to.y)
        if dist_to <= treshold_dist {
            finished = true
            return;
        }
        with id {
            accelerate(other.accel_value, PointDir(other.to.x, other.to.y))
        }
    },
    start: function(x, y) {
        to.set(x, y)
        finished = false
    }
}

mover_dir = {
    id: id,
    dir: 0,
    accel_value: 0.5,
    dist_left: 0,
    dist_default: 2500,
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
    start: function(dir, dist_left=0) {
        self.dir = dir
        self.dist_left = dist_left > 0 ? dist_left : dist_default
        self.finished = false
    }
}

mover = mover_dir


mover_point.treshold_dist = 400
updateSpMax(16)
