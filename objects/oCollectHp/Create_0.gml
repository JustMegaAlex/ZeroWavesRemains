event_inherited()

no_player_destroy_exit


onCollect = function() {
   oPlayer.heal(5)
}
updateCollectEnabled = function() {
    collect_enabled = oPlayer.hp < oPlayer.hp_max
}
