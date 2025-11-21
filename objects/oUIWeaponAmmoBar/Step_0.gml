
if !instance_exists(oPlayer) {
    exit
}

var wpn = oPlayer.weapon
filled_bars_number = max_num * wpn.ammo / wpn.ammo_max
