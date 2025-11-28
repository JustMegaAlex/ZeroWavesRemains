event_inherited()

prompt_text = "???"
switch item.object_index {
    case oShopItemWeapon:
        prompt_text = $"Add {item.weapon.name} weapon to the shop"
    break
}

interact = function() {
    if item_drop != noone {
        item_drop.collapse()
    }
    item.unlock()
}
