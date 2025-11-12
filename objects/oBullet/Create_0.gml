
bringDamage = function() {
	var inst = instance_place(x, y, object_to_hit)
	if inst and inst != shooter and CanHit(inst) {
		inst.Hit(id)
		instance_destroy()
	}
}

visible = false
image_speed = 0
// become visible back
alarm[0] = 1
battle_side = -1
object_to_hit = oEntity
shooter = noone

xprev = x
yprev = y
