event_inherited()

hp = 120

move_around_player_dist = 400
sp_max = 14
sp = new Vec2(0, 0)
acc_max = 0.37
updateDampening()

var angle = random(360)
var dist = oGameArea.radius * 1.1
x = lengthdir_x(dist, angle)
y = lengthdir_y(dist, angle)


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

objectDie = function() {
    instance_create_layer(x, y, layer, oItemDrop)
}

//// Create trajectory
chunk_len = 300
chunk_num = 45
trajectory = [new Vec2(x, y)]
traj_angle = random(360)
prev_traj_angle = traj_angle
traj_angle_delta = 5
traj_angle_delta_change = 5
var qmaxdist = oGameArea.radius * oGameArea.radius
var pprev = trajectory[0]
var p
var push_back_angle = 45
var push_back_factor = 0
failed = false
count = 0
while chunk_num {
    p = new Vec2(pprev.x, pprev.y)
    push_back_factor = (p.x*p.x + p.y*p.y) / qmaxdist
    traj_angle_delta += random_range(-1, 1) * traj_angle_delta_change
    if push_back_factor > 0 {
        var angle_from_center = point_direction(0, 0, p.x, p.y)
        var diff = angle_difference(traj_angle, angle_from_center)
        traj_angle += sign(diff) * push_back_factor * push_back_angle
    }
    traj_angle += traj_angle_delta
    p.add_polar(chunk_len, traj_angle)
    pprev = p
    array_push(trajectory, p)
    chunk_num--
    count++
}
// build the way out
p = new Vec2(pprev.x, pprev.y)
var angle_out = point_direction(0, 0, pprev.x, pprev.y)
p.set_polar(oGameArea.radius * 1.5, angle_out)
array_push(trajectory, p)


mover = mover_dir
mover.accel_value = 1
acc_max = 1
traj_index = 0
sp_max = 15
next_point = undefined
dir = 0
dist_to_next_point = 0
updateDampening()
updateTraj = function() {
    traj_index++
    if traj_index >= array_length(trajectory) {
        return;
    }
    var p = trajectory[traj_index]
    mover.start(PointDir(p.x, p.y), PointDist(p.x, p.y))
    // traj_index++
    // if traj_index >= array_length(trajectory) {
    //     return;
    // }
    // next_point = trajectory[traj_index]
    // dir = PointDir(next_point.x, next_point.y)
    dist_to_next_point = PointDist(p.x, p.y)
    // sp.set_polar(sp_max, dir)
}
