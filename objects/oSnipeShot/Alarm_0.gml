
list = ds_list_create()
var count = instance_place_list(x, y, object_to_hit, list, false)
var inst = noone
for (var i = 0; i < count; i++) {
    inst = list[| i]
    if inst != shooter and CanHit(inst) {
        inst.hit(id)    
    }
}
ds_list_destroy(list)
