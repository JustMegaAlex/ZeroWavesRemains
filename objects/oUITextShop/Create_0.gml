event_inherited()

shop_text = new Text(0, 0, "Press F to open", {font: fntUI, halign: 1, valign: 1})

set_visible = function() {
    no_player_return
    visible = ((oPlayer.interactible != noone) or (oShop.highlight))
                and !global.pause
}
