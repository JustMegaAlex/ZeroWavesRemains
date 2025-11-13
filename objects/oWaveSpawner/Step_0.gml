
array_foreach(next_wave_instances, 
    function(inst) {
        inst.sp.set_polar(oWaveSpawner.spawning_inst_speed, inst.dir)
    }
)

if !active { exit }

if !spawn_timer.update() {
    spawn()
}


