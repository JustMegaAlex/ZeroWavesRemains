event_inherited()

battle_side = battle_side_player

instance_create_layer(x, y, layer, oCamera)

weapon_pulse = {
    dmg: 20,
    timer: MakeTimer(9),
    object: oBullet,
    name: "Pulse",
}


weapon_scatter = {
    dmg: 4,
    timer: MakeTimer(2),
    range: 1800,
    object: oBulletScatter,
    image_xscale: 1,
    image_yscale: 1,
    spread_angle: 7,
    sp: 120,
    name: "Scatter",
}

weapon_snipe = {
    dmg: 120,
    timer: MakeTimer(60),
    object: oSnipeShot,
    range: 6000,
    name: "Snipe",
}

weapon = weapon_pulse

weapons_array = [
    weapon_pulse, weapon_scatter, weapon_snipe
]

inputSwitchWeapon = function() {
    var slot = keyboard_lastkey - 48
    if median(1, 5, slot) != slot {
        show_debug_message($"Wrong weapon slot {slot}")
        return;
    }
    if median(1, array_length(weapons_array), slot) != slot {
        return;
    }
    weapon = weapons_array[slot-1]
}
