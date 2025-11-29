
no_player_exit

var arrow, dist, mult
var _arrow_zoom = oCamera.zoom * arrow_zoom
var text_zoom = oCamera.zoom
for (var i = 0; i < array_length(hint_arrows); ++i) {
    arrow = hint_arrows[i]
    if !is_struct(arrow.target) and !instance_exists(arrow.target) {
        array_delete(hint_arrows, i, 1)
        i--
        continue
    }
    dist = InstInstDist(oPlayer, arrow.target)
    mult = dist / arrow_target_max_distance
    if mult < arrow_dist_mult_treshold {
        continue
    }
    var test = helper_line.set(
        oPlayer.x, oPlayer.y, arrow.target.x, arrow.target.y
    ).mult(mult * _arrow_zoom)
    draw_sprite_ext(
        sUIArrow, 0, helper_line.xend, helper_line.yend,
        _arrow_zoom, _arrow_zoom, helper_line.angle(), arrow.color, 0.5)
    draw_text_transformed(
        helper_line.xend, helper_line.yend - 100 * _arrow_zoom, 
        arrow.text, text_zoom, text_zoom, 0)
    
    // draw mult
    // draw_text_transformed(
    //     helper_line.xend, helper_line.yend - 100 * arrow_zoom, 
    //     mult, text_zoom, text_zoom, 0)
}
