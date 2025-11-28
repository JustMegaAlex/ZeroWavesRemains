
items = []
var count = 3
item_pos_radius = 150
item_placement_vec = new Vec2(0, 0)
with oShopItem {
    if is_unlocked or (object_index == oShopItemAmmo) {
        continue
    }
    var drop = instance_create_layer(other.x, other.y, other.layer, oItemDropChoice, {item: id})
    array_push(other.items, drop)
    count--
    if count <= 0 {
        break
    }
}
