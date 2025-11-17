EnsureSingleton()

psys = part_system_create()

p_shoot_burst = part_type_create()
var lifetime = 10,
    size = 2,
    size_incr = -0.1
var sp = 7
part_type_sprite(p_shoot_burst, libSShootBurstS, false, true, false)
part_type_speed(p_shoot_burst, sp, sp, 0, 0)
part_type_life(p_shoot_burst, lifetime, lifetime)
part_type_alpha2(p_shoot_burst, 1, 0)
part_type_size(p_shoot_burst, size, size, size_incr, 0)

function emitShootBurst(x, y, dir) {
    part_type_direction(p_shoot_burst, dir, dir, 0, 0)
    part_type_orientation(p_shoot_burst, dir, dir, 0, 0, false)
    part_particles_create(psys, x, y, p_shoot_burst, 1)
}

p_explosion = part_type_create()
var lifetime = 40,
    size = 1,
    size_incr = 0
var sp = 0
part_type_sprite(p_explosion, libSExplosion, true, true, false)
part_type_speed(p_explosion, sp, sp, 0, 0)
part_type_life(p_explosion, lifetime, lifetime)
part_type_size(p_explosion, size, size, size_incr, 0)

function emitExplosion(x, y) {
    part_particles_create(psys, x, y, p_explosion, 1)
}


p_explosion_big = part_type_create()
var lifetime = 40,
    size = 1,
    size_incr = 0
part_type_sprite(p_explosion_big, libSExplosion, true, true, false)
part_type_orientation(p_explosion_big, 0, 360, 0, 0, 0)
part_type_life(p_explosion_big, 20, 60)
part_type_size(p_explosion_big, size, size, 0, 0.3)

function emitExplisionBig(x, y, r, num = 30) {
    repeat num {
        var dist = random(r)
        var dir = random(360)
        var xx = x + lengthdir_x(dist, dir)
        var yy = y + lengthdir_y(dist, dir)
        part_particles_create(psys, xx, yy, p_explosion_big, 1)
    }
}


p_bullet_burst = part_type_create()
var lifetime = 15,
    size = 0.8,
    size_incr = 0
var sp = 0
part_type_sprite(p_bullet_burst, libSShootBurstS, false, false, false)
part_type_life(p_bullet_burst, lifetime, lifetime)
part_type_size(p_bullet_burst, size, size, -0.066, 0)
//part_type_alpha2(p_bullet_burst, 1, 0)

function emitBulletBurst(x, y) {
    part_particles_create(psys, x, y, p_bullet_burst, 1)
}


ps_sparks = part_system_create()

sparks_size = {
    min: 0.5,
    max: 1,
    incr: -0.05
}
pt_sparks = createPartType(ps_sparks,
    {
        life: [20, 25],
        size: [sparks_size.min, sparks_size.max, sparks_size.incr],
        // shape: pt_shape_line,
        sprite: [sSparks, false, false, true],
        angle: [0, 0, 0, 0, true],
        dir: [-25, 25],
        speed: [20, 25, -0.5],
        scale: [2, 0.5]
    }
)

function hitSparks(x, y, angle, num=6, size=1) {
    part_type_size(pt_sparks, sparks_size.min*size, sparks_size.max*size, sparks_size.incr*size, 0)
    part_type_direction(pt_sparks, angle-45, angle+45, 0, 0)
    part_particles_create(ps_sparks, x, y, pt_sparks, num)
}

vec = new Vec2(0, 0)
pt_explosion = createPartType(ps_sparks,
    {
        life: 20,
        sprite: [sExplosion, false, false, false],
        alpha: [1, 0],
    }
)
pt_explosion_smoke = createPartType(ps_sparks,
    {
        life: 120,
        sprite: [sExplosion, false, false, false],
        alpha: [0.3, 0],
        color: c_black,
    }
)


function _explosion_beam(x, y, angle, len, count, size_start, size_end) {
    var size = -1
    var step = len / count
    vec.set(x, y)
    for (var j = 0; j < count; ++j) {
        vec.add_polar(step, angle)
        size = lerp(size_start, size_end, j / count)
        part_type_size(pt_explosion, size, size, 0, 0)
        part_type_size(pt_explosion_smoke, size, size, -0.005, 0)
        part_particles_create(ps_sparks, vec.x, vec.y, pt_explosion_smoke, 1)
        part_particles_create(ps_sparks, vec.x, vec.y, pt_explosion, 1)
    }
}
_core_randomer = randomer(-50, 50)
function explosion_2(x, y) {
    var beam_len = 150
    var beam_count = choose(7, 9)
    var beam_particles_amount = 6
    var beam_size_start = 0.6
    var beam_size_end = 0.2
    var angle_delta = 360 / beam_count
    var angle_rand = angle_delta * 0.2
    var base_angle = irandom(angle_delta)

    var core_size_base = 1.3
    var core_count = 5
    repeat core_count {
        vec.set(x, y)
        vec.add_coords(_core_randomer(), _core_randomer())
        part_type_size(pt_explosion, core_size_base*0.6, core_size_base*1.2, 0, 0)
        part_type_size(pt_explosion_smoke, core_size_base*0.6, core_size_base*1.2, 0, 0)
        part_particles_create(ps_sparks, vec.x, vec.y, pt_explosion_smoke, 1)
        part_particles_create(ps_sparks, vec.x, vec.y, pt_explosion, 1)
    }
    for (var i = 0; i < beam_count; ++i) {
        var angle = base_angle + i * angle_delta + irandom_range(-angle_rand, angle_rand)
        _explosion_beam(x, y, angle, beam_len, beam_particles_amount, beam_size_start, beam_size_end)
    }
}
















