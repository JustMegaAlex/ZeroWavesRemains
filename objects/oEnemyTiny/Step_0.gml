// Inherit the parent event
event_inherited();

var scatter = instance_place(x, y, oBulletScatter)
if scatter and !(scatter.fading and !scatter.fading_hurt_frames) {
    hit(scatter)
    scatter.fading = true
    scatter.fading_hurt_frames = 0
}
