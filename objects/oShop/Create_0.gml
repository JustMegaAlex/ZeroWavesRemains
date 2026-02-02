
SetColor()

is_open = false

open_size = abs(y)
open_sp = 0.05 * (open_size - sprite_height*.5)
open_ratio = 0
close_size = sprite_height*0.5
size = close_size
y = 0
highlight = false

open = function() {
    is_open = true
}

close = function() {
    is_open = false
}

sprite_index_norm = sTechHubNM

drawSegment = function(angle, dx, dy, scale) {
    draw_sprite_ext(
        sprite_index, 0,
        (size*lengthdir_x(1, angle+90) + dx) * scale,
        (size*lengthdir_y(1, angle+90) + dy) * scale,
        scale, scale,
        angle, image_blend, 1)
}
drawSegmentNM = function(angle, dx, dy, scale) {
    draw_sprite_ext(
        sprite_index_norm, 0,
        (size*lengthdir_x(1, angle+90) + dx) * scale,
        (size*lengthdir_y(1, angle+90) + dy) * scale,
        scale, scale,
        angle, c_white, 1)
}