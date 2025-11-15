event_inherited()

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


if !weapon.timer.update() and oInput.Hold("lclick") {
    playerShoot(dir)
    weapon.timer.reset()
}

if oInput.Pressed("switch_weapon") {
    inputSwitchWeapon()
}

var switch_weapon_dir = oInput.Pressed("switch_weapon_fwd") - oInput.Pressed("switch_weapon_back")
if switch_weapon_dir != 0 {
    var cur_ind = array_get_index(weapons_array, weapon)
    var new_ind = (cur_ind + switch_weapon_dir) mod array_length(weapons_array)
    if new_ind < 0 { new_ind = array_length(weapons_array) - 1}
    weapon = weapons_array[new_ind]
}


/// reload restoring weapons
for (var i = 0; i < array_length(weapons_array); ++i) {
    var item = weapons_array[i]
    if (item.ammo >= item.ammo_max) or (item.timer.timer > 0) {
        continue
    }
    var timer = item[$ "ammo_restore_timer"]
    if timer != undefined and !timer.update() {
        timer.reset()
        weapon.ammo++
    }
}


shop_item = MouseCollision(oShopItem)
if shop_item and oInput.Pressed("interact") {
    shop_item.interact()
    if !instance_exists(shop_item) {
        shop_item = noone
    }
}
