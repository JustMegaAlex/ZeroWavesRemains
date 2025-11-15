
draw_set_font(fntUIBig)
SetTextAllign(1, 1)
var xx = window_get_width() * 0.5
var yy = window_get_height() * 0.3
if global.win {
    draw_text(xx, yy, "Zero waves remains!\nPress R to start again")
} else if global.gameover {
    draw_text(xx, yy, "Lost!\nPress R to restart")
} else if global.pause {
    draw_text(xx, yy, "Pause\nYou can restart the game by pressing R")
}

//// Skip ui section
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("", "")
DebugDrawVar("last key", keyboard_lastkey)
DebugDrawVar("last char", keyboard_lastchar)
