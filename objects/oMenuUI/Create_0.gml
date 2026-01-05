
activate_delay_timer = MakeTimer(2)

deactivate = function() {
    active = false
}
activate = function() {
    active = true
    activate_delay_timer.reset()
}
