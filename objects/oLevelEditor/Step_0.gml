
if !active {
    exit
}

if is_mouse_over_debug_overlay() {
	exit
}

if global.pause {
    collision_point_list(
        mouse_x, mouse_y,
        oLevelEditorInstancePlaceholder,
        false, false, mouse_over_instances, true)

    var size = ds_list_size(mouse_over_instances)
    if size == 0 {
        exit
    }

    var inp = keyboard_check_pressed(ord("X")) - keyboard_check_pressed(ord("Z"))
    chosen_pos += inp
    chosen_pos = clamp(chosen_pos, 0, size - 1)

    // highlight chosen instance
    mouse_over_instances[| chosen_pos].image_blend = c_green
    if mouse_check_button_pressed(mb_left) {
        SetChosenPlaceholder(mouse_over_instances[| chosen_pos])
    }
    ds_list_clear(mouse_over_instances)
} else {
    // if mouse_check_button_pressed(mb_left) {
    //     var inst = noone
    //     if chosen_instance == noone {
    //         for (var i = 0; i < array_length(replaced_objects); ++i) {
    //             var item = replaced_objects[i]
    //             inst = MouseCollision(item)
    //             if inst != noone {
    //                 SetChosenInstance(inst)
    //                 break
    //             }
    //         }
    //     } else {
    //         DropChosen()
    //     }
    // }
}


