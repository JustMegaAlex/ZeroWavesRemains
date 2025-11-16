macro_pause

if fading {
    fading_hurt_frames--
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
