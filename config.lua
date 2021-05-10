Config = {
    -- Robbing
    EnableRobNPC = true,
    RobTime = 20000,
    RobPoliceAlertPercent = 40,
    RobDisplayCode = '500',
    RobCash = {20, 75}, --Random between the 2 values
    RobCooldown = 3.5, -- in minutes
    
    Items = {
        {'green-dongle', 1, 5, {type=5}}, -- Item name, Item amount, Percent Chance
        {'yellow-dongle', 1, 2, {type=5}},
        {'red-dongle', 1, 1, {type=5}},
        {'precious_tear', 1, 1, {}}
    },

    -- Drugs
    UpdateTime = 2000,
    TransactionTime = 30000,
    AcceptPercent = 75,
    DrugPoliceAlertPercent = 75, -- Percent cahnce on failure to alert police
    MaxCanBuy = 3,
    DrugDisplayCode = '420',
    DrugCooldown = 0.5, -- In minutes
    DrugNames = {
        'weed_pouch',
        'meth_pouch', 
        'coke_pouch'
    },
    Drugs = {
        {'weed_pouch', (math.random(150, 250))},
        {'meth_pouch', (math.random(900, 1500))},
        {'coke_pouch', (math.random(400, 600))}
    }
}

