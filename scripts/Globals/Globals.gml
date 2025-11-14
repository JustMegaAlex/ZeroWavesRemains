#macro macro_pause if global.pause {exit}
#macro null undefined

pause = false
wave_enemies_count = 1


function ResetGlobals() {
    wave_enemies_count = 1
}
