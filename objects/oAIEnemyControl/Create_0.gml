
EnsureSingleton()

tiny = {
    is_swarm_mode: false,
    swarm_leaders: [],
    swarm_min_count: 6,
    max_swarms: 3,
    swarm_tree: ds_map_create(),
    updateSwarmLeader: function() {
        var tiny_count = instance_number(oEnemyTiny)
        global.tiny_swarm_count = tiny_count
        var swarms_num = min(max_swarms, tiny_count div swarm_min_count)
        repeat swarms_num {
            var inst = instance_create_layer(0, 0, "Instances", oAITinySwarmLeader)
            array_push(swarm_leaders, inst)
        }
        // just in case
        if swarms_num == 0 {
            is_swarm_mode = false
            return;
        }
        var per_swarm_num = floor(tiny_count / swarms_num)
        var _swarm_count = per_swarm_num
        var _swarm_index = 0
        var swarm_leader = swarm_leaders[_swarm_index]
        with oEnemyTiny {
            is_swarm_mode = true
            id.swarm_leader = swarm_leader
            swarm_shift_forward_factor = _swarm_count / per_swarm_num
            swarm_shift_angle = random_range(-45, 45)
            _swarm_count--
            if _swarm_count <= 0 {
                _swarm_count = per_swarm_num
                _swarm_index++
                // if we exceeded swarms num, the rest of tinys will be assinged to
                // the last leader
                if _swarm_index < swarms_num {
                    swarm_leader = other.swarm_leaders[_swarm_index]
                }
            }
        }
    },
    enterSwarmMode: function() {
        if !instance_exists(oEnemyTiny) {
            return
        }
        is_swarm_mode = true
        /// TODO: clean up properly when the last tniy is killed
        ArrayClear(swarm_leaders)
        instance_destroy(oAITinySwarmLeader)
        ///////
        try {
            updateSwarmLeader()
        } catch (e) {
            show_debug_message($"Error in updateSwarmLeader: {e}")
        }
    },
    swarmTinyDeadHook: function() {
        global.tiny_swarm_count -= is_swarm_mode
        if global.tiny_swarm_count == 0 {
            is_swarm_mode = false
            ArrayClear(swarm_leaders)
            instance_destroy(oAITinySwarmLeader)
            return
        }
    }
}

alarm[0] = 1
