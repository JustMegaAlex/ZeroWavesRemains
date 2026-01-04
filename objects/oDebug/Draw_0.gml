
if !draw { exit }

with oAITinySwarmLeader {
    draw_circle(x, y, 100, true)
}

with oEnemy {
    draw_line(x, y, mover.to.x, mover.to.y)
}

with oEnemyTiny {    
    // draw_text(x, y - 200, sp.len())
    draw_line(x, y, mover_point.to.x, mover_point.to.y)
    // if instance_exists(swarm_leader)
        // draw_line(x, y, swarm_leader.x, swarm_leader.y)
}

with oItemDrone {
    if failed { draw_set_colour(c_red) }
    for (var i = 0; i < array_length(trajectory)-1; ++i) {
        var p = trajectory[i]
        var pp = trajectory[i+1]
        draw_line(p.x, p.y, pp.x, pp.y)
    }
    draw_set_colour(c_white)
}
