event_inherited()


callback = function() {
    Unpause()
    EndRun()
    room_goto(rmTitleScreen)
    hideSection(section)
    layer_set_visible("ui_general", false)
}
