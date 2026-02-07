
EnsureSingleton()

state = {
    tech: {
        scatter: false,
        snipe: false,
    }
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
    ArrayRemove(unlockable_tiers[tier], tech)
    return tech
}

function techUnlocked(name) {
    name = string_lower(name)
    return state.tech[$ name]
}
