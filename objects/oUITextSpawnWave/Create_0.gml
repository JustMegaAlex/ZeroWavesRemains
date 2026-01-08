event_inherited()

text = new Text(0, 0, "Press Space for the next wave!", {halign: 1, valigh: 1})

set_visible = function() {
    visible = !oPlayer.shop_item
                and oWaveSpawner.active 
                and (global.wave_enemies_count <= 0)
                and !global.tutorial
                and !global.win
}
