event_inherited()

is_regenerating = false
regen_timer = MakeTimer(300, 0)

alpha_full = 0.85
alpha_drown = 0.5

hp = 30
hp_max = hp
battle_side_initial = battle_side
battle_side = battle_side_ignore
blink_timer = MakeTimer(5, 0)
is_up = false

isUp = function() {
    return is_up
}

hit = function(bullet) {
    hp -= bullet.dmg
    blink_timer.reset()
    if hp <= 0 {
        hp = 0
        regen_timer.reset()
        deactivate()
    }
}

activate = function() {
    if hp <= 0 {
        blink_timer.reset()
        return;
    }
    if hp < hp_max {
        regen_timer.reset()
    }
    is_up = true
    battle_side = battle_side_initial
}

deactivate = function() {
    is_up = false
    battle_side_initial = battle_side
    battle_side = battle_side_ignore
    if hp < hp_max {
        regen_timer.reset()
    }
}
