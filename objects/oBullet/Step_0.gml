macro_pause

if fadeout {
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
