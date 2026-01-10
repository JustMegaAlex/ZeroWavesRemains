
function Start() {
    ResetGlobals()
    layer_set_visible("ui_general", true)
    room_goto(BALANCE ? rmTestBalance : rmGame)

    global.play_start_time = current_time
    global.plays_total++
}

function Pause() {
    global.pause = true
    oMenuButton.openSection(macro_menu_section_pause)
    // layer_set_visible("ui_text_gameplay", false)
    AdjustSliders() // in case we went fullscreen in main menu
    // layer_set_visible("ui_text", global.pause)
}

function Unpause() {
    global.pause = false
    oMenuButton.hideAll()
    layer_set_visible("ui_text", false)
    // layer_set_visible("ui_text_gameplay", true)
}

function Restart() {
    Unpause()
    ResetGlobals()
    oMenuButton.hideAll()
    /// Room restart causes sound gains to reset
    /// And Room start event won't shoot for some reason in ui objects (at least in sliders)
    /// so do it manually
    with oOptionsSlider {
        call_later(2, time_source_units_frames, function() {
            controlFunction(Value())
        })
    }
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

function ToggleFullscreen() {
    window_set_fullscreen(!window_get_fullscreen())
    call_later(5, time_source_units_frames, display_set_gui_maximize)
    AdjustSliders()
}

function AdjustSliders() {
    /// knobs are drawn using gui event
    /// we need to adjust their positions when changing window size
    with oOptionsSlider {
        knob_xmin = x - sprite_width * effective_width_ratio * 0.5
        knob_xmax = x + sprite_width * effective_width_ratio * 0.5
        call_later(10, time_source_units_frames, initKnobPos)
    }
}
