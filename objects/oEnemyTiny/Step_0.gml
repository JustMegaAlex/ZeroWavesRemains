// Inherit the parent event
event_inherited();

var scatter = instance_place(x, y, oBulletScatter)
if scatter {
    hit(scatter.dmg)
    scatter.fading = true
    scatter.fading_hurt_frames = 0
}
