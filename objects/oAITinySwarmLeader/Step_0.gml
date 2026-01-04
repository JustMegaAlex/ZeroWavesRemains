macro_pause

if swarm_fly_away_timer.update() {
    if mover_point.finished {
        mover_point.start(0, 0)
        mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
    }
} else {
    mover_point.to.setv(oPlayer)
    if mover_point.finished or (PointDist(mover_point.to.x, mover_point.to.y) < swarm_switch_to_fly_away_dist) {
        mover_point.to.set_polar(oGameArea.radius * random(1), random(360))
        swarm_fly_away_timer.reset()
    }
}

mover_point.step()

checkPushBackIntoCircle()

move()
