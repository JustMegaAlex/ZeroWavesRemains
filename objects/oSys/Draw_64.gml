
draw_set_font(fntUIBig)
SetTextAllign(1, 1)
var xx = display_get_gui_width() * 0.5
var yy = display_get_gui_height() * 0.3
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
// DebugDrawVar($"gui: {display_get_gui_width()} x {display_get_gui_height()}")
//DebugDrawVar("last key", keyboard_lastkey)
//DebugDrawVar("last char", keyboard_lastchar)
