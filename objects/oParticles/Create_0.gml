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
