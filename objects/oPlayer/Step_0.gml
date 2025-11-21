
macro_pause

dir_to = MouseDir()
dirApproach(dir_to)

var key_up = oInput.Hold("up")
var key_down = oInput.Hold("down")
var key_right = oInput.Hold("right")
var key_left = oInput.Hold("left")
var arrows_input = key_up or key_down or key_right or key_left

if oInput.Hold("rclick") {
    accelerate(1, dir)
} else if arrows_input {
    accelerate(0.5, point_direction(
        0, 0,
        key_right - key_left,
        key_down - key_up
    ))
} else {
    accelerate(0, dir)
}

checkPushBackIntoCircle()

move()


if !weapon.timer.update() and (oInput.Hold("lclick") or debug_shoot) {
    playerShoot(dir)
    weapon.timer.reset()
}

manageShotLoopSound()

if keyboard_check_pressed(ord("1")) {
    show_debug_message("1")
}

var int = -1
try {
    int = int64(keyboard_lastchar)
} catch (e) {}
if kb_prev_char != keyboard_lastchar and median(int, 1, 5) == int {
    inputSwitchWeapon(int)
}
kb_prev_char = keyboard_lastchar
//if oInput.Pressed("switch_weapon") {
    //inputSwitchWeapon()
//}

var switch_weapon_dir = oInput.Pressed("switch_weapon_fwd") - oInput.Pressed("switch_weapon_back")
if switch_weapon_dir != 0 {
    var cur_ind = array_get_index(weapons_array, weapon)
    var new_ind = cur_ind
    while true {
        new_ind = (new_ind + switch_weapon_dir) mod array_length(weapons_array)
        if new_ind < 0 { new_ind = array_length(weapons_array) - 1}
        if weapons_array[new_ind] != noone {
            break
        }
    }
    weapon = weapons_array[new_ind]
}


/// reload restoring weapons
for (var i = 0; i < array_length(weapons_array); ++i) {
    var weap = weapons_array[i]
    if weap == noone {
        continue
    }
    var timer = weapon[$ "sound_timer"]
    if timer != undefined {
        timer.update()
    }
    if (weap.ammo >= weap.ammo_max) or (weap.timer.timer > 0) {
        continue
    }
    timer = weap[$ "ammo_restore_timer"]
    if timer != undefined and !timer.update() {
        timer.reset()
        weap.ammo++
    }

}


shop_item = MouseCollision(oShopItem)
if shop_item and InstDist(shop_item) > shot_interact_range {
    shop_item = noone
}
if shop_item and oInput.Pressed("interact") {
    shop_item.interact()
    if !instance_exists(shop_item) {
        shop_item = noone
    }
}

if global.wave_enemies_count <= 0 and oInput.Pressed("next_wave") {
    oWaveSpawner.spawn()
    weapon_pulse.ammo = min(weapon_pulse.ammo + weapon_pulse.ammo_max * 0.5, weapon_pulse.ammo_max)
}

event_inherited()
