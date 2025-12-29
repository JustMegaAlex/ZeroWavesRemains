

event_inherited()

macro_pause

battle_side = battle_side_enemy
move_around_player_dist = 1000
acc_max = 0.12
updateSpMax(8)
rotary_sp = 0.7
switch_to_long_range_distance = 1200
hp = 600
mass_factor = 6


is_firing = false
is_long_distance_fire_state = false
state_timer_randomer = irandomer(240, 480)
state_timer = MakeTimer(state_timer_randomer())
shots_left = 0
weapon = {
    rotary_speed: 0.7,
    min_range: 400,
    angle: 0,
    angle_to: 0,
    relx: 0,
    rely: 0,
    dmg: 5,
    timer: MakeTimer(5),
    sp: 40,
    range: 7000,
    object: oBullet,
    knockback: 7,
    spread_angle: 10,
    recharge_timer: MakeTimer(240),
    shots_count: 30,
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
    treshold_dist: 40,
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
    start: function(dir, dist_left) {
        self.dir = dir
        self.dist_left = dist_left
        self.finished = false
    }
}

mover = mover_point


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

//// Create turrets
turrets = []
turret_helper_vec = new Vec2(0, 0)
for (var i = 0; i < array_length(global.behemoth_turret_coords); ++i) {
    var vec = global.behemoth_turret_coords[i]
    var turret = instance_create_layer(
        x + vec.x, y + vec.y, "FrontInstances", oEnemyBehemothTurret
    )
    turret.rel_vec = new Vec2(vec.x, vec.y)
    turret.battle_side = battle_side
    turret.can_hit = can_hit
    turret.image_blend = image_blend
    array_push(turrets, turret)
}

helper_vec = new Vec2(0, 0)
main_weapon = noone
main_weapon_pos = new Vec2(0, 0)
var pos = global.behemoth_gun_position
if pos[$ "x"] != undefined {
    main_weapon_pos.setv(pos)
    main_weapon = instance_create_layer(
        x + pos.x, y + pos.y, "FrontInstances", oEnemyBehemothGun,
        {
            shoot_args: {
                weapon: weapon, dir: dir, can_hit: can_hit,
                battle_side:battle_side, visible: false
            },
            image_blend: image_blend
        }
    )
}


//// Define turrets coords config
if room == rmStart {
    global.behemoth_turret_coords = []
    with oEnemyBehemothTurret {
        if place_meeting(x, y, other) {
            array_push(global.behemoth_turret_coords, 
                       new Vec2(x - other.x, y - other.y))
        }
    }
    with instance_place(x, y, oEnemyBehemothGun) {
        global.behemoth_gun_position.x = x - other.x
        global.behemoth_gun_position.y = y - other.y
        show_debug_message("Found behemoth gun")
        instance_destroy()
    }
    instance_destroy()
}