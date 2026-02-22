event_inherited()

no_player_exit

if oPlayer.shop_item {
    if oPlayer.shop_item.is_unlocked {
        text = oPlayer.shop_item.costText()
    } else {
        text = text_tech_locked
    }
}
