event_inherited()

hp = 10

move_around_player_dist = 400
sp_max = 40
acc_max = 0.37
updateDampening()


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
    treshold_dist: 40,
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

mover = mover_point

//// Create trajectory
chunk_len = 300
chunk_num = 15
trajectory = [new Vec2(0, 0)]
traj_angle = random(360)
prev_traj_angle = traj_angle
traj_angle_delta = 5
traj_angle_delta_change = 5
var qdist = oGameArea.radius * oGameArea.radius
var pprev = trajectory[0]
failed = false
while chunk_num {
    var p = new Vec2(-100000, 0)
    var tries = 0
    while (p.x*p.x + p.y*p.y) > qdist {
        traj_angle = prev_traj_angle + traj_angle_delta * choose(-1, 1)
        p.setv(pprev).add_polar(chunk_len, traj_angle)
        tries++
        if (tries mod 4) == 0 {
            angle_delta += 5
        }
        if tries > 1000 {
            failed = false
            break
        }
    }
    traj_angle_delta += random_range(-1, 1) * traj_angle_delta_change
    pprev = p
    array_push(trajectory, p)
    chunk_num--
    if failed break
}

