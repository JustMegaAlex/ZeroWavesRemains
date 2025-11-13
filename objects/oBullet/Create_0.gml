
bringDamage = function() {
	var inst = instance_place(x, y, object_to_hit)
	if inst and inst != shooter and CanHit(inst) {
		inst.hit(dmg)
		instance_destroy()
	}
}

visible = false
image_speed = 0
// become visible back
alarm[0] = 1
battle_side = -1
can_hit = 0
object_to_hit = oEntity
shooter = noone
dmg = 0

xprev = x
yprev = y
