macro_pause

array_foreach(next_wave_instances, updateSpawningInstance)
just_spawned = false

if !active { exit }
spawn_current_radius -= spawning_inst_speed

//if !spawn_timer.update() {
    //spawn()
//}


