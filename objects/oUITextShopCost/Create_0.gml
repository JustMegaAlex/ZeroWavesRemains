event_inherited()

text_tech_locked = new Text(0, 0, "Yet to unlock", {color: c_grey, halign: 1})

set_visible = function() {
    no_player_return
    visible = oPlayer.shop_item != noone
}
