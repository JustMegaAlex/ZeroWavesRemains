event_inherited()

config = {
    hp: {
        icon: sIconHeal,
        name: "Repair",
        unlock: function() {
            oShopItemHeal.unlock()
        }
    },
    scatter: {
        icon: sUIWeaponScatter,
        name: "Scatter gun",
        unlock: function() {
            with oShopItemWeapon {
                if string_lower(weapon.name) == other.tech {
                    unlock()
                }
            }
        }
    },
    snipe: {
        icon: sUIWeaponSnipe,
        name: "Snipe gun",
        unlock: function() {
            with oShopItemWeapon {
                if string_lower(weapon.name) == other.tech {
                    unlock()
                }
            }
        }
    },
}

is_used = false
unlockable = config[$ tech]
text = $"New tech: {unlockable.name} (Press F)"


interact = function() {
    unlockable.unlock()
    is_used = true
}
