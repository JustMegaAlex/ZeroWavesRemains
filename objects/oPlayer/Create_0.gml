event_inherited()

battle_side = battle_side_player

instance_create_layer(x, y, layer, oCamera)

weapon_pulse = {
    dmg: 20,
    timer: MakeTimer(9),
    object: oBullet,
}

weapon_snipe = {
    dmg: 120,
    timer: MakeTimer(60),
    object: oSnipeShot,
    range: 6000,
}

weapon = weapon_snipe
