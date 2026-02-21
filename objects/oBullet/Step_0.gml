macro_pause


if final_fly_inst {
    final_fly_steps--
    if final_fly_steps <= 0 {
        contactFinal()
    }
}
else if fadeout {
    image_yscale -= 0.15
    if image_yscale <= 0 {
        instance_destroy()
    }
}

range -= sp
if !fadeout and !range {
	fadeout = true
    sparks_count = 1
    knockback = 0
    dmg = 0
    sp *= 0.6
}

xprev = x
yprev = y
Move(sp, image_angle)
