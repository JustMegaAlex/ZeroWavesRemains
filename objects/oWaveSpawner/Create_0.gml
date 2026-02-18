
tiny_min_swarm_count = 6
next_wave_trigger_swarm_mode = false

var sec = 60
active = true
spawn_timer = MakeTimer(40 * sec, 0)    // not used for now
just_spawned = 0
helper_vec = new Vec2(0, 0)


time_between_waves = 60 * 40 // __diff(40, 40, 40)
spawn_current_radius = 0
spawn_extra_radius = 500
spawn_pos = new Vec2(0, 0)
spawning_inst_speed = spawn_extra_radius / time_between_waves

drones_spawned = 0
drones_to_spawn_total = 0

/*
1. Random waves by wave strength
2. Can insert custom waves
*/
// waves = [
//     {oScout: 1, oEnemy: 1, oEnemyTiny: 1},
// ]
// waves_remains = array_length(waves)



mergeSpawnStruct = function(into, from) {
    if from[$ "replace"] ?? false {
        StructClear(into)
        struct_remove(from, "replace")
    }
    var keys = variable_struct_get_names(from)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        var value = from[$ key]
        if struct_has(into, key) {
            into[$ key] += value
        } else {
            into[$ key] = value
        }
    }
}


/// @follow-up wave spawner initial waves
waves = [
    // {oScout: 2},
    // {oEnemyTiny: 2},
    // {oEnemyTiny: 2},
    // {oEnemyTiny: 3},
    // {oItemDrone: 1},
    // {oEnemy: 1},
    // {oEnemy: 1},
    // {oEnemy: 2},
    // {oScout: 2, oEnemyTiny: 2},
    // {oEnemy: 1, oScout: 2, oItemDrone: 1},
]
wave_index = 0
var progression = global.balance.progression
strength_growth = progression.strength_growth
strength = progression.strength
leftover_strength = 0
strength_growth_decrease = progression.strength_growth_decrease_total / progression.total_waves
strength_cost = progression.strength_cost

enemy_randomer_0 = new ControlledRandomer({
    oEnemy: 3, oScout: 6, oEnemyTiny: 12
}, true)
var mult = 2
enemy_randomer_1 = new ControlledRandomer({
    oEnemy: 3*mult, oScout: 5*mult, oEnemyTiny: 1*mult, oEnemyFighter: 2*mult, oEnemyMosquito: 2*mult, swarm: 1
}, true)
enemy_randomer_2 = new ControlledRandomer({
    oEnemy: 2*mult, oScout: 4*mult, oEnemyTiny: 9*mult, oEnemyFighter: 3*mult, oEnemyMosquito: 3*mult, swarm: 1
}, true)
enemy_randomer = enemy_randomer_0

extra_strength_randomer = new ControlledRandomer([
    [0, 10],// [0.5, 5], [1, 3], [2, 2]
], true)

/// @follow-up drone waves
drone_randomer = new ControlledRandomer({
    in_wave: 2, single:1, none:3
}, true)
wave_strengths = []
for (var i = 0; i < array_length(waves); ++i) {
    wave_strengths[i] = -1
}
var _prev_single_drone = false
for (var i = 0; i < progression.total_waves; ++i) {
    var wave = {}
    var _strength = strength + extra_strength_randomer.get() + leftover_strength
    var path_pos = i / progression.total_waves
    _strength = path_get_y(pthDifficulty, path_pos) + leftover_strength
    var initial_strength = _strength
    array_push(wave_strengths, _strength)
    var cost = 1
    if i == 20 {
        drone_randomer = new ControlledRandomer({
            in_wave: 2, none:2
        }, true)
    }
    var object_name
    switch drone_randomer.get() {
        case "in_wave": wave.oItemDrone = 1; break;
        case "single":
            wave.oItemDrone = 1;
            if _prev_single_drone {
                _prev_single_drone = false
                break
            }
            _prev_single_drone = true
            _strength = 0;
        break;
    }
    if wave[$ "oItemDrone"] != undefined {
        drones_to_spawn_total++
    }

    if i > 9 {
        enemy_randomer = enemy_randomer_1
    }
    if i > 19 {
        enemy_randomer = enemy_randomer_2
    }

    while true {
        object_name = enemy_randomer.get()
        if object_name = "swarm" {
            var count = floor(initial_strength / strength_cost.oEnemyTiny)
            wave = {oEnemyTiny: count}
            leftover_strength = initial_strength - strength_cost.oEnemyTiny * count
            break
        }
        cost = strength_cost[$ object_name]
        if _strength < cost {
            // go on until at least one unit in wave
            if struct_names_count(wave) == 0 {
                continue
            }
            leftover_strength = _strength
            enemy_randomer.shift(object_name)
            break
        }
        var _add_enemy = {}
        _add_enemy[$ object_name] = 1
        mergeSpawnStruct(wave, _add_enemy)
        _strength -= cost
    }
    array_push(waves, wave)
    // strength *= strength_growth
    // strength_growth -= strength_growth_decrease
}


///// @follow-up custom waves
// var num = choose(0, 1)
// array_insert(waves, 7, {oEnemyFighter: num, oEnemyMosquito: 1 - num})

