
item_template = {

}

var heal_amount = global.balance.items.heal_amount_drop
var ammo_precent = global.balance.items.ammo_percent_drop
var coins = 20
item_heal = {
    color_index: "item_consumable",
    heal_amount: heal_amount,
    prompt_text: $"heal {heal_amount} hp",
    icon: sIconHeal,
    apply: function() {
        oPlayer.heal(heal_amount)
    }
}

item_ammo = {
    color_index: "item_consumable",
    icon: sIconAmmo,
    ammo_precent: ammo_precent,
    prompt_text: $"get {ammo_precent*100}% ammo for current weapon",
    apply: function() {
        oPlayer.weapon.ammo += round(oPlayer.weapon.ammo_max * ammo_precent)
        audio_play_sound(sfxWeaponReload, 2, false)
    }
}

item_coins = {
    color_index: "oCollectCoin",
    icon: sIconCoins,
    coins: coins,
    prompt_text: $"get {coins} coins",
    apply: function() {
        with oPlayer {
            repeat other.coins {
                instance_create_layer(x + 50, y, "Instances", oCollectCoin)
            }
        }
    }
}

non_object_items_list = ds_list_create()
ds_list_add(non_object_items_list, item_heal)
ds_list_add(non_object_items_list, item_ammo)
ds_list_add(non_object_items_list, item_coins)
