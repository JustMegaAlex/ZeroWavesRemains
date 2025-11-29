
#macro default_gui gui: function(w, h) {draw_text(w*0.5, h*0.7, self.text)}

oWaveSpawner.active = false

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
        in: 0, out: 0,
        default_gui,
        text: "Mouse scroll to zoom in/out",
        step: function() {
            in = in or oInput.Pressed("zoom_in")
            out = out or oInput.Pressed("zoom_out")
        },
        done: function() {
            return (in + out) == 2
        }
    },
    {
        arr: [],
        default_gui,
        text: "Destroy all 3 dummies",
        start: function() {
            var args = {active: false, coins_min: 0, coins_max: 0}
            array_push(arr, instance_create_layer(100, 600, "Instances", oEnemy, args))
            array_push(arr, instance_create_layer(300, -600, "Instances", oEnemy, args))
            array_push(arr, instance_create_layer(1200, 400, "Instances", oEnemy, args))
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
    {
        text: "Press Space to spawn a wave!",
        spawned: 3,
        default_gui,
        done: function() {
            if instance_exists(oEnemy) {
                text = "Destroy the wave!"
                return false
            } else if spawned <= 0 {
                return true
            }
            text = "Press Space to spawn a wave!"
            if oInput.Pressed("next_wave") {
                oWaveSpawner.spawn({oEnemy: 1})
                oWaveSpawner.spawn({oEnemy: 0})
                spawned--
            }
            return false
        }
    },
    {
        text: "Check out the shop.\nYou can heal there if your ship is damaged",
        default_gui,
        start: function() {
            oUI.addHintArrow(oShop, "shop", c_yellow)
        },
        step: function() {
        },
        done: function() {
            return false
        }
    },
/*
    {
        gui: function(w, h) {
        },
        default_gui,
        start: function() {
        },
        step: function() {
        },
        done: function() {
        }
    },
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
        var key = keys[j]
        if !struct_has(_step, key) {
            _step[$ key] = function() {}
        }
    }
}

step_index = 4
step = steps[step_index]


