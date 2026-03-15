event_inherited()

debug_shoot = false
display_waves = true
display_money = true

kb_prev_key = ""

money = 0

battle_side = battle_side_player

instance_create_layer(x, y, layer, oCamera)

heal_effect_timer = MakeTimer(30, 0)

shot_interact_range = 500

aim_vec = new Vec2(0, 0)
// hp = 10
gp_dir = {
    id: id,
    vec: new Vec2(0, 0),
    curr: 0,
    ratio: 0.1,
    enemy_dirs: [],
    enemy_pull_angle: 30,
    enemy_pull_force: 2,
    pull_ratio: 0.5*0,
    pull_angle: 0,
    dir_to: function() {
        vec.setv(oPlayer).add_polar(2000, oPlayer.dir)
        if oInput.AxisValueRight() != 0 {
            ArrayClear(enemy_dirs)
            with oEnemy {
                array_push(other.enemy_dirs, InstInstDir(oPlayer, id))
            }
            array_sort(enemy_dirs, true)
            var _dir_to = oInput.AxisDirRight(0.03)
            pull_angle = 0
            if !ArrayEmpty(enemy_dirs) {
                if angle_difference(id.dir, _dir_to) > 0 {
                    var en_dir = enemy_dirs[0]
                    var diff = abs(angle_difference(id.dir, en_dir))
                    if diff < enemy_pull_angle {
                        pull_angle = (enemy_pull_force - diff)/enemy_pull_angle * enemy_pull_force
                        _dir_to += diff * pull_ratio
                    }
                } else {
                    var en_dir = array_last(enemy_dirs)
                    var diff = abs(angle_difference(id.dir, en_dir))
                    if diff < enemy_pull_angle {
                        pull_angle = -(enemy_pull_force - diff)/enemy_pull_angle * enemy_pull_force
                        _dir_to -= diff * pull_ratio
                    }
                }
            }
            
            curr = ApproachAngle2(curr, _dir_to, ratio)
        }
        return curr
    }
}

is_shield_unlocked = false
shield_default_hp = 30
shield_upgrades = [45, 60]

is_emp_unlocked = false

var _pulse_costs = global.balance.items.costs.pulse
weapon_pulse = {
    dmg: 20,
    timer: MakeTimer(15),
    sp: 60,
    object: oBullet,
    name: "Pulse",
    ammo: 40,
    ammo_restore_timer: MakeTimer(40),
    knockback: 7,
    sound: sfxSingleShot,
    range: 2000,
    sprite: sUIWeaponPulse,
    upgrades: 0,
    upgrade_confs: {
        fire_rate: {
            name: "fire rate",
            stats: {
                timer: [MakeTimer(60/4.5), MakeTimer(60/5.2), MakeTimer(60/6)]
            },
            costs: _pulse_costs.fire_rate
        },
        bullet_speed: {
            name: "bullet speed",
            stats: {
                sp: [70, 78, 86]
            },
            costs: _pulse_costs.bullet_speed
        },
    }
}

var _scatter_costs = global.balance.items.costs.scatter
weapon_scatter = {
    dmg: 4,
    explosion_size: 0.5,
    timer: MakeTimer(2),
    range: 1200,
    object: oBulletScatter,
    image_xscale: 1,
    image_yscale: 1,
    spread_angle: 7,
    sp: 120,
    name: "Scatter",
    ammo: 400,
    sound: sfxBurstShotLoop,
    sound_end: sfxBurstShotEnd,
    sprite: sUIWeaponScatter,
    upgrades: 0,
    upgrade_confs: {
        dmg: {
            name: "damage",
            stats: {
                dmg: [4.5, 5]
            },
            costs: _scatter_costs.dmg
        },
        range: {
            name: "range",
            stats: {
                range: [1400, 1600]
            },
            costs: _scatter_costs.range
        },
    }
}

var _snipe_costs = global.balance.items.costs.snipe
weapon_snipe = {
    dmg: 80,
    timer: MakeTimer(60),
    object: oSnipeShot,
    range: 6000,
    name: "Snipe",
    ammo: 16,
    sound: sfxSnipeShot,
    sprite: sUIWeaponSnipe,
    upgrades: 0,
    upgrade_confs: {
        dmg: {
            name: "damage",
            stats: {
                dmg: [100, 120]
            },
            costs: _snipe_costs.dmg
        },
    }
}

