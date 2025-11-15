
if global.gameover {
    exit
}

var dist = InstDist(oPlayer)
var close_to_player = (dist < magnet_dist)
speed = Approach(speed, close_to_player * sp_max, acc)

if close_to_player {
    direction = ApproachAngle(direction, InstDir(oPlayer), rot_sp)
    rot_sp += 0.2
}

if dist < speed {
    instance_destroy()
    oPlayer.money++
}
