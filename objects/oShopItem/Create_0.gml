//var scale = 0.5
//image_xscale = scale
//image_yscale = scale

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
