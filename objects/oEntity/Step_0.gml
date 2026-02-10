
catchBullet()

image_angle = dir

if is_emp_stunned {
    is_emp_stunned = emp_timer.update()
    if !emp_particle_timer.update() {
        oParticles.emp(
            random_range(bbox_left, bbox_right),
            random_range(bbox_top, bbox_bottom),
        )
    }
}
