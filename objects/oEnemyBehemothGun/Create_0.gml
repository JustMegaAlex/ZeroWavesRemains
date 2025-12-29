
// shoot_args - passed as args

shoot = function() {
    main_weapon.shoot(image_angle)
}

helper_vec = new Vec2(0, 0)
main_weapon_pos = new Vec2(0, 0)
main_weapon = noone
var pos = global.behemoth_gun_shoot_point
if pos[$ "x"] != undefined {
    main_weapon_pos.setv(pos)
    main_weapon = instance_create_layer(
        x + pos.x, y + pos.y, "FrontInstances", oExternalWeapon,
        shoot_args
    )
}

if room == rmStart {
    with instance_place(x, y, oExternalWeapon) {
        global.behemoth_gun_shoot_point.x = x - other.x
        global.behemoth_gun_shoot_point.y = y - other.y
        show_debug_message("Found behemoth gun shoot point")
    }
}
