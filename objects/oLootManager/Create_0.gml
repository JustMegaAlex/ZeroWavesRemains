EnsureSingleton()

loot_randomer = undefined
diff_multiplier = 1.5

spawnLoot = function(x, y, amount) {
    var obj
    repeat (amount * diff_multiplier) {
        obj = asset_get_index(loot_randomer.get())
        instance_create_layer(x, y, "Instances", obj)
    }
}

initLoot = function() {
    diff_multiplier = __diff(2.8, 1)
    loot_randomer = new ControlledRandomer({
        oCollectCoin: 50 * diff_multiplier,
        oCollectAmmo: 5,
        oCollectHp: 5,
        }, true)
}

initLoot()
