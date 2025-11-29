var sec = 60
active = true
spawn_timer = MakeTimer(40 * sec, 0)
just_spawned = 0
waves = [
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    // {oEnemy: 1, oEnemyTiny: 0},
    {oScout: 1},

    {oEnemy: 1, oEnemyTiny: 0},
    {oEnemy: 2, oEnemyTiny: 0},
    {oEnemy: 2, oEnemyTiny: 0},
    {oEnemy: 2, oEnemyTiny: 0},
    {oEnemy: 3, oEnemyTiny: 0},
    {oEnemy: 0, oEnemyTiny: 2},
    {oEnemy: 0, oEnemyTiny: 3},
    {oEnemy: 0, oEnemyTiny: 3},
    {oEnemy: 0, oEnemyTiny: 3},
    {oEnemy: 1, oEnemyTiny: 3},
    {oEnemy: 2, oEnemyTiny: 3},
    {oEnemy: 4, oEnemyTiny: 0},
    {oEnemy: 4, oEnemyTiny: 0},
    {oEnemy: 6, oEnemyTiny: 0},
    {oEnemy: 1, oEnemyTiny: 7},
    {oEnemy: 1, oEnemyTiny: 8},
    {oEnemy: 1, oEnemyTiny: 8},
    {oEnemy: 3, oEnemyTiny: 8},
    {oEnemy: 3, oEnemyTiny: 8},
    {oEnemy: 4, oEnemyTiny: 8},
    {oEnemy: 8, oEnemyTiny: 0},
    {oEnemy: 6, oEnemyTiny: 8},
    {oEnemy: 6, oEnemyTiny: 8},
    {oEnemy: 8, oEnemyTiny: 10},
    //{oEnemy: 1, oEnemyTiny: 0},
]
waves_remains = array_length(waves)
wave_index = 0
next_wave_instances = []
spawn_extra_radius = 500
spawn_pos = new Vec2(0, 0)
spawning_inst_speed = spawn_extra_radius / spawn_timer.time

dummy = noone
if instance_exists(oEnemy) {
    dummy = instance_find(oEnemy, 0)
}

spawn = function(wave_override=undefined) {
   array_foreach(next_wave_instances, 
       function(inst) {
            inst.active = true
            inst.invincible = false
            global.wave_enemies_count++
       }
   )
    ArrayClear(next_wave_instances)
    if !active and wave_override==undefined { return }
    var dist = oGameArea.radius + spawn_extra_radius * (wave_index > 0)

    var wave
    if wave_override == undefined {
        wave = waves[wave_index]
        waves_remains--
        global.waves_remains = waves_remains
    } else {
        wave = wave_override
    }
    var names = struct_get_names(wave)
    for (var i = 0; i < array_length(names); i++) {
        var obj_name = names[i]
        var number = wave[$ obj_name]
        var obj = asset_get_index(obj_name)
        repeat number {
            var _dir = irandom(360)
            spawn_pos.set_polar(dist, _dir)
            var inst = instance_create_layer(
                spawn_pos.x, spawn_pos.y,
                "Instances", obj
            )
            with inst {
                invincible = true
                dir = _dir + 180
                active = false
            }
            array_push(next_wave_instances, inst)
        }
    }
    if wave_override == undefined {
        if wave_index > 0 {
            spawn_timer.reset()
        }
        wave_index++
        if wave_index >= array_length(waves) {
            active = false
        }
    }
}
