
EnsureSingleton()

state = {
    tech: {
        scatter: false,
        snipe: false,
    }
}

function techUnlocked(name) {
    name = string_lower(name)
    return state.tech[$ name]
}
