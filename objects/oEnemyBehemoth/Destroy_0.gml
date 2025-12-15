event_inherited()

for (var i = 0; i < array_length(turrets); ++i) {
    instance_destroy(turrets[i])
}
ArrayClear(turrets)
