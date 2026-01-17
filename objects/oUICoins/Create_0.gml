image_speed = 0
coin_color = global.game_colors.oCollectCoin
coins = 0

blend = c_white

up = 1
down = 2
up_bg = 3
down_bg = 4
coin = 5

bg_alpha_base = 0.3
bg_alpha = bg_alpha_base

anim = {
    start_sp: -3,
    sp: 0,
    y: 0,
    dissip: 0.9,
    spring: 0.5,
}


animate_y = 0

animate = function() {
    bg_alpha = 1
    anim.sp = anim.start_sp
}

