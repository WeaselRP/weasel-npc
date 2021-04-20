Config = {
    -- Robbing
    EnableRobNPC = true,
    RobTime = 20000,
    RobPoliceAlertPercent = 40,
    RobDisplayCode = '500',
    RobCash = {20, 150}, --Random between the 2 values
    
    Items = {
        {'green-dongle', 1, 20}, -- Item name, Item amount, Percent Chance
        {'red-dongle', 1, 5}
    },

    -- Drugs
    UpdateTime = 2000,
    TransactionTime = 10000,
    AcceptPercent = 80,
    DrugPoliceAlertPercent = 40, -- Percent cahnce on failure to alert police
    MaxCanBuy = 5,
    DrugDisplayCode = '420',

    

    Drugs = {
        {'weed_pouch', (math.random(210, 340))},
        {'meth_pouch', (math.random(250, 390))},
        {'coke_pouch', (math.random(280, 390))}
    }
}

