event_inherited()

text = "Press Space for the next wave!"

set_visible = function() {
    visible = !oPlayer.shop_item and oWaveSpawner.active and (global.wave_enemies_count <= 0)
}
