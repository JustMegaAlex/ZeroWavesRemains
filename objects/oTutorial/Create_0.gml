
#macro default_gui gui: function(w, h) { SetTextAllign(1, 1); draw_text(w*0.5, h*0.15, self.text)}


if global.tutorial_finished {
    oWaveSpawner.spawn()
    exit
}

oWaveSpawner.active = false

drone_sp_first = 6
drone_sp_second = 10



step_template = {
        gui: function(w, h) {
        },
        step: function() {
        },
        done: function() {
            return false
        },
        end_: function() {}
}
spaceToProceed = function(text="Press Space to proceed") {
    return {
        text: text,
        default_gui,
        done: function() {
            return oInput.Pressed("next_wave")
        }
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
        time: 60,
        default_gui,
        text: "Hold Right Mouse or Shift to boost",
        step: function() {
            time -= oInput.Hold("boost")
        },
        done: function() {
            return time < 0
        }
    },
    {
        // define index with search
        arr: [],
        default_gui,
        text: "Destroy 3 dummies",
        start: function() {
            var args = {active: false}
            array_push(arr, instance_create_layer(100, 600, "Instances", oEnemy, args))
            array_push(arr, instance_create_layer(300, -600, "Instances", oEnemy, args))
            array_push(arr, instance_create_layer(1200, 400, "Instances", oEnemy, args))
            with oEnemy {
                setCoins(0, 0)
            }
            for (var i = 0; i < array_length(arr); ++i) {
                var item = arr[i]
                oUI.addHintArrow(item, "enemy", global.game_colors.arrow_enemy)
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
    spaceToProceed("The Pulse weapon restores ammo over time - see your ammo bar?\n(press Space)"),
    // define index with search
    spaceToProceed("This doesn't apply to other weapons you'll get.\n(press Space)"),
    // define index with search
    spaceToProceed("You'll have to find/buy ammo for them\nPress space to proceed"),
    {
        text: "Pause the game with P",
        default_gui,
        done: function() {
            return global.pause
        }
    },
    {
        // define index with search
        text: "Press Space to spawn a wave!",
        spawned: 0,
        total: 3,
        default_gui,
        start: function() {
            global.waves_remains = 3
            oPlayer.display_money = true
        }, 
        done: function() {
            if instance_exists(oScout) {
                text = $"Destroy the wave! ({spawned}/{total})"
                return false
            } else if spawned >= total {
                return true
            }
            text = "Press Space to spawn a wave!"
            if oInput.Pressed("next_wave") {
                oWaveSpawner.spawnSingleInstance(oScout, true)
                with oScout {
                    oUI.addHintArrow(id, "enemy", global.game_colors.arrow_enemy)
                }
                spawned++
            }
            return false
        }
    },
    {
        // define index with search
        text: "Collect all coins! We'll need them in a moment",
        default_gui,
        step: function() {
            if !ArrayEmpty(oUI.hint_arrows) {
                return;
            }
            with oCollectCoin {
                other.arrow = oUI.addHintArrow(id, "coins", global.game_colors.arrow_common)
                return;
            }
        },
        done: function() {
            return !instance_exists(oCollectCoin)
        }
    },
    // define index with search
    spaceToProceed(),
    {
        // define index with search
        text: "Valuable drop in bound!\nKill the drone!",
        drone: noone,
        finished: false,
        default_gui,
        spawn_heal_count: 3,
        start: function() {
            drone = instance_create_layer(0, 0, "Instances", oItemDrone)
            drone.updateSpMax(oTutorial.drone_sp_first)
            oUI.addHintArrow(drone, "drone", global.game_colors.arrow_drone)
        },
        step: function() {
            if !instance_exists(drone) {
                if !instance_exists(oCollectible) {
                    drone = instance_create_layer(0, 0, "Instances", oItemDrone)
                    oUI.addHintArrow(drone, "drone", global.game_colors.arrow_drone)
                } else {
                    /// Spawn 3 hp if not spawned
                    var hp_spawned = instance_number(oCollectHp)
                    repeat spawn_heal_count - hp_spawned {
                        instance_create_layer(oCollectible.x, oCollectible.y, "Instances", oCollectHp)
                    }
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
        text: "Good job! Collect the loot",
        default_gui,
        spawn_heal_count: 3,
        start: function() {
        },
        done: function() {
            return !instance_exists(oCollectible) or (!instance_exists(oCollectCoin) and oPlayer.hp == oPlayer.hp_max)
        }
    },
    // define index with search
    spaceToProceed(),
    {
        // define index with search
        text: "Check out the shop",
        come_back_text: "",
        default_gui,
        arrow: noone,
        start: function() {
            arrow = oUI.addHintArrow(oShop, "shop", global.game_colors.arrow_common)
            oPlayer.display_money = true
            come_back_text = text
        },
        step: function() {
            if oShop.is_open {
                text = "Upgrade your weapon"
                come_back_text = "Come back to the shop"
            } else {
                text = come_back_text
            }
        },
        end_: function() {
            oUI.removeHintArrow(arrow)
        },
        done: function() {
            /// any upgrade was made
            with oShopItemWeaponUpgrade {
                if upgrade_level >= 0 {
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
    var arr = [oShopItemWeapon, oShopItemWeaponUpgrade]
    with oShopItem {
        if (array_contains(arr, object_index))
                and (weapon == oPlayer.weapon_pulse) {
            continue
        }
        deactivate()
    }
    with oShopItemLink {
        visible = parent.visible
    }
    step.start()
}
finishTutorial = function() {
    // global.tutorial_finished = true
    global.tutorial = false
    global.wave_enemies_count = 0
    step = step_template
    with oPlayer {
        display_waves = true
        display_money = true
    }
    instance_destroy(oEnemyParent)
    instance_destroy(oCollectCoin)
    instance_destroy(oItemDrop)
    instance_destroy(oItemDropChoice)
    /// ensure to unlock pulse     
    with oShopItem {
        activate()
    }
    with oShopItemLink {
        visible = true
    }
    instance_destroy(oWaveSpawner)
    instance_create_layer(0, 0, "Instances", oWaveSpawner)
    oWaveSpawner.spawn()
}

step_index = 0
step = steps[step_index]
alarm[0] = 1
global.tutorial = true

if DEV {
    step_index = 15
    step = steps[step_index]
}

skip_tutorial = {
    ratio: 0.01,
    x: 0.5,
    y: 0.05,
    text: "Tutorial\n(hold T to skip the whole tutorial)",
    value: 0,
    bar_len: 500,
    bar_col: c_white,
}
