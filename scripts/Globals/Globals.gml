#macro macro_pause if global.pause {exit}
#macro null undefined

pause = false
wave_enemies_count = 1
gameover = false
win = false



function ResetGlobals() {
    global.wave_enemies_count = 1
    global.gameover = false
    global.win = false
    global.pause = false
}
