
EnsureSingleton()

get_default_state = function() {
    return {
        tech_scatter: false,
        tech_snipe: false,
        tech_hp: false,
        tech_shield: false,
        tech_emp: false,
    }
}

state = get_default_state()

unlockable_tiers = [
    ["hp"],
    ["scatter", "emp"],
    ["snipe", "shield"],
]

function getUnlockableByTier(tier) {
    var arr = unlockable_tiers[tier]
    while ArrayEmpty(arr) {
        tier--
        if tier < 0 {
            return undefined
        }
        arr = unlockable_tiers[tier]
    }
    var tech = ArrayChoose(arr)
    return ArrayRemove(arr, tech)
}

function techUnlocked(name) {
    name = $"tech_{string_lower(name)}"
    return state[$ name]
}

function unlockTech(tech) {
    tech = $"tech_{tech}"
    if !struct_has(state, tech) {
        throw $"Error: no such field: {tech}"
    }
    state[$ tech] = true
    save()
}

save_file = "state.sav"
function save_desktop() {
    var file = file_text_open_write(save_file)
    file_text_write_string(file, json_stringify(state))
}

function load_desktop() {
    if !file_exists(save_file) {
        return;
    }
    var file = file_text_open_read(save_file)
    state = json_parse(file_text_read_string(file))
}

function save_html() {
    var keys = variable_struct_get_names(state)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        var value = state[$ key]
        html_save_progress(key, value)
    }
}

function load_html() {
    var raw_cookie = html_load_progress()
    var splitted = string_split(raw_cookie, ";", true)
    for (var i = 0; i < array_length(splitted); ++i) {
        var item = splitted[i]
        item = string_replace_all(item, " ", "")
        key_val = string_split(item, "=")
        if struct_has(state, key_val[0]) {
            state[$ key_val[0]] = parse_cookie_value(key_val[1])
        }
    }
}

function reset() {
    state = get_default_state()
    save()
}

function parse_cookie_value(value) {
    try {
        return int64(value)
    } catch (e) {}
    try {
        return bool(value)
    } catch (e) {}
    try {
        return real(value)
    } catch (e) {}
    return value
}

save = save_desktop
load = load_desktop
if (os_type == os_browser) or (os_type == os_operagx) {
    save = save_html
    load = load_html
}


load()

