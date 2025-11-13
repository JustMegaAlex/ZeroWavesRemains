
#macro battle_side_none 0 
#macro battle_side_neutral 1
#macro battle_side_enemy 2
#macro battle_side_player 4
#macro can_hit_all 7

function Shoot(dir=0, obj=oBullet, args={}) {
	var bullet = instance_create_layer(x, y, "Instances", obj, args)
	bullet.image_angle = dir
	bullet.battle_side = battle_side
    bullet.can_hit = can_hit
    bullet.shooter = id
    bullet.dmg = dmg
    //bullet.dmg = id.weapon.dmg
    //bullet.life_distance = id.weapon.range
	return bullet
}

function CanHit(entity) {
    return (entity.battle_side != battle_side)
           and (entity.battle_side & can_hit)
}
