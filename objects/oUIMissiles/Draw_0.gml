
no_player_exit


x = xstart
repeat oPlayer.weapon_emp_missile.ammo * oPlayer.is_emp_unlocked {
    draw_self()
    x += distance
}
