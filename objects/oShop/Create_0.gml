
SetColor()

is_open = false

open_size = abs(y) + sprite_height * 0.5
open_sp = 0.05 * (open_size - sprite_height*.5)
close_size = sprite_height*0.5
size = close_size
y = 0

open = function() {
    is_open = !is_open
}

