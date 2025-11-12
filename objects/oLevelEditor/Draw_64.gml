// for (var i = 0; i < ds_list_size(mouse_over_instances); ++i) {
//     var item = mouse_over_instances[| i]

// }

var names = variable_struct_get_names(changes)
for (var i = 0; i < array_length(names); ++i) {
    var inst_id = names[i]
    var change = changes[$ inst_id]
    DebugDrawVar(string(inst_id), struct_get(change, "__payload"))
}

//// Draw cross in screen center
if active {
    draw_set_alpha(0.5)
    draw_set_color(c_white)
    var xx = window_get_width() / 2
    var yy = window_get_height() / 2
    draw_line_width(xx, yy - 50, xx, yy + 50, 3)
    draw_line_width(xx - 50, yy, xx + 50, yy, 3)
    draw_set_alpha(1)
}
