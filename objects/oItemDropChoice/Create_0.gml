event_inherited()

prompt_text = "???"

setItem = function(_item) {
    item = _item
    if is_struct(item) {
        prompt_text = press_f_prompt + item.prompt_text
    } else {
        switch item.object_index {
            case oShopItemWeapon:
            case oShopItemWeaponUpgrade:
                prompt_text = $"{press_f_prompt} add {item.weapon.name} weapon to the shop"
            break
            case oShopItemHeal:
                prompt_text = $"{press_f_prompt} add healing to the shop"
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
