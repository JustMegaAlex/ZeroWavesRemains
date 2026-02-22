
// bringDamage = function() {
// 	var inst = instance_place(x, y, object_to_hit)
// 	if inst and inst != shooter and CanHit(inst) {
// 		inst.hit(id)
// 		instance_destroy()
// 	}
// }

help_vec = new Vec2(0, 0)

destroy_on_contact = true
fadeout = false

destroy = function() {
    emitExposion()
    instance_destroy()
}

emitExposion = function() {
    help_vec.set(x, y).add_polar(sprite_width*0.5, image_angle)
    oParticles.emitExplosion(help_vec.x, help_vec.y, explosion_size)
    oParticles.emitExplosionFade(help_vec.x, help_vec.y, 3, explosion_size * 0.75)
}


final_fly_steps = 2
final_fly_inst = noone

sparks_count = 6
contact = function(inst) {
    if fadeout or final_fly_inst {
        return;
    }
	if inst and inst != shooter and CanHit(inst) {
        final_fly_inst = inst
	}
}

contactFinal = function() {
    if instance_exists(final_fly_inst) {
        final_fly_inst.hit(id)
        contactExtra(final_fly_inst)
    }
    oParticles.hitSparks(x, y, image_angle + 180, sparks_count)
    if dmg {
        audio_play_sound(sfxShotContactFeedback, 2, false)
    }
    if destroy_on_contact {
        destroy()
    }
}

contactExtra = function(inst) {

}

function createEntityCollider(entity_hit_callback=destroy) {
    entity_collider = instance_create_layer(x, y, layer, oEntity)
    entity_collider.battle_side = battle_side
    entity_collider.sprite_index = sprite_index
    entity_collider.image_index = image_index
    hitCallback = {
        id: entity_collider,
        callback: entity_hit_callback,
        my_bullet: id,
        hit: function(bullet) {
            if bullet == my_bullet {
                return;
            }
            callback()
            instance_destroy(id)
        }
    }
    entity_collider.hit = hitCallback.hit
    entity_collider.visible = false
    return entity_collider
}

function updateEntityCollider() {
    entity_collider.x = x
    entity_collider.y = y
    entity_collider.image_angle = image_angle
    entity_collider.image_xscale = image_xscale
    entity_collider.image_yscale = image_yscale
}

setDir = function(dir_) {
    image_angle = dir_
    dir = dir_
}

visible = false
image_speed = 0
// become visible back
alarm[0] = 1
can_hit = 0
object_to_hit = oEntity
shooter = noone

xprev = x
yprev = y


SetColor()
