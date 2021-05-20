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
        {'gold_necklace', 1, 10, {}},
        {'gold_watch', 1, 10, {}},
        {'platinum_watch', 1, 4, {}},
        {'precious_tear', 1, 1, {}}
    },

    -- Drugs
    UpdateTime = 2000,
    TransactionTime = 30000,
    AcceptPercent = 65,
    DrugPoliceAlertPercent = 75, -- Percent cahnce on failure to alert police
    MaxCanBuy = 3,
    DrugDisplayCode = '420',
    DrugCooldown = 0.5, -- In minutes
    Drugs = {
        {'weed_pouch', 250, 350},
        {'meth_pouch', 300, 500},
        {'coke_pouch', 400, 600},
        {'lsd_tab', 8, 20},
    }
}

