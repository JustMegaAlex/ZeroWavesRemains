

macro_pause

if active {
    var too_far = false
    // if instance_exists(oPlayer) 
    //         and (InstDist(oPlayer, mover.to) > (move_around_player_dist)*1.2) {
    //     too_far = true
    // }
    if mover.finished or too_far 
            or (PointDist(0, 0) > oGameArea.radius){
        mover.start(random(360))
        // accelerate(0, 0)
        // if instance_exists(oPlayer) {
        //     var dir_from_player = point_direction(
        //         oPlayer.x, oPlayer.y, x, y
        //     ) + irandom_range(-90, 90)
        //     mover.to.setv(oPlayer).add_polar(move_around_player_dist, dir_from_player)
        //     mover.start(mover.to.x, mover.to.y)
        // }
    } else {
        mover.step()
    }

    weapon.timer.update()

    if instance_exists(oPlayer) {
        if !weapon.timer.timer {
            shoot(Aim(oPlayer))
            weapon.timer.reset()
        }
    }
    // dirApproach(PointDir(mover.to.x, mover.to.y))
    dirApproach(sp.dir())
}

checkPushBackIntoCircle()

move()

event_inherited()

