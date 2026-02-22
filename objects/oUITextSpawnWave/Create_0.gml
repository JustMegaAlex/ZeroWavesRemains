event_inherited()

text = new Text(0, 0, "Press Space for the next wave!", {font: fntUI})

set_visible = function() {
    visible = !(oPlayer.interactible
                    or oShop.highlight
                    or oShop.is_open)
                and oWaveSpawner.active 
                and (global.wave_enemies_count <= 0)
                and !global.pause
                and !global.tutorial
                and !global.win
}
