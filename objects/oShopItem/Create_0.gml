//var scale = 0.5
//image_xscale = scale
//image_yscale = scale

prompt_text = "Press F to "

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
