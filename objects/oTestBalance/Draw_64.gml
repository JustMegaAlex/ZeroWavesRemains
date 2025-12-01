SetTextAllign(0, 1)
var guiw = display_get_gui_width()
var guih = display_get_gui_height()
var dx = 0
var dy = 0
var x0 = 200
var scale = 0.15
var xx = 0
var ydelta = 30
var y0 = 20
var total_coins = 0
var wcoin = sprite_get_width(sCoin) * 1.5 * scale
var strengths = oWaveSpawner.wave_strengths
for (var i = 0; i < array_length(test_results); ++i) {
    var strength = "u"
    if i < array_length(strengths) {
        strength = strengths[i]
    }
    draw_text(5 + dx, y0 + i * ydelta + dy, $"{i+1}. s={strength}")
    if (y0 + ydelta * i + dy) > (guih * 1) {
        dy -= guih + y0
        dx += guiw * 0.3
    }
    var wave = test_results[i]
    var keys = variable_struct_get_names(wave)
    xx = 0
    for (var j = 0; j < array_length(keys); ++j) {
        var key = keys[j]
        var count = wave[$ key]
        var ind = asset_get_index(key)
        if ind >= 0 {
            var spr = object_get_sprite(ind)
            var w = sprite_get_width(spr) * scale * 1.5
            var _scale = ind != oEnemyTiny ? scale : scale * 0.5
            repeat count {
                draw_sprite_ext(
                    spr, 0, 
                    x0 + xx + dx,
                    y0 + i * ydelta + dy,
                    _scale, _scale, 0, c_white, 1
                )
                xx += w
            }
        }
    }
    draw_sprite_ext(sCoin, 0, 
        x0 + xx + dx,
        y0 + i * ydelta + dy,
        scale*2, scale*2, 0, c_white, 1
    )
    xx += wcoin
    total_coins += wave.coins
    draw_text(
        x0 + xx + dx,
        y0 + i * ydelta + dy,
        $"x{wave.coins} / {total_coins}"
    )
}
