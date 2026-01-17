event_inherited()
sfx = sfxCoin2

onCollect = function() {
   oPlayer.money++
   with oUICoins { animate() }
}

image_rotation = random_range(-5, 5)
