
EnsureSingleton()

state = {
    tech_scatter: false,
    tech_snipe: false,
}

unlockable_tiers = [
    ["hp"],
    ["scatter", "snipe"],
    [],
]

function getUnlockableByTier(tier) {
    if ArrayEmpty(unlockable_tiers[tier]) {
        return undefined
    }
    var tech = ArrayChoose(unlockable_tiers[tier])
    return ArrayRemove(unlockable_tiers[tier], tech)
}

function techUnlocked(name) {
    name = $"tech_{string_lower(name)}"
    return state[$ name]
}

function save() {
    var keys = variable_struct_get_names(state)
    for (var i = 0; i < array_length(keys); ++i) {
        var key = keys[i]
        var value = state[$ key]
        html_save_progress(key, value)
    }
}

function load() {
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

load()
