
EnsureSingleton()

tiny = {
    is_swarm_mode: false,
    swarm_leader: noone,
    swarm_tree: ds_map_create(),
    updateSwarmLeader: function() {
        swarm_leader = noone
        var 
        with oEnemyTiny {
            is_swarm_mode = true
            if !other.swarm_leader and !is_dead {
                other.swarm_leader = id
            }
            swarm_leader = other.swarm_leader
        }
        return;

        with oEnemyTiny {
            is_swarm_mode = true
        }
        swarm_leader = instance_find(oEnemyTiny, 0)
        swarm_leader.swarm_leader = swarm_leader
        var num = instance_number(oEnemyTiny)
        var line_last_followers = []
        var lines = 3
        for (var i = 1; i < (lines+1); ++i) {
            var inst = instance_find(oEnemyTiny, i)
            if inst == noone {
               test =true
            }
            inst.swarm_leader = swarm_leader
            array_push(line_last_followers, inst)
        }
        for (var i = (lines+1); i < num; ++i) {
            var inst = instance_find(oEnemyTiny, i)
            if inst == noone {
               test =true
            }
            inst.swarm_leader = line_last_followers[i % lines]
            line_last_followers[i % lines] = inst
        }
    },
    enterSwarmMode: function() {
        if !instance_exists(oEnemyTiny) {
            return
        }
        is_swarm_mode = true
        updateSwarmLeader()
    },
    swarmLeaderDeadHook: function() {
        if !instance_exists(oEnemyTiny) {
            is_swarm_mode = false
            return
        }
        updateSwarmLeader()
    }
}

alarm[0] = 1

