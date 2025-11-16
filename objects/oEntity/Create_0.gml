
invincible = false

///// Ships functionality
hp_max = 100
hp = hp_max
acc_max = 0.5
sp_max = 24
dampening_val = acc_max / sp_max
acc = new Vec2(0, 0)
dampening = new Vec2(0, 0)
sp = new Vec2(0, 0)
dir = 0
dir_to = 0
rotary_sp = 6

last_hit_direction = 0

weapon = {
    dmg: 0,
    object: oBullet,
}

battle_side = battle_side_none
can_hit = can_hit_all

updateDampening = function() {
    dampening_val = acc_max / sp_max
}

dirApproach = function(dir_to, rot_sp=rotary_sp) {
	var diff = angle_difference(dir_to, dir)
	if abs(diff) < rot_sp {
		dir = dir_to
		return true
	}
	dir += rotary_sp * sign(diff)
}

accelerate = function(ratio, dir) {
    acc.set_polar(acc_max * ratio, dir)
}

move = function() {
    sp.add(acc)
    dampening.set(sp.x * dampening_val, sp.y * dampening_val)
    sp.sub(dampening)
    x += sp.x
    y += sp.y
}

checkPushBackIntoCircle = function() {
    if !active { return }
    if PointDist(0, 0) > oGameArea.radius {
        var suck_dir = PointDir(0, 0)
        acc.add_polar(acc_max, suck_dir)
    }
}

die = function() {
    objectDie()
    instance_destroy()
}

objectDie = function() {}

hit = function(bullet) {
    if invincible {
        return;
    }
    hp -= bullet.dmg
    last_hit_direction = bullet.image_angle
    objectHit()
    if hp <= 0 {
        die()
    }
}

objectHit = function() {}

shoot = function(dir) {
    Shoot(dir, weapon.object, weapon)
}

catchBullet = function() {
    var bullet = instance_place(x, y, oBullet)
    if bullet {
        bullet.contact(id)
    }
}

/// Late init
alarm[0] = 1

SetColor()
