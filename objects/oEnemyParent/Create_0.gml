event_inherited()

macro_pause

battle_side = battle_side_enemy
move_around_player_dist = 1000


weapon = {
    dmg: 5,
    timer: MakeTimer(45),
    sp: 40,
    range: 2000,
    object: oBullet,
    knockback: 7,
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
    shift_vec: new Vec2(0, 0),
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
        to.set(x, y).add(shift_vec)
        finished = false
    },
    update: function(x, y) {
        to.set(x, y).add(shift_vec)
    },
    updatev: function(vec) {
        to.setv(vec).add(shift_vec)
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

die = function() {
    global.wave_enemies_count--
    is_dead = true
    if instance_number(oEnemyParent) == 1 and oWaveSpawner.waves_remains == 0 {
        Win()
    }
    objectDie()
    instance_destroy()
    // spawn coins
    repeat irandom_range(coins_min, coins_max) {
        with instance_create_layer(x, y, layer, oCollectCoin) {
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

var my_coins = global.balance.coins[$ object_get_name(object_index)]
if my_coins != undefined {
    setCoins(my_coins[0], my_coins[1])
}
