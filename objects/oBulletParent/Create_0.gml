
// bringDamage = function() {
// 	var inst = instance_place(x, y, object_to_hit)
// 	if inst and inst != shooter and CanHit(inst) {
// 		inst.hit(id)
// 		instance_destroy()
// 	}
// }

destroy_on_contact = true

destroy = function() {
    instance_destroy()
}

sparks_count = 6
contact = function(inst) {
	if inst and inst != shooter and CanHit(inst) {
		inst.hit(id)
        oParticles.hitSparks(x, y, image_angle + 180, sparks_count)
        if dmg {
            audio_play_sound(sfxShotContactFeedback, 2, false)
        }
        if destroy_on_contact {
            destroy()
        }
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
