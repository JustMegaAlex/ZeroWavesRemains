event_inherited()


/// Spawn tech unlockable if it's the last enemy
if global.wave_enemies_count == 0
        and instance_exists(oWaveSpawner)
        and oWaveSpawner.wave_unlock_tech != undefined {
    /// spawn tech
    instance_create_layer(x, y, layer, oItemDropChoice, {
        item: global.item_coins
    })
    oWaveSpawner.wave_unlock_tech = undefined
}
