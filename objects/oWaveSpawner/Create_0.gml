var sec = 60
active = true
spawn_timer = MakeTimer(40 * sec, 0)
just_spawned = 0
/*
1. Random waves by wave strength
2. Can insert custom waves
*/
// waves = [
//     {oScout: 1, oEnemy: 1, oEnemyTiny: 1},
// ]
// waves_remains = array_length(waves)
waves = [
    {oScout: 2},
    {oEnemyTiny: 2},
    {oEnemyTiny: 2},
    {oEnemyTiny: 3},
    {oItemDrone: 1},
    {oEnemy: 1},
    {oEnemy: 1},
    {oEnemy: 2},
    {oScout: 2, oEnemyTiny: 2},
    {oEnemy: 1, oScout: 2, oItemDrone: 1},
]
wave_index = 0
var progression = global.balance.progression
waves_remains = progression.total_waves
strength_growth = progression.strength_growth
strength = progression.strength
strength_growth_decrease = progression.strength_growth_decrease_total / waves_remains
strength_cost = progression.strength_cost

enemy_randomer = new ControlledRandomer({
    oEnemy: 3, oScout: 6, oEnemyTiny: 12
}, true)
extra_strength_randomer = new ControlledRandomer([
    [0, 10],// [0.5, 5], [1, 3], [2, 2]
], true)
drone_randomer = new ControlledRandomer({
    in_wave: 1, single:2, none:6
}, true)
wave_strengths = []
for (var i = 0; i < array_length(waves); ++i) {
    wave_strengths[i] = -1
}

for (var i = 0; i < waves_remains; ++i) {
    var wave = {}
    var _strength = strength + extra_strength_randomer.get()
    array_push(wave_strengths, _strength)
    var cost = 1
    var object_name
    switch drone_randomer.get() {
        case "in_wave": wave.oItemDrone = 1; break;
        case "single": wave.oItemDrone = 1; _strength = 0 ; break;
    }
    while true {
        object_name = enemy_randomer.get()
        cost = strength_cost[$ object_name]
        if _strength < cost {
            break
        }
        if !struct_has(wave, object_name) {
            wave[$ object_name] = 1
        } else {
            wave[$ object_name] += 1
        }
        _strength -= cost
    }
    array_push(waves, wave)
    strength *= strength_growth
    strength_growth -= strength_growth_decrease
}

waves_remains = array_length(waves)
global.waves_remains = waves_remains


next_wave_instances = []
spawn_extra_radius = 500
spawn_pos = new Vec2(0, 0)
spawning_inst_speed = spawn_extra_radius / spawn_timer.time

dummy = noone
if instance_exists(oEnemy) {
    dummy = instance_find(oEnemy, 0)
}

spawnSingleInstance = function(obj, make_active=false) {
    var _dir = irandom(360)
    var dist = oGameArea.radius + spawn_extra_radius
    spawn_pos.set_polar(dist, _dir)
    var inst = instance_create_layer(
        spawn_pos.x, spawn_pos.y,
        "Instances", obj
    )
    if !make_active {
        with inst {
            invincible = true
            dir = _dir + 180
            active = false
        }
    }
    return inst
} 

spawn = function(wave_override=undefined) {
   array_foreach(next_wave_instances, 
       function(inst) {
            inst.active = true
            inst.invincible = false
            global.wave_enemies_count++
            var col = global.game_colors.arrow_enemy
            var time = 240
            var text = ""
            if inst.object_index == oItemDrone {
                col = global.game_colors.arrow_drone
                time = infinity
                text = "drone"
            }
            oUI.addHintArrow(inst, text, col, time)
            show_debug_message($"Activated {object_get_name(inst.object_index)}")
       }
   )

    var wave
    if wave_override == undefined {
        waves_remains -= !ArrayEmpty(next_wave_instances)
        global.waves_remains = waves_remains
        ArrayClear(next_wave_instances)
        if waves_remains <= 0 {
            return;
        }
        wave = waves[wave_index]
    } else {
        wave = wave_override
    }

    var names = struct_get_names(wave)
    for (var i = 0; i < array_length(names); i++) {
        var obj_name = names[i]
        var number = wave[$ obj_name]
        var obj = asset_get_index(obj_name)
        repeat number {
            var inst = spawnSingleInstance(obj)
            array_push(next_wave_instances, inst)
            show_debug_message($"Prespawned {object_get_name(inst.object_index)}")
        }
    }
    if wave_override == undefined {
        if wave_index > 0 {
            spawn_timer.reset()
        }
        wave_index++
    }
}
