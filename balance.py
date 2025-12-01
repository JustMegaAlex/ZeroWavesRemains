
balance = {
    "items": {
        "heal_amount": 50,
        "ammo_percent": 0.3,
        "heal_amount_drop": 50,
        "ammo_percent_drop": 0.3,
        "costs": {
            "pulse": [10, 40, 70],
            "snipe": [80, 80, 90, 120],
            "scatter": [60, 60, 70, 90],
            "heal": 40,
            "ammo": 0.3,
            "snipe_ammo": [20, 5],
            "scatter_ammo": [20, 100],
        },
    },
    "coins": {
        "oEnemy": [5,7],
        "oScout": [3,4],
        "oEnemyTiny": [2,3],
    },
    "progression": {
        "total_waves": 20,
        "strength_growth": 1.1,
        "strength": 1.5,
        "strength_growth_decrease_total": 0.05,
        "strength_cost": {
            "oEnemy": 1, "oScout": 0.45, "oEnemyTiny": 0.27
        }
    }
}


prog = balance["progression"]
waves = prog["total_waves"]
strength = prog["strength"]
growth = prog["strength_growth"]
growth_decrease = prog["strength_growth_decrease_total"] / waves

total_coins = 0

for i in range(waves):
    strength *= growth
    growth -= growth_decrease
    print(strength)
