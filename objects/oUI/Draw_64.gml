
if hit_indicator.timer.update() {
    var alpha = hit_indicator.alpha_max * hit_indicator.timer.timer / hit_indicator.timer.time
    var xscale = hit_indicator.w / sprite_get_width(sUIHitIndication)
    var yscale = hit_indicator.h / sprite_get_width(sUIHitIndication)
    draw_sprite_ext(sUIHitIndication, 0, hit_indicator.xc, hit_indicator.t,
                    xscale, 1, 0, c_white, alpha)
    draw_sprite_ext(sUIHitIndication, 0, hit_indicator.xc, hit_indicator.b,
                    xscale, 1, 180, c_white, alpha)
    draw_sprite_ext(sUIHitIndication, 0, hit_indicator.l, hit_indicator.yc,
                    yscale, 1, 90, c_white, alpha)
    draw_sprite_ext(sUIHitIndication, 0, hit_indicator.r, hit_indicator.yc,
                    yscale, 1, -90, c_white, alpha)
}
