
EnsureSingleton()

function aim_dist() {
	return point_distance(CamXCent(), CamYCent(), mouse_x, mouse_y)
}
function aim_angle() {
	return point_direction(CamXCent(), CamYCent(), mouse_x, mouse_y)
}
anchor_radius_gain = 2
target = oPlayer
sp_ratio = 0.125
rel_xto = x
rel_yto = y
relx = 0
rely = 0

velocity = new Vec2(0, 0)

view_enabled = true
view_visible[0] = true

aspect_ratio = 1920 / 1080
camera_width = 1920
camera_height = camera_width / aspect_ratio

zoom = 1
zoom_to = 1
zoom_treshold_speed = 40
zoom_factor = 0.25

shaking = {
    on: false,
    magnitude: 5,
    timer: MakeTimer(12, 0),
    time_gain: 40,
    xphase_sp: 1.2,
    yphase_sp: 0.82,
    vec: new Vec2(0, 0)
}

// mouse drag
drag_button = mb_middle
mouse_x_prev = 0
mouse_y_prev = 0

sp_max = 8

function SetZoom(value) {
    zoom = value
    camera_set_view_size(view_camera[0], camera_width * zoom, camera_height * zoom)
}

shake = function() {
    shaking.on = true
    shaking.timer.reset()
}


sp_target = new Vec2(0, 0)
sp_target_ratio = 0.04

