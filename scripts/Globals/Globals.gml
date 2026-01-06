
#macro DEV 0
#macro BALANCE false

#macro Dev:DEV true
#macro Balance:BALANCE true


#macro macro_pause if global.pause {exit}
#macro no_player_exit if !instance_exists(oPlayer) {exit}
#macro no_player_return if !instance_exists(oPlayer) {return;}
#macro no_player_destroy_exit if !instance_exists(oPlayer) { instance_destroy(); exit }
#macro null undefined
#macro key_pressed keyboard_check_pressed
#macro key_released keyboard_check_released
#macro key_hold keyboard_check
#macro press_f_prompt "Press F to"
#macro macro_ui_text_spawn_wave_pos ui_text_spawn_wave_pos
#macro macro_ui_shop_prompt_pos ui_shop_prompt_pos
#macro macro_difficulty_normal 0
#macro macro_difficulty_hard 1
#macro __diff ByDifficulty

DEBUG = DEV

pause = false
difficulty = macro_difficulty_normal
gameover = false
increase_spawning_speed_between_waves = false
loot_controlled_randomer = undefined
shop_links_initialized = false
tutorial = false
tutorial_finished = false
wave_enemies_count = 0
waves_remains = 0
win = false
victory_theme = mscVictory

macro_ui_text_spawn_wave_pos = {x: 0, y: 0}
macro_ui_shop_prompt_pos = {x: 0, y: 0}


music_assets = [
    mscIntro, mscLooseTheme, mscStealthTheme,
]

debug_tiny = noone

function ResetGlobals() {
    InitBalance()
    InitItems()
    global.wave_enemies_count = 0
    global.gameover = false
    global.win = false
    global.pause = false
    global.shop_links_initialized = false
    oLootManager.initLoot()
}


game_colors = {}

function ByDifficulty() {
    return argument[global.difficulty]
}

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


//// Objects configs
behemoth_turret_coords = [] // defined in oEnemyBehemoth in rmStart
behemoth_gun_shoot_point = {}
behemoth_gun_position = {}