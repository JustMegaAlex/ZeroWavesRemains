macro_pause

if fading {
    if (--fading_hurt_frames) > 0 {
        bringDamage()
    }
    image_alpha -= 0.03
    if image_alpha <= 0 {
        instance_destroy()
    }
    exit
}

dist_went += sp
if (dist_went >= range) {
	fading = true
	exit
}


xprev = x
yprev = y
image_xscale = dist_went / original_width
bringDamage()
