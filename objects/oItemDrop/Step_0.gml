
for (var i = 0; i < array_length(items); ++i) {
    var item = items[i]
    item_placement_vec.set(x, y).add_polar(item_pos_radius, 90 + i * 120)
    item.x = item_placement_vec.x
    item.y = item_placement_vec.y
}
