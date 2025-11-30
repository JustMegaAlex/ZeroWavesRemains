
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
