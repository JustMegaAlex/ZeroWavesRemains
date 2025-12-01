

collapse = function() {
    for (var i = 0; i < array_length(items); ++i) {
        instance_destroy(items[i])
    }
    instance_destroy()
}


move_vec = new Vec2(0, 0)
move_sp = 10
push_from_shop_dist = 500
items = []
var shop_items_count = choose(1, 1, 1, 2)
var items_count = 3 - shop_items_count
item_pos_radius = 150
item_placement_vec = new Vec2(0, 0)

var shop_items = []
with oShopItem {
    if !is_unlocked and (object_index != oShopItemAmmo) {
        array_push(shop_items, id)
    }
}
shop_items = array_shuffle(shop_items)
for (var i = 0; i < array_length(shop_items); ++i) {
    var _item = shop_items[i]
    var drop = instance_create_layer(x, y, layer, oItemDropChoice, {item: _item, item_drop: id})
    array_push(items, drop)
    shop_items_count--
    if shop_items_count <= 0 {
        break
    }
}

items_count += shop_items_count
ds_list_shuffle(global.non_object_items_list)
for (var i = 0; i < items_count; ++i) {
    var item = global.non_object_items_list[| i]
    var drop = instance_create_layer(other.x, other.y, other.layer, oItemDropChoice, 
        {item: item, item_drop: id})
    array_push(items, drop)
}

ps = part_system_create(psItemDrop)
part_system_layer(ps, "Assets")

