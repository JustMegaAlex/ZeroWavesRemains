//var scale = 0.5
//image_xscale = scale
//image_yscale = scale

event_inherited()

prompt_text = "Press F to buy "

openx = x
openy = y
// opensp = 0.03
// opensp_min = 0.1

x = 0
y = 0
highlight = false

can_buy = function() {
    return oPlayer.money >= cost
}

apply = function() {

}

promptText = function() {
     var w = display_get_gui_width()
     var h = display_get_gui_height()
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, prompt_text)
}

interact = function() {
    if can_buy() {
        oPlayer.money -= cost
        apply()
        if oneshot {
            instance_destroy()
        }
    }
}

open = function() {}
