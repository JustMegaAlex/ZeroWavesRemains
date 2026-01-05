event_inherited()


action = function() {
    hideSection(section)
    if callback != undefined {
        callback()
    }
}
