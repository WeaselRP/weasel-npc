ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)


function success(source, msg)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = msg, length = 2500 })
end

function error(source, msg)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = msg, length = 2500 })
end

RegisterNetEvent("weasel-npc:robNPCStart")
AddEventHandler("weasel-npc:robNPCStart", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local robRandom = math.random(1,100)
    if robRandom <= Config.RobPoliceAlertPercent then
        local playerCoords = xPlayer.getCoords(true)
        local data = {displayCode = Config.RobDisplayCode, description = 'Robbery in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
        local dispatchData = {dispatchData = data, caller = 'Local', coords = playerCoords}
        TriggerEvent('wf-alerts:svNotify', dispatchData)
    end
end)

RegisterNetEvent("weasel-npc:robNPC")
AddEventHandler("weasel-npc:robNPC", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    success(_source, "You robbed the poor local")
    local cash = math.random(Config.RobCash[1],Config.RobCash[2])
    xPlayer.addMoney(cash)
    
    for i,v in pairs(Config.Items) do
        local itemsRandom = math.random(1,100)
        if itemsRandom <= v[3] then
            if xPlayer.canCarryItem(v[1], v[2]) then
                xPlayer.addInventoryItem(v[1], v[2], v[4])
            end
        end
    end

    TriggerClientEvent("weasel-npc:startCooldown", _source, "rob")

end)

RegisterNetEvent("weasel-npc:sellDrug")
AddEventHandler("weasel-npc:sellDrug", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local buyRandom = math.random(1,100)
    if buyRandom <= Config.AcceptPercent then
        local drug = nil
        local drugPrice = 0
        for i,v in pairs(Config.Drugs) do
            xItem = xPlayer.getInventoryItem(v[1])
            if xItem and xItem.count >= 1 then
                drug = xItem
                drugPrice = math.random(v[2], v[3])
                break
            end
        end

        if not drug then
            error(_source, "You do not have anything to sell!")
            return
        end
        local MaxCanBuy = 1
        if Config.MaxCanBuy > drug.count then
            MaxCanBuy = drug.count
        else
            MaxCanBuy = Config.MaxCanBuy
        end

        local amountRandom = math.random(1, MaxCanBuy)
        success(_source, "They bought "..amountRandom.. " "..drug.label)
        xPlayer.removeInventoryItem(drug.name, amountRandom)
        xPlayer.addMoney(drugPrice * amountRandom)
    else
        error(_source, "They have declined")
        local copRandom = math.random(1,100)
        if copRandom <= Config.DrugPoliceAlertPercent then
            local playerCoords = xPlayer.getCoords(true)
            local data = {displayCode = Config.DrugDisplayCode, description = 'Drug sale in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
            local dispatchData = {dispatchData = data, caller = 'Local', coords = playerCoords}
            TriggerEvent('wf-alerts:svNotify', dispatchData)
        end
    end
    TriggerClientEvent("weasel-npc:startCooldown", _source, "drug")
end)

