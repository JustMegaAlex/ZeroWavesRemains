event_inherited()

if is_up {
    hp = Approach(hp, 0, hp_max / dissipate_time)
    catchBullet()
    image_alpha = lerp(alpha_drown, alpha_full, hp / hp_max)
    if blink_timer.update() {
        image_alpha = 1
    }
    if hp <= 0 {
        deactivate()
    }
} else {
    image_alpha = (blink_timer.update() > 0)
    hp = Approach(hp, hp_max, hp_max / regen_time)
}
