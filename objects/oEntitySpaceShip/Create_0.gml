event_inherited()

shoot_at = noone
shoot_at_under_control = true
weapon = {
    name: undefined,
    dmg: undefined,
    reload_timer: MakeTimer(0),
    range: undefined,
}

ApplyEquipment(id, "blaster")

function DropItems() {
    var keys = variable_struct_get_names(cargo)
    var drop_item_amout = 0
    var item_name = null
    if !ArrayEmpty(keys) {
        item_name = ArrayChoose(keys)
        drop_item_amout = (0.5 + random(0.3)) * cargo[$ item_name]
        CreateItem(item_name,
            x + random_range(-30, 30),
            y + random_range(-30, 30),
            {quantity: drop_item_amout}
        )
    }
    var stardust_amount = money * random(0.3)
    if stardust_amount >= 0 {
        CreateItem("stardust", 
            x + random_range(-30, 30),
            y + random_range(-30, 30),
            {quantity: stardust_amount}
        )
    }
}