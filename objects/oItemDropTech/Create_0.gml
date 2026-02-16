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
        id: id,
        name: "Scatter gun",
        unlock: function() {
            with oShopItemWeapon {
                if string_lower(weapon.name) == other.id.tech {
                    unlock()
                }
            }
        }
    },
    snipe: {
        icon: sUIWeaponSnipe,
        id: id,
        name: "Snipe gun",
        unlock: function() {
            with oShopItemWeapon {
                if string_lower(weapon.name) == other.id.tech {
                    unlock()
                }
            }
        }
    },
    shield: {
        icon: sIconShield,
        id: id,
        name: "Shield",
        unlock: function() {
            oShopItemShield.unlock()
        }
    },
    emp: {
        icon: sIconShield,
        id: id,
        name: "EMP missile",
        unlock: function() {
            with oShopItemWeapon {
                if string_lower(weapon.name) == other.id.tech {
                    unlock()
                }
            }
        }
    }
}

is_used = false
unlockable = config[$ tech]
text = $"New tech: {unlockable.name} (Press F)"


interact = function() {
    unlockable.unlock()
    is_used = true
    oGameState.unlockTech(tech)
    oUITextTechUnlocked.show()
    oUI.addHintArrow(oShop, "New tech!", c_lime, 300)
}
