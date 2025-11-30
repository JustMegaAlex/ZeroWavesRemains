if !global.tutorial exit

var w = display_get_gui_width()
var h = display_get_gui_height()
step.gui(w,h)

SetTextAllign(1, 1)
with skip_tutorial {
    draw_text(x*w, y*h, text)
    draw_set_color(bar_col)
    if value > 0 {
        draw_rectangle(x*w, y*h + 30, x*w + bar_len*value*0.5, y*h+42, false)
        draw_rectangle(x*w, y*h + 30, x*w - bar_len*value*0.5, y*h+42, false)
        draw_rectangle(x*w, y*h + 30, x*w + bar_len*0.5, y*h+42, true)
        draw_rectangle(x*w, y*h + 30, x*w - bar_len*0.5, y*h+42, true)
    }
    draw_set_color(c_white)
}
