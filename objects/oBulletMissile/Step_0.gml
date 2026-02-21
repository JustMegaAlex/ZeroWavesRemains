macro_pause

Move(sp, dir)
 
updateEntityCollider()


contact = function(inst) {
	if inst and inst != shooter and CanHit(inst) {
        final_fly_inst = inst
        contactFinal()
	}
}

range -= sp
if range <= 0 {
    destroy()
    exit
}

if instance_exists(target) {
    dir_to = InstDir(target)
}

if startup_timer.update() {
    sp *= 0.94
    image_angle = ApproachAngle2(image_angle, dir_to, 0.1)
    exit
}

sp = Approach2(sp, spmax, 0.05, 0.01)
image_angle = ApproachAngle(image_angle, dir_to, rotsp)
dir = image_angle

xprev = x
yprev = y

