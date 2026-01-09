draw_set_font(global.ui_font)

draw_set_alpha(show_indicator_timer.timer/show_indicator_timer.time)
draw_text(
    window_get_width()*0.9,
    window_get_height()*0.1,
    "Debug " + (active ? "on" : "off"))
draw_set_alpha(1)
