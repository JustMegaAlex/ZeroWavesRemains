
#macro macro_menu_section_main "main"
#macro macro_menu_section_difficulty "difficulty"

menu_section = macro_menu_section_main

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
}

deactivate = function() {
    active = false
}
activate = function() {
    active = true
}

hideSection = function(section) {
    with oMenuButton {
        if menu_section == section {
            deactivate()
        }
    }
}

openSection = function(section) {
    with oMenuButton {
        if menu_section == section {
            activate()
        }
    }
}
