
#macro macro_menu_section_main "main"
#macro macro_menu_section_difficulty "difficulty"
#macro macro_menu_section_pause "pause"
#macro macro_menu_section_options "options"
#macro macro_menu_section_guide "guide"
#macro macro_menu_section_yesno "yesno"

var scale = 1
image_speed = 0
alpha = 0
alpha_to = 0
alpha_hover = 0.15
alpha_pressed = 0.5
image_xscale = scale
yscale = scale
yscale_hovered = 50 / 18    // from sprite
mouse_over_me = false

action = function() {
    if yes_no {
        hideSection(section)
        oMenuButtonYes.callback = callback
        oMenuButtonNo.open_section = section
        openSection(macro_menu_section_yesno)
    } else if open_section != undefined {
        hideSection(section)
        openSection(open_section)
        callback()
    }
}

deactivate = function() {
    active = false
}
activate = function() {
    active = true
}

hideSection = function(_section) {
    with oMenuButton {
        if section == _section {
            deactivate()
        }
    }
}

hideAll = function() {
    with oMenuButton {
        deactivate()
    }
}

openSection = function(_section) {
    with oMenuButton {
        if section == _section {
            activate()
        }
    }
}
