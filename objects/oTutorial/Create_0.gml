
#macro default_gui gui: function(w, h) {draw_text(w*0.5, h*0.7, self.text)}

step_template = {
        gui: function(w, h) {
        },
        step: function() {
        },
        done: function() {
            return false
        }
}
steps = [
    {
        l: 0, r: 0, u: 0, d: 0,
        text: "WASD to move",
        default_gui,
        step: function() {
            l = l or oInput.Hold("left")
            r = r or oInput.Hold("right")
            u = u or oInput.Hold("up")
            d = d or oInput.Hold("down")
        },
        done: function() {
            return (l + r + u + d) == 4
        }
    },
    {
        pressed: false,
        default_gui,
        text: "Left mouse to shoot",
        step: function() {
            pressed = pressed or oInput.Hold("lclick")
        },
        done: function() {
            return pressed
        }
    },
    {
        arr: [],
        default_gui,
        text: "Destroy all 3 dummies",
        start: function() {
            array_push(arr, instance_create_layer(100, 600, "Instances", oEnemy, {active: false}))
            array_push(arr, instance_create_layer(300, -600, "Instances", oEnemy, {active: false}))
            array_push(arr, instance_create_layer(1200, 400, "Instances", oEnemy, {active: false}))
            for (var i = 0; i < array_length(arr); ++i) {
                var item = arr[i]
                oUI.addHintArrow(item, "enemy", c_red)
            }
        },
        done: function() {
            for (var i = 0; i < array_length(arr); ++i) {
                if instance_exists(arr[i]) {
                    return false
                }
            }
            return true
        }
    },
/*
    {
        gui: function(w, h) {
        },
        step: function() {
        }
        done: function() {
        }
    }
*/
]
var keys = [
    "gui",
    "start",
    "step",
    "done",
]
for (var i = 0; i < array_length(steps); ++i) {
    var _step = steps[i]
    for (var j = 0; j < array_length(keys); ++j) {
        var key = keys[i]
        if !struct_has(_step, key) {
            _step[$ key] = function() {}
        }
    }
}

step = steps[0]
step_index = 0


