


indicateHit = function() {
    with oUIHitIndicator {
        appear()
    }
}

hint_arrows = []
helper_vec = new Vec2(0, 0)
helper_line = new Line(0, 0, 0, 0)
arrow_draw_dist = 850
arrow_target_max_distance = oGameArea.radius * 2
arrow_max_distance = 600
arrow_min_distance = 150
arrow_dist_mult_treshold = 0.11
arrow_zoom = 0.3
addHintArrow = function(target, text, color=c_white) {
    var arrow = {
        target: target,
        color: color,
        text: text,
    }
    array_push(hint_arrows, arrow)
    return arrow
}

removeHintArrow = function(arrow) {
    ArrayRemove(hint_arrows, arrow)
}

// addHintArrow(oShop, "Shop is there!", c_green)
