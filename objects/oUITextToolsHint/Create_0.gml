
event_inherited()

weapons_shown = false
shield_shown = false
emp_shown = false

text_weapons = new Text(0, 0, "Press 1-2-3 or E/Q to switch weapons", {color: c_lime, font: fntUI})
text_shield = new Text(0, 0, "Press C to raise shield", {color: c_lime, font: fntUI})
text_emp = new Text(0, 0, "Press X to fire emp missiles", {color: c_lime, font: fntUI})

set_visible = function() {
    no_player_exit
    if !weapons_shown and global.player_bought_weapon {
        text = text_weapons
        visible = true
        if oInput.Pressed("switch_weapon") 
                or oInput.Pressed("switch_weapon_fwd")
                or oInput.Pressed("switch_weapon_back") {
            weapons_shown = true
            visible = false
        }
    }
    if !shield_shown and oPlayer.shield {
        text = text_shield
        visible = true
        if oInput.Pressed("device1") {
            shield_shown = true
            visible = false
        }
    }
    if !emp_shown and oPlayer.is_emp_unlocked {
        text = text_emp
        visible = true
        if oInput.Pressed("device2") {
            emp_shown = true
            visible = false
        }
    }
}
