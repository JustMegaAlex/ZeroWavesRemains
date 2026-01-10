
event_inherited()

text = "Press 1-2-3 or E/Q to switch weapons"

set_visible = function() {
    no_player_exit
    visible = global.player_bought_weapon and !global.player_hint_switch_weapon_showed
}
