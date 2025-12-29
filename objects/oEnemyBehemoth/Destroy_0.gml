event_inherited()

for (var i = 0; i < array_length(turrets); ++i) {
    instance_destroy(turrets[i])
}
ArrayClear(turrets)
if instance_exists(main_weapon) {
    instance_destroy(main_weapon)
}
