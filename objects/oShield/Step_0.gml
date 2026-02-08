event_inherited()

if is_up {
    catchBullet()
    image_alpha = lerp(alpha_drown, alpha_full, hp / hp_max)
    if blink_timer.update() {
        image_alpha = 1
    }
} else {
    image_alpha = (blink_timer.update() > 0)
    if !regen_timer.update() {
        hp = hp_max
    }
}

