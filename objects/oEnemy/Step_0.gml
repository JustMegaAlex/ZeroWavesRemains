
event_inherited()

if active {
    if mover.finished {
        accelerate(0, 0)
        if instance_exists(oPlayer) {
            var dir_from_player = point_direction(
                oPlayer.x, oPlayer.y, x, y
            ) + irandom_range(-90, 90)
            mover.to.setv(oPlayer).add_polar(move_around_player_dist, dir_from_player)
            mover.start(mover.to.x, mover.to.y)
        }
    } else {
        mover.step()
    }
    
    weapon.timer.update()
    
    if instance_exists(oPlayer) {
        dir_to = InstDir(oPlayer)
        dirApproach(dir_to)
        if !weapon.timer.timer {
            shoot(Aim(oPlayer))
            weapon.timer.reset()
        }
    }
    
}

move()
