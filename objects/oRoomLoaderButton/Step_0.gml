

interacting = MouseCollision(id)

/// lightening if interaction
if interacting {
	image_index = _interact_img
	// just pressed
	if oInput.Pressed("lclick") {
		image_index = _checked_img
		oRoomLoader.GoTo(room_to_start)
	}
}
else {
	image_index = _default
}