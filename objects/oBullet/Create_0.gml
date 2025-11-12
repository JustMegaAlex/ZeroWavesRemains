
function bring_damage() {
	var inst = instance_place(x, y, object_to_hit)
	if inst and inst != shooter {
        if shooter and instance_exists(shooter) {
            shooter.BulletHitCallback(id, inst)
        }
		inst.Hit(id)
		instance_destroy()
	}
}

visible = false
image_speed = 0
// become visible back
alarm[0] = 1
side = -1
object_to_hit = oEntity
shooter = noone

xprev = x
yprev = y
