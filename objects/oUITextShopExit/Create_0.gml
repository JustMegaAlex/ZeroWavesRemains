event_inherited()

text = new Text(0, 0, "Use MOUSE to interact\nPress F to quit", {font: fntUI, halign: 1, valign: 1})

set_visible = function() {
    no_player_return
    visible = oPlayer.hub_interaction.attached and !global.pause
}
