
#macro default_gui gui: function(w, h) { SetTextAllign(1, 1); draw_text(w*0.5, h*0.3, self.text)}

oWaveSpawner.active = false

global.tutorial = true

finishTutorial = function() {
    global.tutorial_finished = true
    oWaveSpawner.active = true
    global.tutorial = false
    with oPlayer {
        display_waves = false
        display_money = false
    }
}

step_template = {
        gui: function(w, h) {
        },
        step: function() {
        },
        done: function() {
            return false
        }
}
step_press_space_to_proceed = {
    text: "Press Space to proceed",
    done: function() {
        return oInput.Pressed("next_wave")
    }
}
steps = [
    {
        // define index with search
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
        // define index with search
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
        // define index with search
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
        // define index with search
        arr: [],
        default_gui,
        text: "Destroy 3 dummies",
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
    // define index with search
    step_press_space_to_proceed,
    {
        // define index with search
        text: "Press Space to spawn a wave!",
        spawned: 3,
        default_gui,
        start: function() {
            global.waves_remains = 3
            oPlayer.display_waves = true
        }, 
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
                with oEnemy {
                    oUI.addHintArrow(id, "enemy", c_red)
                }
                spawned--
            }
            return false
        }
    },
    // define index with search
    step_press_space_to_proceed,
    {
        // define index with search
        text: "Valuable drop in bound!\nKill the drone!",
        drone: noone,
        finished: false,
        default_gui,
        start: function() {
            drone = instance_create_layer(0, 0, "Instances", oItemDrone)
            oUI.addHintArrow(drone, "drone", c_red)
        },
        step: function() {
            if !instance_exists(drone) {
                if !instance_exists(oItemDrop) {
                    drone = instance_create_layer(0, 0, "Instances", oItemDrone)
                } else {
                    finished = true
                }
            }
        },
        done: function() {
            return finished
        }
    },
    {
        // define index with search
        text: "Good job! Grab some healing if you need",
        default_gui,
        start: function() {
            with oItemDropChoice {
                setItem(global.item_heal)
            }
            with oItemDrop {
                oUI.addHintArrow(id, "collect item to heal", c_green)
            }
        },
        done: function() {
            return !instance_exists(oItemDropChoice)
        }
    },
    // define index with search
    step_press_space_to_proceed,
    {
        // define index with search
        text: "Another drop!\nLet's try something more spicy this time",
        drone: noone,
        finished: false,
        default_gui,
        start: function() {
            drone = instance_create_layer(0, 0, "Instances", oItemDrone)
            oUI.addHintArrow(drone, "drone", c_red)
        },
        step: function() {
            if !instance_exists(drone) {
                if !instance_exists(oItemDrop) {
                    drone = instance_create_layer(0, 0, "Instances", oItemDrone)
                } else {
                    finished = true
                }
            }
        },
        done: function() {
            return finished
        }
    },
    {
        // define index with search
        text: "Nice! Collect the drop",
        default_gui,
        start: function() {
            var item = noone
            with oShopItemWeaponUpgrade {
                if weapon.name == "Pulse" {
                    item = id
                    break
                }
            }
            if item == noone {
                throw "Ooops, tutorial didn't find that pulse upgrade item"
            }
            with oItemDropChoice {
                setItem(item)
            }
            with oItemDrop {
                oUI.addHintArrow(id, "collect the shop upgrade", c_green)
            }
        },
        done: function() {
            return !instance_exists(oItemDropChoice)
        }
    },
    {
        // define index with search
        text: "Check out the shop",
        default_gui,
        arrow: noone,
        start: function() {
            arrow = oUI.addHintArrow(oShop, "shop", c_yellow)
        },
        step: function() {
            if oShop.is_open {
                text = "Upgrade your weapon"
            } else {
                text = "Come back to the shop"
            }
        },
        end_: function() {
            oUI.removeHintArrow(arrow)
        },
        done: function() {
            /// any upgrade was made
            with oShopItemWeaponUpgrade {
                if weapon.upgrades > 0 {
                    return true
                }
            }
            return false
        }
    },
    {
        // define index with search
        text: "Great!\nPress Space to finish this tutorial",
        gui: function(w, h) {
        },
        default_gui,
        start: function() {
        },
        step: function() {
        },
        done: function() {
            return oInput.Pressed("next_wave")
        }
    },
/*
    {
        // define index with search
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
    "end_",
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

startTutorial = function() {
    with oPlayer {
        display_waves = false
        display_money = false
    }
    step.start()
}

step_index = 5
step = steps[step_index]
if !global.tutorial_finished {
    alarm[0] = 1
}
