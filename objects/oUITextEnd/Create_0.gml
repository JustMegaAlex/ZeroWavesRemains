event_inherited()

text_victory = new Text(0, 0, "Victory!", {font: fntVictory, color: #FFE66B})
text_lost = new Text(0, 0, "Lost!", {font: fntVictory, color: c_red})

set_visible = function() {
    visible = global.gameover or global.win
}
