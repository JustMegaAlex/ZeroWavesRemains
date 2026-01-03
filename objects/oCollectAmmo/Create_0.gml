event_inherited()

weapon = choose(oPlayer.weapon_scatter, oPlayer.weapon_snipe)
image_blend = weapon == oPlayer.weapon_scatter ? #EE2F36 : #EEBE36

onCollect = function() {
    oPlayer.fillAmmo(weapon, round(weapon.ammo_max * 0.15))
}


updateCollectEnabled = function() {
    collect_enabled = weapon.ammo < weapon.ammo_max
}
