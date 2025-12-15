
weapon.timer.update()
if !instance_exists(oPlayer) { exit }

var dist = InstDist(oPlayer)
if dist < (range * 1.25) {
    image_angle = ApproachAngle(image_angle, InstDir(oPlayer), rotary_sp)
}
if !weapon.timer.timer and (dist < range) {
    Shoot(image_angle, weapon.object, weapon)
    weapon.timer.reset()
}
