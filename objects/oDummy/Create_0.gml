
event_inherited()

battle_side = battle_side_enemy

image_blend = c_lime

hp = 200

die = function() {
    oParticles.explosion_2(x, y, max(sprite_width, sprite_height)*0.5)
    audio_play_sound(sfxExplosion1, 2, false)
    if instance_exists(oCamera) {
        oCamera.shake()
    }
    instance_destroy()
}
