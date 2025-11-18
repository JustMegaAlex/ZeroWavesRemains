
event_inherited()

destroy_on_contact = true

fadeout = false

destroy = function() {
    instance_destroy()
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
