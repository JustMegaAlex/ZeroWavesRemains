
var w = window_get_width()
var h = window_get_height()
var gap = 0.1
var size = 0.6
hit_indicator = {
    timer: MakeTimer(30),
    alpha_max: 0.5,
    xc: w * 0.5,
    yc: h * 0.5,
    w: h * size,
    h: h * size,
    l: w * gap,
    r: w * (1 - gap),
    t: h * gap,
    b: h * (1 - gap),
}

indicateHit = function() {
    hit_indicator.timer.reset()
}
