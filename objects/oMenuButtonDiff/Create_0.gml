event_inherited()

menu_section = macro_menu_section_difficulty

callback = function() {
    room_goto(rmGame)
    global.difficulty = difficulty
}
