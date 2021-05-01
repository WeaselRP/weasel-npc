Config = {
    -- Robbing
    EnableRobNPC = true,
    RobTime = 20000,
    RobPoliceAlertPercent = 40,
    RobDisplayCode = '500',
    RobCash = {20, 50}, --Random between the 2 values
    RobCooldown = 3.5, -- in minutes
    
    Items = {
        {'green-dongle', 1, 5, {type=5}}, -- Item name, Item amount, Percent Chance
        {'yellow-dongle', 1, 2, {type=5}},
        {'red-dongle', 1, 1, {type=5}},
        {'precious_tear', 1, 1, {}}
    },

    -- Drugs
    UpdateTime = 2000,
    TransactionTime = 13000,
    AcceptPercent = 75,
    DrugPoliceAlertPercent = 75, -- Percent cahnce on failure to alert police
    MaxCanBuy = 3,
    DrugDisplayCode = '420',
    DrugCooldown = 3, -- In minutes

    Drugs = {
        {'weed_pouch', (math.random(150, 250))},
        {'meth_pouch', (math.random(780, 940))},
        {'coke_pouch', (math.random(300, 500))}
    }
}