// ///// @follow-up Behemoth waves
// array_insert(waves, 12, {oEnemyBehemoth: 1, oEnemyTiny: __diff(0, 6, 9), oEnemy: __diff(0, 0, 3)})
// array_push(waves, {oEnemyBehemoth: 1, oEnemy: __diff(2, 3, 5), oEnemyTiny: __diff(6, 10, 20), oScout: __diff(0, 3, 6)})
// ///// @follow-up Swarm waves
// array_insert(waves, irandom_range(8, 12), {oEnemyTiny: __diff(8, 10, 12), swarm: true})
// array_insert(waves, irandom_range(13, array_length(waves)-1), {oEnemyTiny: __diff(15, 20, 30), swarm: true})

// waves = [{oEnemyTiny: 1}, {oEnemyTiny: 1}]

waves_remains = array_length(waves)
global.waves_remains = waves_remains
next_wave_instances = []


dummy = noone
if instance_exists(oEnemy) {
    dummy = instance_find(oEnemy, 0)
}

spawnSingleInstance = function(obj, make_active=false) {
    var _dir = irandom(360)
    spawn_current_radius = oGameArea.radius + spawn_extra_radius
    spawn_pos.set_polar(spawn_current_radius, _dir)
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

    if inst.object_index == oItemDrone {
        drones_spawned++
        droneSetCoinsIncline(inst)
    }
    return inst
} 

droneSetCoinsIncline = function(inst) {
    var wave_mult = (drones_spawned/drones_to_spawn_total * 2 - 1) // -1 .. 1 
    var mult = 1 + global.balance.coins.__drone_incline * wave_mult // (1 - incl) .. (1 + incl)
    if mult <= 0 {
        throw $"Bad drone coins incline: {mult}"
    }
    inst.loot_multiplier = mult
}

spawn = function(wave_override=undefined) {
    with oUIWaves {
        animate()
    }
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
    
    //// Tech drops
    // 1. Inject spawn units to the next wave
    var extra_spawn = {}
    if !ArrayEmpty(unlockable_tech_config) and (wave_index + 1) == unlockable_tech_config[0].wave {
        var _conf = unlockable_tech_config[0]
        extra_spawn = _conf.extra_spawn
    }
    // 2. Set drop in current wave (when injected units become active)
    if !ArrayEmpty(unlockable_tech_config) and wave_index == unlockable_tech_config[0].wave {
        var _conf = array_shift(unlockable_tech_config)
        var _tier = _conf.tier
        wave_unlock_tech = oGameState.getUnlockableByTier(_tier)
    }

    /// Apply AI mode
    if next_wave_trigger_swarm_mode or (Chance(0.5) and (instance_number(oEnemyTiny) > tiny_min_swarm_count)) {
        oAIEnemyControl.tiny.enterSwarmMode()
        show_debug_message("Swarm mode triggered")
    }
    
    if ArrayEmpty(next_wave_instances) and wave_index != 0 {
        test = true
    }

    var wave
    if wave_override == undefined {
        var waves_remains_prev = waves_remains
        waves_remains -= !ArrayEmpty(next_wave_instances)
        if waves_remains == waves_remains_prev {
            test = true
        }
        global.waves_remains = waves_remains
        ArrayClear(next_wave_instances)
        if waves_remains <= 0 {
            lastWaveCallback()
            return;
        }
        wave = waves[wave_index]
    } else {
        wave = wave_override
    }

    if struct_has(wave, "swarm") {
        next_wave_trigger_swarm_mode = wave.swarm
        struct_del(wave, "swarm")
    }

    mergeSpawnStruct(wave, extra_spawn)
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
    if ArrayEmpty(next_wave_instances) {
        var test = true
    }
    if wave_override == undefined {
        if wave_index > 0 {
            spawn_timer.reset()
        }
        wave_index++
    }
}

updateSpawningInstance = function(inst) {
    if inst == undefined { return }
    var mult = 1 + 3 * (global.wave_enemies_count == 0) * global.increase_spawning_speed_between_waves
    inst.dir = point_direction(inst.x, inst.y, 0, 0)
    inst.sp.set(0, 0)
    helper_vec.set_polar(spawn_current_radius, inst.dir + 180)
    inst.x = helper_vec.x
    inst.y = helper_vec.y
    if !oWaveSpawner.just_spawned and (spawn_current_radius < oGameArea.radius) {
        show_debug_message($"Activating by distance")
        oWaveSpawner.spawn()
        oWaveSpawner.just_spawned = true
    }
}

getSpawnCycleProgress = function() {
    return 1 - (spawn_current_radius - oGameArea.radius) / spawn_extra_radius
}

nextWaveIsLast = function() {
    return waves_remains == 1
}

lastWaveCallback = function() {
    oMusic.switch_music(mscFinalBattle)
}

/// @follow-up wave spawner DEV
if DEV {
    // wave_index = 13
    // waves_remains = array_length(waves) - wave_index
}

var _extra_enemy = choose("oEnemyFighter", "oEnemyMosquito")
var _first_extra_spawn = {replace: true}
_first_extra_spawn[$ _extra_enemy] = 1

var count = 0
var _second_extra_spawn = {oEnemyBehemoth: 1, replace: true}
_extra_enemy = choose(["oEnemyTiny", 5], ["oEnemy", 2])
_second_extra_spawn[$ _extra_enemy[0]] = _extra_enemy[1]
unlockable_tech_config = [
    {wave: 10, tier: 0, extra_spawn: _first_extra_spawn},
    {wave: 20, tier: 1, extra_spawn: _second_extra_spawn},
    {wave: 30, tier: 2, extra_spawn: {oEnemyBehemoth: 1}},
    {wave: 45, tier: 2, extra_spawn: {oEnemyBehemoth: 3}},
]

wave_unlock_tech = undefined
