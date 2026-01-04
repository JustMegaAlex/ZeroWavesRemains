event_inherited()


///// Ships functionality
hp_max = 100
hp = hp_max
acc_max = 0.5
sp_max = 24
dampening_val = acc_max / sp_max
acc = new Vec2(0, 0)
dampening = new Vec2(0, 0)
sp = new Vec2(0, 0)
dir = 0
dir_to = 0
rotary_sp = 6
// readonly
sp_dir = 0
sp_len = 0
is_dead = false

move_around_player_dist = 400

swarm_fly_away_timer = MakeTimer(180, 0)
swarm_switch_to_fly_away_dist = 300


updateSpMax = function(_sp) {
    sp_max = _sp
    updateDampening()
}

updateDampening = function() {
    dampening_val = acc_max / sp_max
}

dirApproach = function(dir_to, rot_sp=rotary_sp) {
	var diff = angle_difference(dir_to, dir)
	if abs(diff) < rot_sp {
		dir = dir_to
		return true
	}
	dir += rotary_sp * sign(diff)
}

accelerate = function(ratio, dir) {
    acc.set_polar(acc_max * ratio, dir)
}

move = function() {
    sp.add(acc)
    dampening.set(sp.x * dampening_val, sp.y * dampening_val)
    sp.sub(dampening)
    sp_dir = sp.dir()
    sp_len = sp.len()
    x += sp.x
    y += sp.y
}

checkPushBackIntoCircle = function() {
    if PointDist(0, 0) > oGameArea.radius {
        var suck_dir = PointDir(0, 0)
        acc.add_polar(acc_max, suck_dir)
    }
}


mover_point = {
    id: id,
    to: new Vec2(0, 0),
    shift_vec: new Vec2(0, 0),
    treshold_dist: 40,
    dist_to: 0,
    finished: true,
    accel_value: 1,
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
        to.set(x, y).add(shift_vec)
        finished = false
    },
    update: function(x, y) {
        to.set(x, y).add(shift_vec)
    },
    updatev: function(vec) {
        to.setv(vec).add(shift_vec)
    }
}


updateDampening()
