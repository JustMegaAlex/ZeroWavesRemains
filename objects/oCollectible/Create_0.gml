
collect_enabled = true

magnet_dist = 500
sp_max = 32
acc = 1
rot_sp = 12
sfx = noone

speed = sp_max * random_range(.5, 1)
direction = irandom(360)

onCollectBase = function() {
    onCollect()
    if sfx != noone {
        audio_play_sound(sfx, 3, false)
    }
}

onCollect = function() {
   
}

updateCollectEnabled = function() {
    
}

SetColor()
