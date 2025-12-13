
macro_pause

deny_killing_shot = global.tutorial

if oInput.is_user_input_keyboard {
    dir_to = MouseDir()
} else {
    dir_to = gp_dir.dir_to()
}
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
    inputSwtichWeaponDir(switch_weapon_dir)
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

if shop_item {
    shop_item.highlight = false
}
shop_item = interactingWithItem(oInteractible)
if shop_item and object_is_ancestor(shop_item.object_index, oShopItem)
        and !(shop_item.is_unlocked and oShop.is_open) {
    shop_item = noone
}
if shop_item {
    if shop_item and InstDist(shop_item) > shot_interact_range {
        shop_item = noone
    }
    if shop_item {
        shop_item.highlight = true
    }
    if shop_item and oInput.Pressed("interact") {
        shop_item.interact()
        if !instance_exists(shop_item) {
            shop_item = noone
        }
    }
}

oShop.highlight = false
if !oShop.is_open and place_meeting(x, y, oShop) {
    oShop.highlight = true
    if oInput.Pressed("interact") {
        oShop.open()
    }
}

if !global.tutorial and global.wave_enemies_count <= 0 and oInput.Pressed("next_wave") {
    if instance_exists(oEnemyParent) and !audio_is_playing(mscStealthTheme) {
        oMusic.switch_music(mscStealthTheme)
    }
    show_debug_message($"Activating by player")
    oWaveSpawner.spawn()
    weapon_pulse.ammo = min(weapon_pulse.ammo + weapon_pulse.ammo_max * 0.5, weapon_pulse.ammo_max)
}

if !global.tutorial
        and !instance_exists(oEnemyParent)
        and oWaveSpawner.waves_remains <= 0 {
    global.win = true
}

event_inherited()
