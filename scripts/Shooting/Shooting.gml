
#macro battle_side_none 0 
#macro battle_side_neutral 1
#macro battle_side_enemy 2
#macro battle_side_player 4
#macro can_hit_all 7

function Shoot(dir=0, obj=oBullet, args={}) {
	var bullet = instance_create_layer(x, y, "Bullets", obj, args)
	bullet.image_angle = dir
	bullet.battle_side = battle_side
    bullet.can_hit = can_hit
    bullet.shooter = id
    //bullet.dmg = id.weapon.dmg
    //bullet.life_distance = id.weapon.range
	return bullet
}

function CanHit(entity) {
    return (entity.battle_side != battle_side)
           and (entity.battle_side & can_hit)
}

function Aim(target) {
    var sight_angle = point_direction(x, y, target.x, target.y)
    var evasion_angle = angle_difference(target.sp.dir(), sight_angle)
    var target_sp_len = target.sp.len()
    if (abs(evasion_angle) < 5) or (target_sp_len == 0) {
        return sight_angle
    }
    var beta_angle = 180 - abs(evasion_angle)
    var evasion_dir = sign(evasion_angle)
    var bullet_sp = weapon.sp
    var aim_angle_sin = target_sp_len/bullet_sp * lengthdir_y(-1, beta_angle)
    if abs(aim_angle_sin) > 1 {
        return sight_angle
    }
    var aim_angle = radtodeg(arcsin(aim_angle_sin)) * evasion_dir
	if (abs(aim_angle) + beta_angle) >= 180 {
        return sight_angle
    }
    return sight_angle + aim_angle + choose(0, 3, 4, 5, 6, 7, 8, 9, 10) * choose(1, -1)
}
