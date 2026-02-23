function html_save_progress(key, value) {
    let date = new Date();
    date.setTime(date.getTime() + 1000 * 3600 * 24)
    document.cookie = key + "=" + value + ";path=/;expires=" + date.toUTCString();
    console.log("saved " + key)
    localStorage.setItem(key, value);
    return 0
}

function html_load_progress() {
    console.log("load")
    result = ""
    result += "tech_scatter=" + (localStorage.getItem("tech_scatter") || "false")
    result += ";tech_snipe=" + (localStorage.getItem("tech_snipe") || "false")
    result += ";tech_hp=" + (localStorage.getItem("tech_hp") || "false")
    result += ";tech_shield=" + (localStorage.getItem("tech_shield") || "false")
    result += ";tech_emp=" + (localStorage.getItem("tech_emp") || "true")
    console.log("Load: " + result)
    return result
    return document.cookie
}
