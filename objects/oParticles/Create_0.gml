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

p_explosion = createPartType(psys, {
    life: 5,
    // alpha: [1, 0],
    sprite: sExplosion,
})
function emitExplosion(x, y, size=1) {
    part_type_size(p_explosion, size, size, 0, 0)
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

function hitSparks(x, y, angle, num=6, size=1, spread=45) {
    part_type_size(pt_sparks, sparks_size.min*size, sparks_size.max*size, sparks_size.incr*size, 0)
    part_type_direction(pt_sparks, angle-spread, angle+spread, 0, 0)
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

_explosion_fade_life = 20
pt_explosion_fade = createPartType(ps_sparks,
    {
        life: _explosion_fade_life,
        sprite: [sExplosion, false, false, false],
        alpha: [1, 0.7],
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

function emitExplosionFade(x, y, num=1, size=1, radius=undefined) {
    part_type_size(pt_explosion_fade, size*.8, size, -size/_explosion_fade_life, 0)
    if num == 1 {
        part_particles_create(psys, x, y, pt_explosion_fade, 1)
        return
    }
    if radius == undefined {
        radius = sprite_get_width(sExplosion) * size * 0.5
    }
    repeat num {
        part_particles_create(
            psys, 
            x+random_range(-radius, radius),
            y+random_range(-radius, radius),
            pt_explosion_fade, 1)
    }
}


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
_explosion_size_base = 150
function explosion_2(x, y, size=_explosion_size_base) {
    size = size / _explosion_size_base // turn to relative
    emitExplosionFade(
        x, y,
        4 + irandom(4) * size,
        size * 3.5, size*220)
    emitExplosionFade(
        x, y,
        8 + irandom(8) * size,
        size*1.5, size*220)
    return;
    var beam_len = 150 * size
    var beam_count = choose(7, 9)
    var beam_particles_amount = 6
    var beam_size_start = 0.6 * size
    var beam_size_end = 0.2 * size
    var angle_delta = 360 / beam_count
    var angle_rand = angle_delta * 0.2
    var base_angle = irandom(angle_delta)

    var core_size_base = 1.3 * size
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

bullet_trace_particle_map = ds_map_create()
function getOrCreateBulletTraceParticleType(width, spd, life=60) {
    if ds_map_exists(bullet_trace_particle_map, spd) {
        return bullet_trace_particle_map[? spd]
    }
    var pt = createPartType(
        psys,
        {
            life: life,
            shape: pt_shape_pixel,
            alpha: [0.9, 0],
            scale: [spd, width]
        }
    )
    bullet_trace_particle_map[? spd] = pt
    return pt
}

function bulletTrace(pt, xx, yy, angle) {
    part_type_orientation(pt, angle, angle, 0, 0, false)
    part_particles_create(psys, xx, yy, pt, 1)
}



pt_emp = createPartType(psys,
    {
        life: 20,
        sprite: [sParticleEmp, false, false, false],
        alpha: [0.8, 0],
        color: c_white,
        angle: [0, 360]
    }
)
function emp(xx, yy) {
    part_particles_create(psys, xx, yy, pt_emp, 1)
}
pt_emp_shockwave_params = {
    life: 7,
    sprite: [sCircleHollow, false, false, false],
    alpha: [0.5, 0.0],
    color: c_white,
    size: 0.1
}
pt_emp_shockwave = createPartType(psys, pt_emp_shockwave_params)
function empShockwave(xx, yy, rad) {
    var params = pt_emp_shockwave_params
    var max_size = rad / sprite_get_width(params.sprite[0])
    var start_size = max_size * 0.5
    var size_incr = (max_size - start_size) / params.life
    part_type_size(pt_emp_shockwave, start_size, start_size, size_incr, 0)
    part_particles_create(psys, xx, yy, pt_emp_shockwave, 1)
}







