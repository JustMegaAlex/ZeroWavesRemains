event_inherited()

is_regenerating = false
regen_timer = MakeTimer(300, 0)

alpha_full = 0.75
alpha_drown = 0.3

hp = 30
hp_max = hp
battle_side_initial = 0
blink_timer = MakeTimer(5, 0)

isUp = function() {
    return regen_timer.timer <= 0 and hp > 0
}

hit = function(bullet) {
    hp -= bullet.dmg
    blink_timer.reset()
    if hp <= 0 {
        hp = 0
        regen_timer.reset()
        battle_side_initial = battle_side
        battle_side = battle_side_ingore
    }
}
