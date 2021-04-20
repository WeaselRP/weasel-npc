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

RegisterNetEvent("weasel-npc:hasDrugs")
AddEventHandler("weasel-npc:hasDrugs", function()
    local _source = source
    xPlayer = ESX.GetPlayerFromId(_source)
    for i,v in pairs(Config.Drugs) do
        xItem = xPlayer.getInventoryItem(v[1])
        if xItem and xItem.count >= 1 then
            TriggerClientEvent("weasel-npc:setHasDrugs", _source, true)
            break
        else
            TriggerClientEvent("weasel-npc:setHasDrugs", _source, false)
        end
    end
end)

RegisterNetEvent("weasel-npc:sellDrug")
AddEventHandler("weasel-npc:sellDrug", function()
    local _source = source
    xPlayer = ESX.GetPlayerFromId(_source)
    local buyRandom = math.random(1,100)
    if buyRandom <= Config.AcceptPercent then
        local drug = nil
        local drugPrice = 0
        for i,v in pairs(Config.Drugs) do
            xItem = xPlayer.getInventoryItem(v[1])
            if xItem and xItem.count >= 1 then
                drug = xItem
                drugPrice = v[2]
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
        TriggerEvent("weasel-npc:hasDrugs")
    else
        error(_source, "They have declined")
        local playerCoords = xPlayer.getCoords(true)
        local data = {displayCode = Config.DisplayCode, description = 'Drug sale in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
        local dispatchData = {dispatchData = data, caller = 'Local', coords = playerCoords}
        TriggerEvent('wf-alerts:svNotify', dispatchData)
    end
end)

