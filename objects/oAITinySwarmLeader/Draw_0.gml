
var r = 100
if DEV {
    draw_circle(x, y, r, true)
    draw_circle(x, y, leaders_spread_distance, true)
    if swarm_fly_away_timer.timer > 0 {
        var col = c_yellow
        draw_circle_color(x, y, r * swarm_fly_away_timer.ratio(), true, col, col)
    }
}