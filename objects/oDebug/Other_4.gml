

dbg_section("Lighting", true)
DebugViewAddRefs(oNMLighting, [
    ["light_z", dbg_slider, -1000, 300],
])
/// refs for in-struct variables
DebugViewAddRefs([oNMLighting, "ambience"], [
    ["r", dbg_slider, 0, 255],
    ["g", dbg_slider, 0, 255],
    ["b", dbg_slider, 0, 255],
])
//// Buttons to toggle instance layers' visibility
dbg_section("Layers", false)
var layers = layer_get_all()
var _dbg_buttons = []
for (var i = 0; i < array_length(layers); ++i) {
    var lay_id = layers[i]
    var callable = {
        layer_id: lay_id,
        call: function() {
            layer_set_visible(self.layer_id, !layer_get_visible(self.layer_id))
        }
    }
    array_push(_dbg_buttons, [
        layer_get_name(lay_id), dbg_button, callable.call
    ])
}
DebugViewAddRefs(global, _dbg_buttons)