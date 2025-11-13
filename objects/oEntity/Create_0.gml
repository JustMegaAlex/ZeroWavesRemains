
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

weapon = {
    dmg: 0
}

battle_side = battle_side_none
can_hit = can_hit_all

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

die = function() {
    instance_destroy()
}

hit = function(dmg) {
    hp -= dmg
    if hp <= 0 {
        die()        
    }
}

/// Late init
alarm[0] = 1
