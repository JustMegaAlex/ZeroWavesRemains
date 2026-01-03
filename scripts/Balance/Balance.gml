
balance = {
    items: {
        heal_amount: 50,
        ammo_percent: 0.3,
        heal_amount_drop: 20,
        ammo_percent_drop: 0.3,
        costs: {
            pulse: {
                fire_rate: [7, 15, 20],
                bullet_speed: [7, 12, 18],
            },
            snipe: {
                weapon_cost: 80,
                dmg: [80, 90]
            },
            scatter: {
                weapon_cost: 50,
                range: [35, 45],
                dmg: [35, 45],
            },
            heal: 25,
            // [cost, amount]
            snipe_ammo: [20, 5],
            scatter_ammo: [20, 100],
        },
    },
    coins: {
        oEnemy: [5,7],
        oScout: [3,4],
        oEnemyTiny: [2,3],
        oItemDrone: [4,5],
    },
    progression: {
        total_waves: 23,
        strength_growth: 1.11,
        strength: 1,
        strength_growth_decrease_total: 0.1,
        strength_cost: {
            oEnemy: 1, oScout: 0.45, oEnemyTiny: 0.27
        }
    }
}
