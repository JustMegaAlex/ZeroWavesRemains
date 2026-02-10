
catchBullet()

image_angle = dir

if is_emp_stunned and !emp_particle_timer.update() {
    oParticles.emp(
        random_range(bbox_left, bbox_right),
        random_range(bbox_top, bbox_bottom),
    )
}
