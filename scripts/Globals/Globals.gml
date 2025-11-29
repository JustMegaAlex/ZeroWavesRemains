
#macro DEV false

#macro Dev:DEV true

#macro macro_pause if global.pause {exit}
#macro no_player_exit if !instance_exists(oPlayer) {exit}
#macro no_player_return if !instance_exists(oPlayer) {return;}
#macro null undefined
#macro key_pressed keyboard_check_pressed
#macro key_released keyboard_check_released
#macro key_hold keyboard_check
#macro press_f_prompt "Press F to"

pause = false
gameover = false
win = false
tutorial = false
tutorial_finished = false
wave_enemies_count = 1
waves_remains = 0
increase_spawning_speed_between_waves = false




debug_tiny = noone

function ResetGlobals() {
    global.wave_enemies_count = 1
    global.gameover = false
    global.win = false
    global.pause = false
}


game_colors = {}

function SetColor() {
    var col = global.game_colors[$ object_get_name(object_index)]
    if col != undefined {
        image_blend = col
    }
}

/// Shop
snipe_cost = 80
snipe_ammo_cost = 30
scatter_cost = 25
scatter_ammo_cost = 20
heal_cost = 50
heal_amount = 50
