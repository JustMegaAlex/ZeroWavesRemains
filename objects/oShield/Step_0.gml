event_inherited()

if regen_timer.timer > 0 {
    image_alpha = (blink_timer.update() > 0)
    if !regen_timer.update() {
        hp = hp_max
        battle_side = battle_side_initial
    }
    exit
}

catchBullet()

image_alpha = lerp(alpha_drown, alpha_full, hp / hp_max)
if blink_timer.update() {
    image_alpha = 1
}
