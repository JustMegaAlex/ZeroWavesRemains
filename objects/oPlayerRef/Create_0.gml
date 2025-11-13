event_inherited()

function setSpTo(sp, dir) {
	hsp_to = lengthdir_x(sp, dir)
	vsp_to = lengthdir_y(sp, dir)
}

function setDirTo(_dir_to) {
	dir_to = _dir_to
}

function updateDir(rot_sp=rotary_sp) {
	var diff = angle_difference(dir_to, dir)
	if abs(diff) < rot_sp {
		dir = dir_to
		return true
	}
	dir += rotary_sp * sign(diff)
}

function updateSp(accelerate=true) {
	if accelerate {
		hsp = Approach(hsp, hsp_to, acc)
		vsp = Approach(vsp, vsp_to, acc)
	} else {
		hsp = Approach(hsp, 0, acc)
		vsp = Approach(vsp, 0, acc)	
	}
}

money = 10

hsp = 0
vsp = 0
hsp_to = 0
vsp_to = 0
acc = 0.5
vacc = 0
input_v = 0
move_h = 0
move_v = 0
input_dir = 0
rotary_sp = 5
dir = 0
dir_to = 0
sp = new Vec2(0, 0)

sp_gain = 1

image_speed = 0

reload_timer = MakeTimer(20)
reloading = 0
bullet_sp = 20

world_cursor = instance_create_layer(x, y, layer, oPlayerWorldCursor)

/// Items
items = {
    highlight: noone,
    list: ds_list_create(),
    interact_dist: 100,
    mouse_interact_dist: 30
}

acc = 0.3

var cam = instance_create_layer(x, y, layer, oCamera)
cam.target = id

aim_target = noone
aim_angle = 0

