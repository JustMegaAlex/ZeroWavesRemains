event_inherited()

macro_pause

battle_side = battle_side_enemy
move_around_player_dist = 2800

hp = 80

weapon = {
    dmg: 5,
    timer: MakeTimer(90),
    sp: 14,
    range: 4000,
    object: oBullet,
    knockback: 5,
    sprite_index: sProjectileCircle,
}

//// Movers
mover_template = {
    id: id,
    to: new Vec2(0, 0),
    finished: false,
    step: function() {
        
    },
    start: function() {
        
    }
}
mover_point = {
    id: id,
    to: new Vec2(0, 0),
    treshold_dist: 400,
    dist_to: 0,
    finished: true,
    accel_value: 0.5,
    step: function() {
        dist_to = point_distance(id.x, id.y, to.x, to.y)
        if dist_to <= treshold_dist {
            finished = true
            return;
        }
        with id {
            accelerate(other.accel_value, PointDir(other.to.x, other.to.y))
        }
    },
    start: function(x, y) {
        to.set(x, y)
        finished = false
    }
}

mover_dir = {
    id: id,
    dir: 0,
    accel_value: 0.5,
    dist_left: 0,
    dist_default: 2500,
    finished: false,
    step: function() {
        self.dist_left -= id.sp.len()
        if self.dist_left <= 0 {
            self.finished = true
            return;
        }
        with id {
            accelerate(other.accel_value, other.dir)
        }
    },
    start: function(dir, dist_left=0) {
        self.dir = dir
        self.dist_left = dist_left > 0 ? dist_left : dist_default
        self.finished = false
    }
}

mover = mover_dir


/// Aim
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

die = function() {
    global.wave_enemies_count--
    if instance_number(oEnemy) == 1 and oWaveSpawner.waves_remains == 0 {
        global.win = true
    }
    objectDie()
    instance_destroy()
    // spawn coins
    repeat irandom_range(coins_min, coins_max) {
        with instance_create_layer(x, y, layer, oCoin) {
            direction = other.last_hit_direction + irandom_range(-45, 45)
        }
    }
    oParticles.explosion_2(x, y)
    audio_play_sound(sfxExplosion1, 3, false)
    if instance_exists(oCamera) {
        oCamera.shake()
    }
}

setCoins = function(cmin, cmax) {
    coins_min = cmin
    coins_max = cmax
}


mover_point.treshold_dist = 400
updateSpMax(16)
