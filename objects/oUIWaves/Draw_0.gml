

// var bb = base_blend
// var cb = current_blend
// with cb {
//     r = Approach(r, bb.r, 0.01)
//     g = Approach(g, bb.g, 0.01)
//     b = Approach(b, bb.b, 0.01)
// }
// text.color = make_color_rgb(cb.r, cb.g, cb.b)

draw_self()

text.text = string(global.waves_remains)

if animation_timer.update() {
    anim_text.text = text.text
    anim_text.scale = 1 + animation_timer.timer/animation_timer.time * 0.5
    DrawText(x, y, anim_text)
}


DrawText(x, y, text)
