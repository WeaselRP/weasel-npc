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
        {'crack_pouch', 350, 500},
        {'lsd_tab', 8, 20},
        {'dmt_pouch', 200, 600},
    },
    DrugHotspots = {
        vector3(-496.0, -835.0, 35.0),
        vector3(921.0, -843.0, 56.0),
        vector3(-26.0, -1581.0, 31.0),
        vector3(-1207.0, -1350.0, 10.0),
        vector3(130.0, 212.0, 68.0),
        vector3(-1000.0, -240.0, 39.0),
        vector3(412.0, -944.0, 49.0),
    },
    DrugHotspotRadius = 1000.0,
    DrugHotspotMultiplier = 1.25,
    DrugHotspotSwapTime   = 30      --minutes
}

