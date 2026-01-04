if !EnsureSingleton() {
	exit
}

scroll_down = false
scroll_up = false

is_user_input_keyboard = true

//// Mouse
mouse_moved = false
mouse_x_prev = mouse_x
mouse_y_prev = mouse_y
gamepad_enabled = false

active = true

enum GmType {
    none, xbox, playstation
}
gp_id = -1
gp_info = undefined
gp_type = GmType.none

function Mouse(key) constructor {
    self.key = key
    Pressed = function() {
        return mouse_check_button_pressed(self.key)
    }
    Released = function() {
        return mouse_check_button_released(self.key)
    }
    Hold = function() {
        return mouse_check_button(self.key)
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}

function MouseWheelUp() constructor {
    Pressed = function() {
        return mouse_wheel_up()
    }
    Released = function() {
        return mouse_wheel_up()
    }
    Hold = function() {
        return mouse_wheel_up()
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}

function MouseWheelDown() constructor {
    Pressed = function() {
        return mouse_wheel_down()
    }
    Released = function() {
        return mouse_wheel_down()
    }
    Hold = function() {
        return mouse_wheel_down()
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}

function Key(key) constructor {
    self.key = key
    Pressed = function() {
        return keyboard_check_pressed(self.key)
    }
    Released = function() {
        return keyboard_check_released(self.key)
    }
    Hold = function() {
        return keyboard_check(self.key)
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}

function Gamepad(key) constructor {
    self.key = key
    Pressed = function() {
        return gamepad_button_check_pressed(oInput.gp_id, self.key) * oInput.gamepad_enabled
    }
    Released = function() {
        return gamepad_button_check_released(oInput.gp_id, self.key) * oInput.gamepad_enabled
    }
    Hold = function() {
        return gamepad_button_check(oInput.gp_id, self.key) * oInput.gamepad_enabled
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}


function GamepadAxis(key, sign_, treshold=0) constructor {
    self.key = key
	self.treshold = treshold
	self.sign = sign_
	self.previous_value = false
    self.current_value = false
    Pressed = function() {
        // this is called first, so we assign current value here
		self.current_value = (gamepad_axis_value(oInput.gp_id, self.key) * self.sign) >= self.treshold
        return (self.current_value and !self.previous_value) * oInput.gamepad_enabled
    }
    Released = function() {
        // this is called last, so we assign previous value here
        var result = (!self.current_value and self.previous_value) * oInput.gamepad_enabled
        self.previous_value = self.current_value
        return result
    }
    Hold = function() {
        return self.current_value * oInput.gamepad_enabled
    }
    DefaultValue = function() { return false }
    actions = [
        ["pressed", self.Pressed],
        ["released", self.Released],
        ["hold", self.Hold],
    ]
}

function AxisValueLeft(treshold=0.05) {
	var gaxisx = gamepad_axis_value(gp_id, gp_axislh)
	var gaxisy = gamepad_axis_value(gp_id, gp_axislv)
    if (abs(gaxisx) < treshold) and (abs(gaxisy) < treshold) {
        return 0
    }
	return point_distance(0, 0, gaxisx, gaxisy) * oInput.gamepad_enabled
}

function AxisValueRight(treshold=0.05) {
	var gaxisx = gamepad_axis_value(gp_id, gp_axisrh)
	var gaxisy = gamepad_axis_value(gp_id, gp_axisrv)
    if (abs(gaxisx) < treshold) and (abs(gaxisy) < treshold) {
        return 0
    }
	return point_distance(0, 0, gaxisx, gaxisy)    * oInput.gamepad_enabled
}

function AxisDirLeft(treshold=0.25) {
	var gaxisx = gamepad_axis_value(gp_id, gp_axislh)
	var gaxisy = gamepad_axis_value(gp_id, gp_axislv)
    if (abs(gaxisx) < treshold) and (abs(gaxisy) < treshold) {
        return 0
    }
	return point_direction(0, 0, gaxisx, gaxisy) * oInput.gamepad_enabled
}

function AxisDirRight(treshold=0.25) {
	var gaxisx = gamepad_axis_value(gp_id, gp_axisrh)
	var gaxisy = gamepad_axis_value(gp_id, gp_axisrv)
    if (abs(gaxisx) < treshold) and (abs(gaxisy) < treshold) {
        return 0
    }
	return point_direction(0, 0, gaxisx, gaxisy) * oInput.gamepad_enabled
}

function DistinctInput(name) constructor {
    /*
    Use for a fine inputs control for specific instances
    */
    self.name = name
    self.enabled = true
    function SetEnabled(value) {
        self.enabled = value
    }
    function Pressed(key) {
        if (!self.enabled) {
            return false
        }
        return oInput.Pressed(key)
    }
    function Released(key) {
        if (!self.enabled) {
            return false
        }
        return oInput.Released(key)
    }
    function Hold(key) {
        if (!self.enabled) {
            return false
        }
        return oInput.Hold(key)
    }
}

distinct_inputs = {}
function GetDistinctInput(name) {
    var input = struct_get(distinct_inputs, name)
    if (input == undefined) {
        distinct_inputs[$ name] = new DistinctInput(name)
    }
    return distinct_inputs[$ name]
}

function DetectGamepadDevice() {
    if !gamepad_enabled { return false }
    for (var i = 0; i < gamepad_get_device_count(); i += 1) {
        if gamepad_is_connected(i) {
            gp_id = i
            gp_info = gamepad_get_description(i)
            DefineGpType()
            return true
        }
    }
    gp_id = -1
    gp_info = undefined
    gp_type = GmType.none
    return false
}

function GamepadConnected() {
    return gp_id != -1
}

if !GamepadConnected() {
    // retry
    alarm[0] = 30
}
gamepad_set_axis_deadzone(gp_id, 0.25)

/// @follow-up input keys mapping
mapping_config = {
    switch_weapon: [
        new Key(ord("1")),
        new Key(ord("2")),
        new Key(ord("3")),
        new Key(ord("4")),
        new Key(ord("5")),
    ],
    switch_weapon_fwd: [new Key(ord("E")), new Gamepad(gp_shoulderl)],
    switch_weapon_back: [new Key(ord("Q")), new Gamepad(gp_shoulderlb)],
    left: [new Key(vk_left), new Key(ord("A")),
           new Gamepad(gp_padl), new GamepadAxis(gp_axislh, -1, 0.05)],
    right: [new Key(vk_right), new Key(ord("D")),
            new Gamepad(gp_padr), new GamepadAxis(gp_axislh, 1, 0.05)],
    up: [new Key(vk_up), new Key(ord("W")), new GamepadAxis(gp_axislv, -1, 0.05)],
    down: [new Key(vk_down), new Key(ord("S")), new GamepadAxis(gp_axislv, 1, 0.05)],
    lclick: [new Mouse(mb_left), new Gamepad(gp_shoulderr)],
    boost: [new Mouse(mb_right), new Key(vk_shift), new Gamepad(gp_shoulderrb)],
    escape: [new Key(vk_escape)],
    any: [new Key(vk_anykey), new Mouse(mb_any),
          new Gamepad(gp_face1), new Gamepad(gp_face2),
          new Gamepad(gp_padu), new Gamepad(gp_padd),
          new Gamepad(gp_padr), new Gamepad(gp_padl),
    ],
    reload: [new Key(ord("R")), new Gamepad(gp_face4)],
    pause: [new Key(ord("P")), new Gamepad(gp_start)],
    zoom_in: [new MouseWheelUp(), new Gamepad(gp_padl)],
    zoom_out: [new MouseWheelDown(), new Gamepad(gp_padl)],
    skip_tutorial: [new Key(ord("T")), new Gamepad(gp_face4)],
    skill1: [new Key(ord("1"))],
    interact: [new Key(ord("F")), new Gamepad(gp_face1)],
    next_wave: [new Key(vk_space), new Gamepad(gp_face2)],
}
//// Initialize key mapping
mapping = {}
var keys = variable_struct_get_names(mapping_config)
for (var i = 0; i < array_length(keys); ++i) {
    var key = keys[i]
	mapping[$ key] = {}
    var inputs = mapping_config[$ key]
    for (var j = 0; j < array_length(inputs); ++j) {
        var input = inputs[j]
        for (var k = 0; k < array_length(input.actions); ++k) {
            var action = input.actions[k]
            var def = input.DefaultValue()
            mapping[$ key][$ action[0]] = def
        }
    }
}

function Pressed(key) {
    return self.mapping[$ key].pressed
}
function Released(key) {
    return self.mapping[$ key].released
}
function Hold(key) {
    return self.mapping[$ key].hold
}


function DefineGpType() {
    if gp_info == undefined {
        return
    }
    var s = string_lower(gp_info)
    if string_pos("ps", s)
            or string_pos("playstation", s) {
        gp_type = GmType.playstation
    } else if string_pos("xbox", s) {
        gp_type = GmType.xbox
    }
}

function SetActive() {
    active = true
}
function SetInactive() {
    active = false
}

