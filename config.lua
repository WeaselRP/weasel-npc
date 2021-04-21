Config = {
    -- Robbing
    EnableRobNPC = true,
    RobTime = 20000,
    RobPoliceAlertPercent = 40,
    RobDisplayCode = '500',
    RobCash = {20, 150}, --Random between the 2 values
    RobCooldown = 3, -- in minutes
    
    Items = {
        {'green-dongle', 1, 10}, -- Item name, Item amount, Percent Chance
        {'yellow-dongle', 1, 5},
        {'red-dongle', 1, 1},
        {'precious_tear', 1, 1}
    },

    -- Drugs
    UpdateTime = 2000,
    TransactionTime = 10000,
    AcceptPercent = 80,
    DrugPoliceAlertPercent = 40, -- Percent cahnce on failure to alert police
    MaxCanBuy = 5,
    DrugDisplayCode = '420',
    DrugCooldown = 1, -- In minutes

    Drugs = {
        {'weed_pouch', (math.random(210, 340))},
        {'meth_pouch', (math.random(250, 390))},
        {'coke_pouch', (math.random(280, 390))}
    }
}

