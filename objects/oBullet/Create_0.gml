
// bringDamage = function() {
// 	var inst = instance_place(x, y, object_to_hit)
// 	if inst and inst != shooter and CanHit(inst) {
// 		inst.hit(id)
// 		instance_destroy()
// 	}
// }

contact = function(inst) {
	if inst and inst != shooter and CanHit(inst) {
		inst.hit(id)
		instance_destroy()
        oParticles.hitSparks(x, y, image_angle + 180)
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

xprev = x
yprev = y


SetColor()
