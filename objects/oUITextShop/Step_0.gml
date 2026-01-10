event_inherited()

no_player_exit

if oPlayer.interactible {
    text = oPlayer.interactible.promptText()
} else if !oShop.is_open and oShop.highlight {
    text = "Press F to open"
}
