
for (var i = 0; i < array_length(items); ++i) {
    var item = items[i]
    item_placement_vec.set(x, y).add_polar(item_pos_radius, 90 + i * 120)
    item.x = item_placement_vec.x
    item.y = item_placement_vec.y
}

part_system_position(ps, x, y)

var dist = InstDist(oShop)
if dist < push_from_shop_dist {
    move_vec.set_polar(move_sp * (1 - dist / push_from_shop_dist), InstDir(oShop, id))
    x += move_vec.x
    y += move_vec.y
    exit
}
dist = PointDist(0, 0) - (oGameArea.radius*0.9)
if dist > 0 {
    move_vec.set_polar(move_sp * dist / 300, PointDir(0, 0))
    x += move_vec.x
    y += move_vec.y
}
