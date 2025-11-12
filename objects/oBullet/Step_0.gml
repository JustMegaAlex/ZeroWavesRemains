
range -= sp
if !range {
	instance_destroy()
	exit
}

xprev = x
yprev = y
Move(sp, image_angle)
bring_damage()
