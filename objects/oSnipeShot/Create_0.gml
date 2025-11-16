
bringDamage = function() {
	var inst = instance_place(x, y, object_to_hit)
	if inst and inst != shooter and CanHit(inst) {
		inst.hit(id)
		instance_destroy()
	}
}

image_yscale = 4.5

image_speed = 0
battle_side = -1
can_hit = 0
object_to_hit = oEntity
shooter = noone
// alarm[0] = 1

image_xscale = 1
image_xscale = range / sprite_width
var animation_time = 25
image_yscale_sp =  image_yscale / animation_time

