
function Shoot(dir=0, obj=oBullet, args={}) {
	var bullet = instance_create_layer(x, y, "Instances", obj, args)
	bullet.image_angle = dir
	//bullet.side = side
    bullet.shooter = id
    bullet.dmg = id.weapon.dmg
    bullet.life_distance = id.weapon.range
	return bullet
}
