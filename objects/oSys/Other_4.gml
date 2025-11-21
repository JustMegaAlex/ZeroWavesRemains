
display_set_gui_maximise()

oMusic.switch_music(mscIntro)

for (var i = 0; i < array_length(layers_to_make_visible); ++i) {
    var name = layers_to_make_visible[i]
    if layer_exists(name) {
        layer_set_visible(layer_get_id(name), true)
    }
}
