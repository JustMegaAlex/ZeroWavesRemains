
EnsureSingleton()

DebugDrawIni()
VAR_BAR_Y_BASE = 150

frames_since_start = 0

window_center()
display_set_gui_size(
    window_get_width(), window_get_height()
)

layers_to_make_visible = [
    "Instances", "BackObjects", "Parallax", //"Assets"
]

layer_set_visible("ui_text", false)
layer_set_visible("ui_buttons", false)

// show_debug_overlay(true)
