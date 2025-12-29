if main_weapon == noone {
    exit
}
helper_vec.setv(main_weapon_pos).rotate(image_angle)
main_weapon.x = x + helper_vec.x
main_weapon.y = y + helper_vec.y
