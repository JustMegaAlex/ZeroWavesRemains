
bg_alpha = Approach(bg_alpha, bg_alpha_base, 0.03)
var blend_change = 1 - (bg_alpha - bg_alpha_base) / (1 - bg_alpha_base)
blend = make_color_rgb(255, 255, 255 * lerp(0.6, 1, blend_change))

with anim {
    y += sp
    sp -= y * spring + sp * dissip
    if abs(sp) < 0.01 and abs(y) < 1 {
        sp = 0
        y = 0
    }
}

no_player_exit

coins = oPlayer.money
