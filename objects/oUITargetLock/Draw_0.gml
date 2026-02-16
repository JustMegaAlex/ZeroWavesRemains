if target {
    var _aim_size = aim_size
    var _gap_factor = gap_factor
    with target {
        draw_set_color(other.color)
        draw_line(
            x - _aim_size,
            y - _aim_size,
            x - _aim_size * _gap_factor,
            y - _aim_size,
        )
        draw_line(
            x + _aim_size,
            y - _aim_size,
            x + _aim_size * _gap_factor,
            y - _aim_size,
        )
        draw_line(
            x - _aim_size,
            y + _aim_size,
            x - _aim_size * _gap_factor,
            y + _aim_size,
        )
        draw_line(
            x + _aim_size,
            y + _aim_size,
            x + _aim_size * _gap_factor,
            y + _aim_size,
        )

        draw_line(
            x - _aim_size,
            y - _aim_size,
            x - _aim_size,
            y - _aim_size * _gap_factor,
        )
        draw_line(
            x + _aim_size,
            y - _aim_size,
            x + _aim_size,
            y - _aim_size * _gap_factor,
        )
        draw_line(
            x - _aim_size,
            y + _aim_size,
            x - _aim_size,
            y + _aim_size * _gap_factor,
        )
        draw_line(
            x + _aim_size,
            y + _aim_size,
            x + _aim_size,
            y + _aim_size * _gap_factor,
        )
        draw_set_color(c_white)
    }
}