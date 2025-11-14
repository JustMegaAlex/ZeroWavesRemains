macro_pause

if fading {
    image_alpha -= 0.03
    if image_alpha <= 0 {
        instance_destroy()
    }
    exit
}

dist_went += sp
if (dist_went >= range) or (point_distance(0, 0, x, y) > (oGameArea.radius - sprite_width)) {
	fading = true
	exit
}


xprev = x
yprev = y
image_xscale = dist_went / original_width
bringDamage()
