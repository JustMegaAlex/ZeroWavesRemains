macro_pause

no_player_exit

if swarm_fly_away_timer.update() {
    if mover_point.finished {
        mover_point.start(0, 0)
        resetFlyAwayPoint()
    }
} else {
    mover_point.to.setv(oPlayer)
    if mover_point.finished or (PointDist(mover_point.to.x, mover_point.to.y) < swarm_switch_to_fly_away_dist) {
        resetFlyAwayPoint()
        swarm_fly_away_timer.reset()
    }
    with oAITinySwarmLeader {
        if id == other { continue }
        if swarm_fly_away_timer.timer <= 0 and InstDist(other) < 500 {
            swarm_fly_away_timer.reset()
            resetFlyAwayPoint()
            break
        }
    }
}

mover_point.step()

checkPushBackIntoCircle()

move()
