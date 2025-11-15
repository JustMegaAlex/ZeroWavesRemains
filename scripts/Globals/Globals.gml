#macro macro_pause if global.pause {exit}
#macro null undefined

pause = false
wave_enemies_count = 1
increase_spawning_speed_between_waves = false
gameover = false
win = false


debug_tiny = noone

function ResetGlobals() {
    global.wave_enemies_count = 1
    global.gameover = false
    global.win = false
    global.pause = false
}


/// Shop
snipe_cost = 80
scatter_cost = 50
heal_cost = 50
snipe_ammo_cost = 30
scatter_ammo_cost = 20
