event_inherited()

prompt_text = "???"

setItem = function(_item) {
    item = _item
    if is_struct(item) {
        prompt_text = item.prompt_text
    } else {
        switch item.object_index {
            case oShopItemWeapon:
                prompt_text = $"Add {item.weapon.name} weapon to the shop"
            break
        }
    }
}

interact = function() {
    if item_drop != noone {
        item_drop.collapse()
    }
    if is_struct(item) {
        item.apply()
    } else {
        item.unlock()
    }
}

setItem(item)
