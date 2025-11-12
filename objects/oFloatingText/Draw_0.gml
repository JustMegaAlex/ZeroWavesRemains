
var current_frame = oSys.frames_since_start
var time = 0
for (var i = 0; i < array_length(floating_texts); ++i) {
    var item = floating_texts[i]
    time = current_frame - item.create_time
    if PointInCamera(item.x, item.y) {
        draw_set_color(item.color)
        draw_set_alpha(1 - time/lifetime)
        draw_text(item.x, item.y - time * float_speed, item.text)
    }
    if (time > lifetime) {
        array_delete(floating_texts, i, 1); --i
    }
}
draw_set_color(c_white)
draw_set_alpha(1)
