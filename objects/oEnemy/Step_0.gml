
event_inherited()

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

move()

if instance_exists(oPlayer) {
    dirApproach(InstDir(oPlayer))
}
