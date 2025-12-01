test_results = []
is_generating = false

instance_destroy(oTutorial)
layer_set_visible("ui_general", false)
layer_set_visible("ui_text", false)
with oPlayer {
    display_waves = false
    display_money = false
}

audio_master_gain(0)
