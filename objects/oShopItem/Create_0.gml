//var scale = 0.5
//image_xscale = scale
//image_yscale = scale

event_inherited()

prompt_text = "Press F to buy "

icon = noone
draw_icon = is_unlocked

openx = x
openy = y
parent_node = noone
child_nodes = []
// opensp = 0.03
// opensp_min = 0.1

highlight = false

can_buy = function() {}

can_buy_base = function() {
    return (oPlayer.money >= cost) and can_buy()
}

apply = function() {}

apply_base = function() {
    apply()
    for (var i = 0; i < array_length(child_nodes); ++i) {
        child_nodes[i].unlock()
    }
}

interact = function() {
    if can_buy_base() {
        oPlayer.money -= cost
        apply_base()
        if oneshot {
            instance_destroy()
        }
    }
}

open = function() {}

unlock = function() {
    is_unlocked = true
    image_index = 0
}

promptTextWeapon = function() {
     var w = display_get_gui_width()
     var h = display_get_gui_height()
    SetTextAllign(1, 0)
    draw_text(w*0.5, h*0.75, text)
    draw_set_color(c_white)
    if show_cost {
        var col = can_buy_base() ? c_yellow : c_red
        draw_set_color(col)
        draw_text(w*0.5, h*0.75 - 40, cost)
        draw_set_color(c_white)
    }
}

if !is_unlocked {
    image_index = 2
}
