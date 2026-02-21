macro_pause

range -= sp
if final_fly_inst {
    final_fly_steps--
    if final_fly_steps <= 0 {
        contactFinal()
    }
}
else if !range or (point_distance(0, 0, x, y) > (oGameArea.radius - sprite_width)) {
	instance_destroy()
	exit
}

xprev = x
yprev = y
Move(sp, image_angle)
