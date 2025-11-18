
// bringDamage = function() {
// 	var inst = instance_place(x, y, object_to_hit)
// 	if inst { contact(inst) }
// }

contact = function(inst) {
    if (!fading or fading_hurt_frames > 0)
            and inst != shooter and CanHit(inst) {
        oParticles.hitSparks(inst.x, inst.y, image_angle + 180, 6, 0.5)
		inst.hit(id)
		fading = true
        fading_hurt_frames = 0
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
dist_went = 0

xprev = x
yprev = y

original_width = sprite_width

fading = false
fading_hurt_frames = 4
