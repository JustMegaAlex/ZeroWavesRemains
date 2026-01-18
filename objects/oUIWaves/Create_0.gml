text = new Text(0, 0, "", {
    halign: 1, valign: 1,
    color: make_color_rgb(255, 180, 0),
    font: fntUIWavesRemains
})
anim_text = new Text(
    text.relx, text.rely, "", {
        halign: text.halign,
        valign: text.valign,
        color: text.color,
        font: text.font,
        alpha: 0.7,
    }
)
anim_text.alpha_anim = 0.5

blend_anim = {
    r: 255, g: 180, b: 0
}
current_blend = {
    r: color_get_red(image_blend),
    g: color_get_green(image_blend),
    b: color_get_blue(image_blend),
}
base_blend = {
    r: color_get_red(image_blend),
    g: color_get_green(image_blend),
    b: color_get_blue(image_blend),
}

animation_timer = MakeTimer(60, 0)

animate = function() {
    animation_timer.reset()
    // anim_text.alpha = 0.5
    anim_text.scale = 2
}
