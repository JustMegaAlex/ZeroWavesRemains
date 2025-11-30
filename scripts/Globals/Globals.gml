
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

DEBUG = DEV

pause = false
gameover = false
win = false
tutorial = false
tutorial_finished = false
wave_enemies_count = 0
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
drone_arrow_color = c_aqua

function SetColor() {
    var col = global.game_colors[$ object_get_name(object_index)]
    if col != undefined {
        image_blend = col
    }
}

/// Shop

item_costs = {
    pulse: [10, 40, 70],
    // [buy_cost, upgrade costs...]
    snipe: [80, 80, 90, 120],
    scatter: [60, 60, 70, 90],
    heal: 40,
    // [cost, amount]
    snipe_ammo: [20, 5],
    scatter_ammo: [20, 100],
}

heal_amount = 50
