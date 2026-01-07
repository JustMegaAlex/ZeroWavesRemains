
if !(host_inst and host_inst.active) { exit }

no_player_exit

weapon.timer.update()

var dist = InstDist(oPlayer)
if dist < (range * 1.25) {
    image_angle = ApproachAngle(image_angle, Aim(oPlayer), rotary_sp)
}
if !weapon.timer.timer and (dist < range) {
    Shoot(image_angle, weapon.object, weapon)
    weapon.timer.reset()
}
