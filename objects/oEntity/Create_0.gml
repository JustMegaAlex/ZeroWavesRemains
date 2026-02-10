
help_vec = new Vec2(0, 0) // for general geometry computing purposes

image_speed = 0

invincible = false
deny_killing_shot = false

///// Ships functionality
hp_max = 100
hp = hp_max
acc_max = 0.5
sp_max = 24
dampening_val = acc_max / sp_max
dampening_val_initial = dampening_val
acc = new Vec2(0, 0)
dampening = new Vec2(0, 0)
sp = new Vec2(0, 0)
dir = 0
dir_to = 0
rotary_sp = 6
mass_factor = 1
// readonly
sp_dir = 0
sp_len = 0
is_dead = false

last_hit_direction = 0

weapon = {
    dmg: 0,
    object: oBullet,
}

shield = noone

is_emp_stunned = false
emp_particle_timer = MakeTimer(12)

updateSpMax = function(_sp) {
    sp_max = _sp
    updateDampening()
}

updateDampening = function() {
    dampening_val = acc_max / sp_max
    dampening_val_initial = dampening_val
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
    sp_dir = sp.dir()
    sp_len = sp.len()
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
    is_dead = true
    objectDie()
    instance_destroy()
}

objectDie = function() {}

hit = function(bullet) {
    if invincible {
        return;
    }
    if shield and shield.isUp() {
        shield.hit(bullet)
        return;
    }
    if deny_killing_shot and hp <= bullet.dmg {
        return;
    }
    hp -= bullet.dmg
    last_hit_direction = bullet.image_angle
    if bullet.knockback > 0 {
        sp.add_polar(bullet.knockback / mass_factor, bullet.image_angle)
    }
    objectHit(bullet)
    if hp <= 0 {
        die()
    }
    var snd = inst_get(bullet, "contact_sound")
    if snd != undefined {
        audio_play_sound(snd, 2, false)
    }
}

objectHit = function() {}

shoot = function(dir) {
    weapon.battle_side = battle_side
    return Shoot(dir, weapon.object, weapon)
}

list = ds_list_create()
catchBullet = function() {
    ds_list_clear(list)
    var count = instance_place_list(x, y, oBulletParent, list, false)
    for (var i = 0; i < ds_list_size(list); ++i) {
        list[| i].contact(id)
        if !instance_exists(id) {
            return
        }
    }
}

createShield = function() {
    var scale = 2 * max(sprite_width, sprite_height) / sprite_get_width(sShield)
    shield = instance_create_layer(x, y, layer, oShield, {
        battle_side: battle_side, image_xscale: scale, image_yscale: scale
    })
}

/// Late init
alarm[0] = 1

SetColor()


if sprite_index_norm == noone {
    var name = sprite_get_name(sprite_index) + "NM"
    var spr = asset_get_index(name)
    if spr {
        sprite_index_norm = spr
    }
}

