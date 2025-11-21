
if instance_exists(oPlayer) {
    index = oPlayer.weapon_index
    var weapons = oPlayer.weapons_array
    for (var i = 0; i < array_length(weapons); ++i) {
        checkbox_alphas[i] = 0
        if index == i {
            checkbox_alphas[i] = 1
        } else if weapons[i] != noone {
            checkbox_alphas[i] = 0.5
        }
    }
}
