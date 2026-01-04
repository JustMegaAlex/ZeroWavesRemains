
EnsureSingleton()

tiny = {
    is_swarm_mode: false,
    swarm_leader: noone,
    updateSwarmLeader: function() {
        swarm_leader = noone
        with oEnemyTiny {
            is_swarm_mode = true
            if !other.swarm_leader and !is_dead {
                other.swarm_leader = id
            }
            swarm_leader = other.swarm_leader
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

