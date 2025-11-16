

var toggle = key_pressed(vk_f2)
if toggle {
    active = !active
    if active {
        oInput.SetInactive()
    }
    if !active {
        oInput.SetActive()
    }
}

if active {
    var arr = oPlayer.weapons_array
    var all_arr = oPlayer.all_weapons
    var int = -1
    if key_pressed(ord("2")) {
        var test = 1
    }
    try {
        int = int64(keyboard_lastchar)
    } catch (e) {}
    if int != -1 {
        var test = 1
    }
    if median(int, 1, 5) == int {
        int--
        if int < array_length(all_arr) {
            var add_weapon = all_arr[int]
            if array_get_index(arr, add_weapon) == -1 {
                array_push(arr, add_weapon)
                show_debug_message($"Debug: added weapon {add_weapon.name}")
            }
        }
    }
}
