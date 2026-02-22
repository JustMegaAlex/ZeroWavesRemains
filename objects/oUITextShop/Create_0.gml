event_inherited()

shop_text = new Text(0, 0, "Press F to enter Tech hub", {font: fntUI, halign: 1, valign: 1})
shop_na_text = new Text(0, 0, "Not available yet", {font: fntUI, halign: 1, valign: 1})
text_tech_locked = new Text(0, 0, "Yet to unlock", {color: c_grey, halign: 1})


set_visible = function() {
    no_player_return
    if oPlayer.shop_item and !oPlayer.shop_item.is_unlocked {
        visible = false
        return;
    }
    visible = ((oPlayer.interactible != noone) or (oShop.highlight))
                and !global.pause
}
