
event_inherited()

destroy_on_contact = true

fadeout = false

destroy = function() {
    instance_destroy()
}

contactExtra = function(inst) {
    if effect_radius > 0 {
        oParticles.empShockwave(x, y, effect_radius*1.3)
        var list = ds_list_create()
        var count = collision_circle_list(x, y, effect_radius, oEntity, false, true, list, false)
        for (var i = 0; i < count; ++i) {
            var inst_ = list[| i]
            if inst_ != shooter and CanHit(inst_) {
                inst_.hit(id)
            }
        }
        ds_list_destroy(list)
    }
}

setDir = function(dir_) {
    image_angle = dir_
    dir_to = dir_
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

startup_timer = MakeTimer(60)
accel = 0.5
rotsp = 10
dir_to = image_angle
spmax = sp
sp = 0


SetColor()

createEntityCollider()
//entity_collider.image_blend = c_red