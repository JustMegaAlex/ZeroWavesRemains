event_inherited()


dir_to = MouseDir()
dirApproach(dir_to)

var key_up = oInput.Hold("up")
var key_down = oInput.Hold("down")
var key_right = oInput.Hold("right")
var key_left = oInput.Hold("left")
var arrows_input = key_up or key_down or key_right or key_left

if oInput.Hold("rclick") {
    accelerate(1, dir)
} else if arrows_input {
    accelerate(0.5, point_direction(
        0, 0,
        key_right - key_left,
        key_down - key_up
    ))
} else {
    accelerate(0, dir)
}

// push back into circle
if PointDist(0, 0) > oGameArea.radius {
    var suck_dir = PointDir(0, 0)
    acc.add_polar(acc_max, suck_dir)
}

move()


if !weapon.timer.update() and oInput.Hold("lclick") {
    shoot(dir)
    weapon.timer.reset()
}

