event_inherited()

no_player_destroy_exit

//// Choose weapon from unlocked ones
var availilbe_weapons = []
for (var i = 0; i < array_length(oPlayer.weapons_array); ++i) {
    var weap = oPlayer.weapons_array[i]
    if !weap or (weap == oPlayer.weapon_pulse) {
        continue
    }
    array_push(availilbe_weapons, weap)
}
/// destroy if no ammo-ish weapons unlocked
if ArrayEmpty(availilbe_weapons) {
    instance_destroy()
    exit
}

weapon = ArrayChoose(availilbe_weapons)
// image_blend = #EEBE36
image_blend = weapon == oPlayer.weapon_scatter ? #ee7e2f : #EEBE36
sprite_index = weapon == oPlayer.weapon_scatter ? sIconAmmoScatter : sIconAmmoSnipe

onCollect = function() {
    oPlayer.fillAmmo(weapon, round(weapon.ammo_max * 0.15))
}


updateCollectEnabled = function() {
    collect_enabled = weapon.ammo < weapon.ammo_max
}


