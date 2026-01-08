EnsureSingleton()

loot_randomer = undefined
diff_multiplier = 1.5

spawnLoot = function(x, y, amount) {
    var obj
    var coins = 0
    repeat (amount * diff_multiplier) {
        obj = asset_get_index(loot_randomer.get())
        coins += obj == oCollectCoin
        instance_create_layer(x, y, "Instances", obj)
    }
    show_debug_message($"Loot: {coins} coins")
}

initLoot = function() {
    diff_multiplier = __diff(2.5, 2, 0.7)
    loot_randomer = new ControlledRandomer({
        oCollectCoin: 50 * diff_multiplier,
        oCollectAmmo: 5,
        oCollectHp: 5,
        }, true)
}

initLoot()
