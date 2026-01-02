
#macro DEV 0
#macro BALANCE false

#macro Dev:DEV true
#macro Balance:BALANCE true


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
increase_spawning_speed_between_waves = false
shop_links_initialized = false
tutorial = false
tutorial_finished = false
wave_enemies_count = 0
waves_remains = 0
win = false


music_assets = [
    mscIntro, mscLooseTheme, mscStealthTheme,
]

debug_tiny = noone

function ResetGlobals() {
    global.wave_enemies_count = 0
    global.gameover = false
    global.win = false
    global.pause = false
    global.shop_links_initialized = false
}


game_colors = {}

function SetColor() {
    
    var col = global.game_colors[$ object_get_name(object_index)]
    if col == undefined {
        var obj = object_get_parent(object_index)
        if obj {
            col = global.game_colors[$ object_get_name(obj)]
        }
    }
    if col != undefined {
        image_blend = col
    }
}

/// Shop


//// Objects configs
behemoth_turret_coords = [] // defined in oEnemyBehemoth in rmStart
behemoth_gun_shoot_point = {}
behemoth_gun_position = {}