event_inherited()
onCollect = function() {
   oPlayer.heal(5)
}
updateCollectEnabled = function() {
    collect_enabled = oPlayer.hp < oPlayer.hp_max
}
