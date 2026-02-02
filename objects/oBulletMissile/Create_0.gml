
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
