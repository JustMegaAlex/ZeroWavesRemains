
EnsureSingleton()

tiny = {
    is_swarm_mode: false,
    swarm_leader: noone,
    swarm_tree: ds_map_create(),
    updateSwarmLeader: function() {
        if !instance_exists(swarm_leader) {
            swarm_leader = instance_create_layer(0, 0, "Instances", oAITinySwarmLeader)
        }
        var num = instance_number(oEnemyTiny)
        var count = 0
        with oEnemyTiny {
            is_swarm_mode = true
            swarm_leader = other.swarm_leader
            swarm_shift_forward_factor = count / num
            swarm_shift_angle = random_range(-45, 45)
            count++
        }
    },
    enterSwarmMode: function() {
        if !instance_exists(oEnemyTiny) {
            return
        }
        is_swarm_mode = true
        updateSwarmLeader()
    },
    swarmTinyDeadHook: function() {
        if !instance_exists(oEnemyTiny) {
            is_swarm_mode = false
            instance_destroy(swarm_leader)
            return
        }
        // updateSwarmLeader()
    }
}

alarm[0] = 1