var _emp_costs = global.balance.items.costs.emp
weapon_emp_missile = {
    dmg: 1,
    timer: MakeTimer(60),
    startup_time: 15,
    object: oBulletMissile,
    range: 6000,
    emp: 300,
    name: "EMP",
    ammo: 1,
    ammo_restore_timer: MakeTimer(500),
    sound: noone,
    sprite: noone,
    upgrades: 0,
    effect_radius: 700,
    hp: 1,
    upgrade_confs: {
        radius: {
            name: "shock radius",
            stats: {
                effect_radius: [820, 980]
            },
            costs: _emp_costs.radius
        },
        emp: {
            name: "stun charge",
            stats: {
                emp: [360, 420]
            },
            costs: _emp_costs.emp
        },
        ammo: {
            name: "max ammo",
            stats: {
                ammo_max: [2, 3]
            },
            costs: _emp_costs.ammo
        },
        hp: {
            name: "hit resistance",
            stats: {
                hp: [2, 3],
            },
            costs: [40, 70],
        }
    }
}


weapon = weapon_pulse
weapon_index = 0

all_weapons = [
    weapon_pulse,
    weapon_scatter, 
    weapon_snipe
]
_all_weapons = [
    weapon_pulse,
    weapon_scatter, 
    weapon_snipe,
    weapon_emp_missile
]

weapons_array = [
    weapon_pulse,
    noone, //weapon_scatter, 
    noone, //weapon_snipe
]

_weapon_default_field = function(weapon_item, key, value) {
    if !struct_has(weapon_item, key) {
        weapon_item[$ key] = value
    }
}

for (var i = 0; i < array_length(_all_weapons); ++i) {
    var item = _all_weapons[i]
    _weapon_default_field(item, "knockback", 0)
    _weapon_default_field(item, "sprite", noone)
    _weapon_default_field(item, "ammo_max", item.ammo)
    _weapon_default_field(item, "upgrades", 0)
    _weapon_default_field(item, "upgrade_confs", [])
    _weapon_default_field(item, "upgrades_max", array_length(item.upgrade_confs))
    _weapon_default_field(item, "emp", 0)
    
    /// @follow-up player metrics weapons
    _weapon_default_field(item, "active_usage_time", 0)
}

interactible = noone
shop_item = noone

function stepUpdateWeapon(weap) {
    weap.timer.update()
    var timer = weapon[$ "sound_timer"]
    if timer != undefined {
        timer.update()
    }
    if (weap.ammo >= weap.ammo_max) or (weap.timer.timer > 0) {
        return;
    }
    timer = weap[$ "ammo_restore_timer"]
    if timer != undefined and !timer.update() {
        timer.reset()
        weap.ammo++
    }
}

function unlockWeapon(weapon) {
    var ind = array_get_index(all_weapons, weapon)
    if ind > -1 {
        global.player_bought_weapon = true
        weapons_array[ind] = weapon
        return;
    }
    if weapon == weapon_emp_missile {
        is_emp_unlocked = true
        instance_create_layer(0, 0, layer, oUITargetLock)
        return;
    }
}

function unlockShield() {
    if shield != noone {
        show_debug_message("unlockShield called while shield is already unlocked ")
        return;
    }
    createShield()
    shield.hp = shield_default_hp
    shield.hp_max = shield_default_hp
}

inputSwitchWeapon = function(slot) {
    if median(1, 3, slot) != slot {
        show_debug_message($"Wrong weapon slot {slot}")
        return;
    }
    if median(1, array_length(weapons_array), slot) != slot {
        return;
    }
    slot--
    if weapons_array[slot] == noone {
        return;
    }
    weapon = weapons_array[slot]
    weapon_index = slot
    global.player_hint_switch_weapon_showed = true
}

inputSwtichWeaponDir = function(switch_weapon_dir) {
    var new_ind = weapon_index
    while true {
        new_ind = (new_ind + switch_weapon_dir) mod array_length(weapons_array)
        if new_ind < 0 { new_ind = array_length(weapons_array) - 1}
        if weapons_array[new_ind] != noone {
            break
        }
    }
    weapon = weapons_array[new_ind]
    weapon_index = new_ind
    global.player_hint_switch_weapon_showed = true
}

