
balance = {
    items: {
        heal_amount: 50,
        ammo_percent: 0.3,
        heal_amount_drop: 50,
        ammo_percent_drop: 0.3,
        costs: {
            pulse: [10, 40, 70],
            // [buy_cost, upgrade costs...]
            snipe: [80, 80, 90, 120],
            scatter: [60, 60, 70, 90],
            heal: 40,
            ammo: 0.3,
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
        total_waves: 20,
        strength_growth: 1.1,
        strength: 1,
        strength_growth_decrease_total: 0.05,
        strength_cost: {
            oEnemy: 1, oScout: 0.45, oEnemyTiny: 0.27
        }
    }
}
