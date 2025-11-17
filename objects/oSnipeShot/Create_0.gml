
image_yscale = 4.5

contact = function(inst) {
	if inst and inst != shooter and CanHit(inst) {
        var xx = inst.x
        var yy = inst.y
		inst.hit(id)
        if !instance_exists(inst) {
            oParticles.hitSparks(xx, yy, 0, 24, 1.2, 360)
        } else {
            oParticles.hitSparks(xx, yy, image_angle + 180, 12)
        }
	}
}

image_speed = 0
battle_side = -1
can_hit = 0
object_to_hit = oEntity
shooter = noone
alarm[0] = 2

image_xscale = 1
image_xscale = range / sprite_width
var animation_time = 25
image_yscale_sp = image_yscale / animation_time

