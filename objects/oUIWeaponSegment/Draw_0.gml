
draw_self()
draw_sprite(
    weapon_icons[index], 0, x, y
)

for (var i = 0; i < array_length(checkbox_alphas); ++i) {
    var alpha = checkbox_alphas[i]
    draw_set_alpha(alpha)
    draw_sprite(sprite_index, i+1, x, y)
    draw_set_alpha(1)
}
