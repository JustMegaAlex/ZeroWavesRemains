
if is_generating {
    oWaveSpawner.spawn()
    var res = {}
    with oEnemyParent {
        if !active { continue }
        var name = object_get_name(object_index)
        if !struct_has(res, name) {
            res[$ name] = 0
        }
        res[$ name] += 1
        die()
    }
    res.coins = instance_number(oCoin)
    instance_destroy(oCoin)
    if res.coins > 0 {
        array_push(test_results, res)
    }
    if oWaveSpawner.waves_remains <= 0 {
        is_generating = false
    }
} else if key_pressed(vk_space) {
    is_generating = true
    with oWaveSpawner {
        event_perform(ev_create, 0)
    }
    test_results = []
}
