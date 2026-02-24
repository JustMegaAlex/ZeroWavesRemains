event_inherited()

macro_pause


battle_side = battle_side_enemy
hp = 150
acc_max = 2
updateSpMax(50)

//image_blend = c_white

// state = "missiles"
state = "engage"

weapon_burst = {
    dmg: 3,
    timer: MakeTimer(180),
    burst_timer: MakeTimer(10),
    burst_count: 4,
    shots_left: 0,
    sp: 50,
    range: 2000,
    object: oBullet,
    image_xscale: 4.5,
    image_yscale: 2.5,
    knockback: 5,
}

weapon_missiles = {
    dmg: 8,
    timer: MakeTimer(300, 0),
    burst_timer: MakeTimer(60),
    burst_count: 2,
    shots_left: 0,
    sp: 55,
    range: 4000,
    object: oBulletMissile,
    knockback: 21,
    target: oPlayer,
    image_blend: #7A8299,
}

under_attack = 0
under_attack_decr = 100 / 60

hang_in_place_timer = MakeTimer(30)
blink = {
    random_timer: MakeTimer(60 * random_range(5, 15)),
    reload_timer: MakeTimer(300, 0),
    startup_timer: MakeTimer(20),
    to: new Vec2(0, 0),
    initialized: false,
}

burst_dist = weapon_burst.range * 0.8
missile_dist = weapon_missiles.range
missiles_out = false

move_around_player_dist = burst_dist



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

mover_dir = {
    id: id,
    dir: 0,
    accel_value: 1,
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

objectHit = function(bullet) {
    under_attack += 100
}

emitBlinkParticles = function() {
    var angle = image_angle + 90
    help_vec.set(sprite_width*0.5, 0).rotate(angle)
    oParticles.blinkTrace(
        x+help_vec.x, y+help_vec.y, blink.to.x+help_vec.x, blink.to.y+help_vec.y)
    oParticles.blinkTrace(
        x-help_vec.x, y-help_vec.y, blink.to.x-help_vec.x, blink.to.y-help_vec.y)
    oParticles.blinkTrace(
        x, y, blink.to.x, blink.to.y, 8)
}
