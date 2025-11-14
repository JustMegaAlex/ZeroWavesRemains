
if target and !instance_exists(target) {
	target = noone
}

if target {
	var angle = aim_angle()
	var dist = sqrt(aim_dist()) * anchor_radius_gain
	rel_xto = lengthdir_x(dist, angle)
	rel_yto = lengthdir_y(dist, angle)
	var rel_hsp = abs(relx - rel_xto)*sp_ratio
	var rel_vsp = abs(rely - rel_yto)*sp_ratio
	relx = Approach(relx, rel_xto, rel_hsp)
	rely = Approach(rely, rel_yto, rel_vsp)
    
    var target_dist = InstDist(target)
    var target_dir = InstDir(target)
    sp_target.set_polar(target_dist * sp_ratio, target_dir)
	x += sp_target.x
	y += sp_target.y
} else {

    //if oInput.Pressed("camera_focus") {
        //if instance_exists(oPlayerRef) {
            //target = oPlayerRef
        //}
    //}

	//x += (oInput.Hold("right") - oInput.Hold("left")) * sp_max
	//y += (oInput.Hold("down") - oInput.Hold("up")) * sp_max
}

// drag with mouse
//if mouse_check_button(drag_button)
        //and ((mouse_x_prev != mouse_x)
             //or (mouse_y_prev != mouse_y)) {
    //x += mouse_x_prev - mouse_x
    //y += mouse_y_prev - mouse_y
    //target = noone
//} else {
    //mouse_x_prev = mouse_x
    //mouse_y_prev = mouse_y
//}

if !is_mouse_over_debug_overlay() {
    zoom_to += (oInput.Pressed("zoom_out") - oInput.Pressed("zoom_in")) * zoom_factor
    zoom_to = clamp(zoom_to, 0.5, 4)
}
zoom = Approach2(zoom, zoom_to, 0.04, 0.01)
SetZoom(zoom)

// update camera position with clampint to room bounds
// var w = CamW() * 0.5, h = CamH() * 0.5
// CameraSetPos(x + w, y + h)
CameraSetPos(x + relx*0, y + rely*0)
