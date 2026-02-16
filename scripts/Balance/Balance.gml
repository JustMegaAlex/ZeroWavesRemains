
balance = {}

function InitBalance() {
    global.balance = {
        items: {
            heal_amount: 50,
            ammo_percent: 0.3,
            heal_amount_drop: 20,
            ammo_percent_drop: 0.3,
            costs: {
                pulse: {
                    fire_rate: [25, 50, 80],
                    bullet_speed: [20, 40, 60],
                },
                snipe: {
                    weapon_cost: 60,
                    dmg: [80, 120]
                },
                scatter: {
                    weapon_cost: 50,
                    range: [50, 70],
                    dmg: [50, 80],
                },
                emp: {
                    weapon_cost: 40,
                    radius: [30, 45],
                    emp: [35, 50],
                },
                heal: 25,
                // [cost, amount]
                snipe_ammo: [20, 5],
                scatter_ammo: [20, 100],
                shield: [30, 45, 60]
            },
        },
        coins: {
            oEnemy: [5,7],
            oScout: [3,4],
            oEnemyTiny: [2,3],
            oEnemyFighter: [7, 10],
            oEnemyMosquito: [7, 10],
            // oItemDrone: [12, 18],
            __drone_incline: 0.6, // -0.5 part of coins in wave 0, +0.5 in the last wave
        },
        progression: {
            total_waves: 23,
            strength_growth: __diff(1.08, 1.11, 1.15),
            strength: 1,
            strength_growth_decrease_total: 0.1,
            strength_cost: {
                oEnemy: 1, oScout: 0.45, oEnemyTiny: 0.27,
                oEnemyFighter: 1.5, oEnemyMosquito: 1.5
            }
        }
    }
}
