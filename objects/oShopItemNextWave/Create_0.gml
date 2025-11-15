event_inherited()


can_buy = function() {
    return global.wave_enemies_count <= 0
}


apply = function() {
    oWaveSpawner.spawn()
}
