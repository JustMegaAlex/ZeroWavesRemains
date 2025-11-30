
size_to = is_open ? open_size : close_size
size = Approach(size, size_to, open_sp)

if !instance_exists(oPlayer) { exit }
if is_open and (InstDist(oPlayer) > (open_size * 2.5)) {
    is_open = false
}

open_ratio = (size - close_size) / (open_size - close_size)
