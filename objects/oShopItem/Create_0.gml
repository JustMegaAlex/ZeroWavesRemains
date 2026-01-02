//var scale = 0.5
//image_xscale = scale
//image_yscale = scale

event_inherited()

prompt_text = "Press F to buy "

visible = is_unlocked

icon = noone

openx = x
openy = y
parent_node = noone
child_nodes = []
// opensp = 0.03
// opensp_min = 0.1

highlight = false

can_buy = function() {
    return oPlayer.money >= cost
}

apply = function() {

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

unlock = function() {
    visible = true
    is_unlocked = true
}



promptTextWeapon = function() {
     var w = display_get_gui_width()
     var h = display_get_gui_height()
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, text)
    draw_set_color(c_white)
    var col = can_buy() ? c_yellow : c_red
    draw_set_color(col)
    draw_text(w*0.5, h*0.75 - 40, cost)
    draw_set_color(c_white)
}
