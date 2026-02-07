function html_save_progress(key, value) {
    let date = new Date();
    date.setTime(date.getTime() + 1000 * 3600 * 24)
    document.cookie = key + "=" + value + ";path=/;expires=" + date.toUTCString();
    console.log("saved " + key)
    return 0
}

function html_load_progress() {
    console.log("load")
    return document.cookie
}
