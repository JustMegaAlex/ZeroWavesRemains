
highlight = false

interact = function() {
    
}


promptText = function() {
    var w = display_get_gui_width()
    var h = display_get_gui_height()
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, text)
}
