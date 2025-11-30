macro_pause

array_foreach(next_wave_instances, 
    function(inst) {
        if inst == undefined { return }
        var mult = 1 + 3 * (global.wave_enemies_count == 0) * global.increase_spawning_speed_between_waves
        inst.dir = point_direction(inst.x, inst.y, 0, 0)
        inst.sp.set_polar(oWaveSpawner.spawning_inst_speed*mult, inst.dir)
        var dist = point_distance(inst.x, inst.y, 0, 0)
        if !oWaveSpawner.just_spawned and point_distance(inst.x, inst.y, 0, 0) <= oGameArea.radius {
            oWaveSpawner.spawn()
            oWaveSpawner.just_spawned = true
        }
    }
)
just_spawned = false

if !active { exit }
//
//if !spawn_timer.update() {
    //spawn()
//}


