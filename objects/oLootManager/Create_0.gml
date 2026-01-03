EnsureSingleton()

loot_randomer = new ControlledRandomer({
   oCollectCoin: 50,
   oCollectAmmo: 5,
   oCollectHp: 5,
}, true)

spawnLoot = function(x, y, amount) {
   var obj
   repeat (amount) {
      obj = asset_get_index(loot_randomer.get())
   	instance_create_layer(x, y, "Instances", obj)
   }
}