showed_no_ammo = false
playerShoot = function(dir) {
    if weapon.ammo <= 0 {
        // if just pressed
        if !showed_no_ammo {
            audio_play_sound(sfxNoAmmo, 3, false)
            showed_no_ammo = true
        }
        oUITextNoAmmo.show()
        return;
    }
    shoot(dir)
    weapon.ammo--
    playShotSound(weapon)
    if weapon.ammo <= 0 {
        oUITextNoAmmo.show()
    }
}

objectHit = function() {
    oUI.indicateHit()
    audio_play_sound(sfxMetalImpact, 2, false)
}

die = function() {
    audio_play_sound(sfxExplosion2, 2, false)
    oMusic.switch_music(mscLooseTheme)
    instance_destroy()
    global.gameover = true
    oParticles.explosion_2(x, y, max(sprite_width, sprite_height)*0.5)
    call_later(60, time_source_units_frames, Pause)
    repeat money {
        instance_create_layer(x, y, layer, oCollectCoin)
    }
}

current_shoot_loop_sound = noone
playShotSound = function(weapon) {
    var loop = false
    var offset = 0
    if weapon.name == "Scatter" {
        if current_shoot_loop_sound == weapon.sound {
            return;
        }
        loop = true
        offset = 1
        current_shoot_loop_sound = weapon.sound
    }
    var timer = weapon[$ "sound_timer"]
    if timer != undefined {
        if timer.timer > 0 {
            return;
        } else {
            timer.reset()
        }
    }
    audio_play_sound(weapon.sound, 2, loop, 1, offset)
}

manageShotLoopSound = function() {
    if current_shoot_loop_sound == noone {
        return
    }
    if oInput.Released("lclick") or weapon.ammo <= 0 {
        audio_stop_sound(current_shoot_loop_sound)
        current_shoot_loop_sound = noone
        if weapon[$ "sound_end"] != undefined {
            audio_play_sound(weapon[$ "sound_end"], 2, false)
            audio_sound_set_track_position(weapon[$ "sound_end"], 0.2)
        }
    }
}

heal = function(heal_amount) {
    hp += heal_amount
    hp = min(oPlayer.hp_max, oPlayer.hp)
    heal_effect_timer.reset()
    audio_play_sound(sfxRepair, 2, false)
}

fillAmmo = function(weapon, ammo_amount) {
    weapon.ammo = min(weapon.ammo_max, weapon.ammo + ammo_amount)
}

getObjectCollision = function(obj) {
    var dist = infinity
    var dist_check = 0
    var closest = noone
    with oInteractible {
        dist_check = InstDist(oPlayer)
        if dist_check < dist {
            closest = id
            dist = dist_check
        }
    }
    if closest and place_meeting(x, y, closest) {
        return closest
    }
    return noone
}

getMissileTarget = function() {
    try {
        var chosen = MouseCollision(oEnemyParent)
    } catch (e) {
        show_debug_message($"Error: MouseCollision: {e}")
        return noone
    }
    if chosen and !chosen.active {
        chosen = noone
    }
    if chosen {
        return chosen
    }
    var max_score = 0
    with oEnemyParent {
        if !active {
            continue
        }
        var angle_diff = abs(angle_difference(oPlayer.image_angle, InstInstDir(oPlayer, id) ))
        var dist = max(InstDist(oPlayer), 1)
        var score_ = min(50 / dist, 1) + (1 - angle_diff / 360)
        if score_ > max_score {
            max_score = score_
            chosen = id
        }
    }
    return chosen
}

hub_interaction = {
    attached: false,
    holding_force: 0.05,
}

hubOpen = function() {
    hub_interaction.attached = true
    oCamera.target = oShop
    dampening_val = 0.2
}

hubClose = function() {
    hub_interaction.attached = false
    oCamera.target = id
    dampening_val = dampening_val_initial
}

// interactingWithItem = getObjectCollision
interactingWithItem = MouseCollision


/// Metrics
boost_time_used = 0

is_emp_stunned = true

// unlockShield()
// unlockWeapon(weapon_emp_missile)
