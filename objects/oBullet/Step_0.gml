
range -= sp
if !range or (point_distance(0, 0, x, y) > (oGameArea.radius - sprite_width)) {
	instance_destroy()
	exit
}

xprev = x
yprev = y
Move(sp, image_angle)
bringDamage()
