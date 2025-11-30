event_inherited()

debug_shoot = false
display_waves = true
display_money = true

kb_prev_char = ""

money = 0

battle_side = battle_side_player

instance_create_layer(x, y, layer, oCamera)

heal_effect_timer = MakeTimer(30, 0)

shot_interact_range = 500

// hp = 10

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
    upgrade_confs: [
        {sp: 70, timer: MakeTimer(13), cost: global.item_costs.pulse[0]},
        {sp: 80, timer: MakeTimer(10), cost: global.item_costs.pulse[1]},
        {sp: 100, timer: MakeTimer(8), cost: global.item_costs.pulse[2]},
    ]
}

weapon_scatter = {
    dmg: 4,
    timer: MakeTimer(2),
    range: 1200,
    object: oBulletScatter,
    image_xscale: 1,
    image_yscale: 1,
    spread_angle: 7,
    sp: 120,
    name: "Scatter",
    ammo: 200,
    sound: sfxBurstShotLoop,
    sound_end: sfxBurstShotEnd,
    sprite: sUIWeaponScatter,
    upgrades: 0,
    upgrade_confs: [
        {range: 1400, dmg: 4.5, cost: global.item_costs.scatter[1]},
        {range: 1600, dmg: 5, cost: global.item_costs.scatter[2]},
    ]
}

weapon_snipe = {
    dmg: 70,
    timer: MakeTimer(60),
    object: oSnipeShot,
    range: 6000,
    name: "Snipe",
    ammo: 12,
    sound: sfxSnipeShot,
    sprite: sUIWeaponSnipe,
    upgrades: 0,
    upgrade_confs: [
        {dmg: 90, cost: global.item_costs.snipe[1]},
        {dmg: 120, cost: global.item_costs.snipe[2]},
    ]
}

weapon = weapon_pulse
weapon_index = 0

all_weapons = [
    weapon_pulse,
    weapon_scatter, 
    weapon_snipe
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

for (var i = 0; i < array_length(all_weapons); ++i) {
    var item = all_weapons[i]
    _weapon_default_field(item, "knockback", 0)
    _weapon_default_field(item, "sprite", noone)
    _weapon_default_field(item, "ammo_max", item.ammo)
    _weapon_default_field(item, "upgrades", 0)
    _weapon_default_field(item, "upgrade_confs", [])
    _weapon_default_field(item, "upgrades_max", array_length(item.upgrade_confs))
}


shop_item = noone


function unlockWeapon(weapon) {
    var ind = array_get_index(all_weapons, weapon)
    weapons_array[ind] = weapon
}

inputSwitchWeapon = function(slot) {
    if median(1, 5, slot) != slot {
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
}

playerShoot = function(dir) {
    if weapon.ammo <= 0 {
        return;
    }
    shoot(dir)
    weapon.ammo--
    playShotSound(weapon)
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
    oParticles.explosion_2(x, y)
    repeat money {
        instance_create_layer(x, y, layer, oCoin)
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


// interactingWithItem = MouseCollision
interactingWithItem = getObjectCollision
