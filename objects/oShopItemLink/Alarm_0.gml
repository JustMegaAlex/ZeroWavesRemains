
parent = collision_point(start.x, start.y, oShopItem, false, true)
child = collision_point(ending.x, ending.y, oShopItem, false, true)

var someone = instance_place(x, y, oShopItem)

array_push(parent.child_nodes, child)
child.parent_node = parent

/// Correct positioning
start.setv(parent)
diff = ending
diff.setv(child).sub(start)

x = start.x
y = start.y
image_angle = diff.dir()
image_xscale *= diff.len() / sprite_width

global.shop_links_initialized = true
