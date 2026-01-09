if !active {
    exit
}

draw_self()
draw_sprite(sUISliderKnob, 0, knobx, y)

draw_set_font(global.ui_font)
SetTextAllign(2, 1)
draw_text_transformed(x - sprite_width * 0.57, y, name, 0.7, 0.7, 0)
