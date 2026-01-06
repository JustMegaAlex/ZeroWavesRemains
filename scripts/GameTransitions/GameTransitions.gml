
function Start() {
    ResetGlobals()
    layer_set_visible("ui_general", true)
    room_goto(BALANCE ? rmTestBalance : rmGame)
}

function Pause() {
    global.pause = true
    oMenuButton.openSection(macro_menu_section_pause)
    layer_set_visible("ui_text_gameplay", false)
    // layer_set_visible("ui_text", global.pause)
}

function Unpause() {
    global.pause = false
    oMenuButton.hideAll()
    layer_set_visible("ui_text", false)
    layer_set_visible("ui_text_gameplay", true)
}

function Restart() {
    Unpause()
    ResetGlobals()
    oMenuButton.hideAll()
    layer_set_visible("ui_text", false)
	room_restart()
}

function MenuHowTo() {
    // button callback
    layer_set_visible("ui_text", true)
}

function MenuHowToBack() {
    // button callback
    layer_set_visible("ui_text", false)
}

function EndRun() {
    global.gameover = false
    global.win = false
    oMusic.switch_music(noone, false, 3000)
}

function Win() {
    oMusic.switch_music(global.victory_theme)
    global.win = true
}
