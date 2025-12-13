
//// Reset all keys in mapping
var keys = variable_struct_get_names(mapping)
for (var i = 0; i < array_length(keys); ++i) {
    var key = keys[i]
    var key_actions = mapping[$ key]
    var action_names = variable_struct_get_names(key_actions)
    for (var j = 0; j < array_length(action_names); ++j) {
        key_actions[$ action_names[j]] = false
    }
}


var keys = variable_struct_get_names(mapping_config)
for (var i = 0; i < array_length(keys); ++i) {
    var key = keys[i]
    var inputs = mapping_config[$ key]
    for (var j = 0; j < array_length(inputs); ++j) {
        var input = inputs[j]
        for (var k = 0; k < array_length(input.actions); ++k) {
            /// action is [action_name, function] pair
            var action = input.actions[k]
            /// if action is already defined, skip
            if mapping[$ key][$ action[0]] {
                continue
            }
            mapping[$ key][$ action[0]] = action[1]()
        }
    }
}

scroll_down = false
scroll_up = false

if !active
	exit

scroll_down = mouse_wheel_down()
scroll_up = mouse_wheel_up()

//// Mouse
var mx = window_mouse_get_x()
var my = window_mouse_get_y()
mouse_moved = mx != mouse_x_prev or my != mouse_y_prev
mouse_x_prev = mx
mouse_y_prev = my


//// Switching between keyboard and gamepad
if gamepad_enabled {
    if is_user_input_keyboard {
        var check = gamepad_button_check
        if check(gp_id, gp_face1) or check(gp_id, gp_face2) or check(gp_id, gp_face3) or check(gp_id, gp_face4) or
                check(gp_id, gp_shoulderl) or check(gp_id, gp_shoulderlb) or check(gp_id, gp_shoulderr) or check(gp_id, gp_shoulderrb) or
                check(gp_id, gp_select) or check(gp_id, gp_start) or check(gp_id, gp_stickl) or check(gp_id, gp_stickr) or
                check(gp_id, gp_padu) or check(gp_id, gp_padd) or check(gp_id, gp_padl) or check(gp_id, gp_padr) or
                check(gp_id, gp_home) or check(gp_id, gp_touchpadbutton) or check(gp_id, gp_paddler) or check(gp_id, gp_paddlel) or
                check(gp_id, gp_paddlerb) or check(gp_id, gp_paddlelb) or check(gp_id, gp_extra1) or check(gp_id, gp_extra2) or
                check(gp_id, gp_extra3) or check(gp_id, gp_extra4) or check(gp_id, gp_extra5) or check(gp_id, gp_extra6) or
                gamepad_axis_value(gp_id, gp_axislh) != 0 or gamepad_axis_value(gp_id, gp_axislv) != 0 {
            is_user_input_keyboard = false
        }
    } else {
        if mouse_moved or mouse_check_button(mb_any) or keyboard_check_pressed(vk_anykey) {
            is_user_input_keyboard = true
        }
    }
}
