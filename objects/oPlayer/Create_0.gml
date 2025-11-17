event_inherited()

debug_shoot = false

kb_prev_char = ""

money = 0

battle_side = battle_side_player

instance_create_layer(x, y, layer, oCamera)

weapon_pulse = {
    dmg: 20,
    timer: MakeTimer(9),
    object: oBullet,
    name: "Pulse",
    ammo: 40,
    ammo_restore_timer: MakeTimer(30),
    knockback: 7,
    sound: sfxSingleShot,
}

weapon_scatter = {
    dmg: 4,
    timer: MakeTimer(2),
    range: 1800,
    object: oBulletScatter,
    image_xscale: 1,
    image_yscale: 1,
    spread_angle: 7,
    sp: 120,
    name: "Scatter",
    ammo: 200,
    sound: sfxBurstShotLoop,
    sound_end: sfxBurstShotEnd,
    // sound_timer: MakeTimer(6, 0)
}

weapon_snipe = {
    dmg: 120,
    timer: MakeTimer(60),
    object: oSnipeShot,
    range: 6000,
    name: "Snipe",
    ammo: 12,
    sound: sfxSnipeShot,
}

weapon = weapon_pulse

all_weapons = [
    weapon_pulse,
    weapon_scatter, 
    weapon_snipe
]

weapons_array = [
    weapon_pulse,
    //weapon_scatter, 
    //weapon_snipe
]

for (var i = 0; i < array_length(all_weapons); ++i) {
    var item = all_weapons[i]
    item.ammo_max = item.ammo
    if !struct_has(item, "knockback") {
        item.knockback = 0
    }
}


shop_item = noone


inputSwitchWeapon = function(slot) {
    if median(1, 5, slot) != slot {
        show_debug_message($"Wrong weapon slot {slot}")
        return;
    }
    if median(1, array_length(weapons_array), slot) != slot {
        return;
    }
    weapon = weapons_array[slot-1]
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
    audio_play_sound(sfxLastHit, 2, false)
    instance_destroy()
    global.gameover = true
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
