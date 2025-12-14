
if key_pressed(ord("R")) {
    event_perform(ev_create, 0)
}

draw_text(20, 20, $"pure={pure_score}")
draw_text(20, 40, $"error_20={error_20}")
draw_text(20, 60, $"error_40={error_40}")
draw_text(20, 80, $"error_100={error_100}")
draw_text(20, 100, $"error_300={error_300}")
