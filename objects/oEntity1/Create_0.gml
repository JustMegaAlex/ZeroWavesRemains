sp = new Vec2(0, 0)
pos = new Vec2(x, y)

error = undefined

instances_collision_list = ds_list_create()

cargo = {}

is_taking_damage = true
can_be_killed = true

function KeepShooting(target) {
    if !weapon.reload_timer.update() {
        Shoot(Aim(target), oBullet, {
            dmg: weapon.dmg, range: weapon.range, sp: weapon.sp
        })
        weapon.reload_timer.reset()
    }
}

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

/* Not finished (and prob not needed)
target_traj = new Line(0, 0, 0, 0)
bullet_traj = new Line(0, 0, 0, 0)
intersection_point = new Vec2(0, 0)
function AimExact(target) {
    var angle_max = 90
    var angle_min = 0
    var sight_angle = InstDir(target)
    var target_sp_len = target.sp.len()
    var target_sp_angle = target.sp.dir()
    var evasion_angle = angle_difference(sight_angle, target_sp_angle)
    if (abs(evasion_angle) < 15) or (target_sp_len == 0) {
        return sight_angle
    }
    var evasion_dir = sign(evasion_angle)
    var aim_angle = 45
    target_traj.set(target.x, target.y, target.x + 3000, target.y).rotate(target_sp_angle)
    var bullet_sp = weapon.sp
    var error = infinity
    var time = 0
    while abs(error) > 1 {
        bullet_traj.set(x, y, x + 3000, y).rotate(aim_angle * evasion_dir + sight_angle)
        LineIntersectionPoint(target_traj, bullet_traj, false, intersection_point)
        time = point_distance(intersection_point.x, intersection_point.y, target.x, target.y) / target_sp_len
        bullet_needed_speed = point_distance(intersection_point.x, intersection_point.y, x, y) / time
        error = (bullet_sp - bullet_needed_speed) * time
        if error > 0 {
            angle_max = aim_angle
            aim_angle = (angle_max + angle_min) / 2
        } else {
            angle_min = aim_angle
            aim_angle = (angle_max + angle_min) / 2
        }
    }
    return aim_angle
}
*/

function DropItems() {}


function Kill() {
    self.DropItems()
    instance_destroy()
}

function _hit(bullet) {

}

function Hit(bullet) {
    if !is_taking_damage {
        return
    }
    hp -= bullet.dmg
    if hp <= 0 and can_be_killed {
        Kill()
    }
    self._hit(bullet)
}

function BulletHitCallback(bullet) {
    
}

function NeedRepair() {
    return hp < hpmax
}

function Repair(quantity) {
    hp = min(hp + quantity, hpmax)
    oFloatingText.Emit($"+{quantity}hp", x, y, c_green)
}

function AddCargo(item_name, quantity) {
    if struct_has(cargo, item_name) {
        cargo[$ item_name] += quantity
    } else {
        cargo[$ item_name] = quantity
    }
}

function CheckCargo(item_name) {
    if struct_has(cargo, item_name) {
        return cargo[$ item_name]
    }
    return 0
}

function RemoveCargo(item_name, quantity=-1) {
    if quantity == -1 or cargo[$ item_name] <= quantity {
        var q = cargo[$ item_name]
        struct_del(cargo, item_name)
        return q
    }
    cargo[$ item_name] -= quantity
    return quantity
}

/// Data management
ds_lists = []
function EntityCreateList() {
    var list = ds_list_create()
    array_push(ds_lists, list)
    return list
}
