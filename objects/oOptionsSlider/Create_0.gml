
effective_width_ratio = 0.9
knob_xmin = x - sprite_width * effective_width_ratio * 0.5
knob_xmax = x + sprite_width * effective_width_ratio * 0.5
active = true
visible = true
knob_is_dragged = false

function Value() {
    return (knobx - knob_xmin) / (knob_xmax - knob_xmin)
}

function Activate() {
    active = true
    visible = true
}

function Deactivate() {
    active = false
    visible = false
}

initKnobPos = function() {
    knobx = knob_xmin + (knob_xmax - knob_xmin) * value
}

array = []
array_of_initial_gains = []
controlFunction = function(val) {
    for (var i = 0; i < array_length(array); ++i) {
        audio_sound_gain(array[i], val / initial_value * array_of_initial_gains[i])
    }
}

knobx = 0
initial_value = 0.5
value = initial_value
initKnobPos()
