
no_player_exit

var arrow, dist, mult
var _arrow_zoom = oCamera.zoom * arrow_zoom
var text_zoom = oCamera.zoom
for (var i = 0; i < array_length(hint_arrows); ++i) {
    arrow = hint_arrows[i]
    arrow.time--
    if (!is_struct(arrow.target) and !instance_exists(arrow.target))
            or (arrow.time <= 0) {
        array_delete(hint_arrows, i, 1)
        i--
        continue
    }
    dist = InstInstDist(oPlayer, arrow.target)
    if (dist) < arrow_draw_dist*_arrow_zoom {
        continue
    }
    var dir = InstDir(oPlayer, arrow.target)
    helper_vec.setv(oPlayer)
        .add_polar(arrow_draw_dist*_arrow_zoom, dir)
    draw_sprite_ext(
        sUIArrow, 0, helper_vec.x, helper_vec.y,
        _arrow_zoom, _arrow_zoom, dir, arrow.color, 0.7)
    draw_text_transformed(
        helper_vec.x, helper_vec.y - 100 * _arrow_zoom, 
        arrow.text, text_zoom, text_zoom, 0)
    // mult = dist / arrow_target_max_distance
    // if mult < arrow_dist_mult_treshold {
    //     continue
    // }
    // helper_line.set(
    //     oPlayer.x, oPlayer.y, arrow.target.x, arrow.target.y
    // ).mult(mult * _arrow_zoom)
    // .clamp_len(
    //     arrow_max_distance * _arrow_zoom,
    //     arrow_min_distance * _arrow_zoom
    // )
    // draw_sprite_ext(
    //     sUIArrow, 0, helper_line.xend, helper_line.yend,
    //     _arrow_zoom, _arrow_zoom, helper_line.angle(), arrow.color, 0.5)
    // draw_text_transformed(
    //     helper_line.xend, helper_line.yend - 100 * _arrow_zoom, 
    //     arrow.text, text_zoom, text_zoom, 0)
    
    // draw mult
    // draw_text_transformed(
    //     helper_line.xend, helper_line.yend - 100 * arrow_zoom, 
    //     mult, text_zoom, text_zoom, 0)
}
