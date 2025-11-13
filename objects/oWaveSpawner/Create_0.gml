var sec = 60
active = true
spawn_timer = MakeTimer(40 * sec, 0)
waves_count = [4, 5, 6, 7, 8]
wave_index = 0
next_wave_instances = []
spawn_extra_radius = 500
spawn_pos = new Vec2(0, 0)
spawning_inst_speed = spawn_extra_radius / spawn_timer.time

spawn = function() {
    var dist = oGameArea.radius + spawn_extra_radius * (wave_index > 0)
    
   array_foreach(next_wave_instances, 
       function(inst) {
           inst.active = true
       }
   )
    ArrayClear(next_wave_instances)
    repeat waves_count[wave_index] {
        var _dir = irandom(360)
        spawn_pos.set_polar(dist, _dir)
        var inst = instance_create_layer(
            spawn_pos.x, spawn_pos.y,
            "Instances", oEnemy
        )
        with inst {
            dir = _dir + 180
            active = false
        }
        array_push(next_wave_instances, inst)
    }
    if wave_index > 0 {
        spawn_timer.reset()
    }
    wave_index++
    if wave_index > array_length(waves_count) {
        active = false
    }
}
