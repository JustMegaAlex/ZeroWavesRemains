
item_template = {

}

var heal_amount = 20
var ammo_precent = 30
var coins = 20
item_heal = {
    heal_amount: heal_amount,
    prompt_text: $"heal {heal_amount} hp",
    icon: sIconHeal,
    apply: function() {
        oPlayer.heal(heal_amount)
    }
}

item_ammo = {
    icon: sIconAmmo,
    ammo_precent: ammo_precent,
    prompt_text: $"get {ammo_precent}% ammo for current weapon",
    apply: function() {
        oPlayer.weapon.ammo += round(oPlayer.weapon.ammo_max * ammo_precent)
        audio_play_sound(sfxWeaponReload, 2, false)
    }
}

item_coins = {
    icon: sIconCoins,
    coins: coins,
    prompt_text: $"get {coins} coins",
    apply: function() {
        with oPlayer {
            repeat other.coins {
                instance_create_layer(x + 50, y, "Instances", oCoin)
            }
        }
    }
}

non_object_items_list = ds_list_create()
ds_list_add(non_object_items_list, item_heal)
ds_list_add(non_object_items_list, item_ammo)
ds_list_add(non_object_items_list, item_coins)
