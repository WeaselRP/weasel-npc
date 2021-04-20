ESX = nil
hasDrugs = false
selling = false


Citizen.CreateThread(function()
    while ESX == nil do
        Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)


Citizen.CreateThread(function()

    while true do
        Wait(0)
        if hasDrugs and not selling then
            
            local player = GetPlayerPed(-1)
            local playerPos = GetEntityCoords(player)
            local handle, ped = FindFirstPed()
            repeat
                success, ped = FindNextPed(handle)
                local npcPos = GetEntityCoords(ped)
                local dist = #(npcPos - playerPos)
                if not IsPedInAnyVehicle(GetPlayerPed(-1)) and DoesEntityExist(ped) and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
                    local pedType = GetPedType(ped)
                    if pedType ~= 28 and not IsPedAPlayer(ped) then
                        if dist <= 2 then
                            nearPed(ped, npcPos)
                        end
                    end
                end
            until not success
            EndFindPed(handle)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.UpdateTime)
        TriggerServerEvent("weasel-npc:hasDrugs")
    end
end)

RegisterNetEvent("weasel-npc:setHasDrugs")
AddEventHandler("weasel-npc:setHasDrugs", function(drugs)
    hasDrugs = drugs
end)

function nearPed(ped, npcPos)
    local textLoc = vector3(npcPos.x, npcPos.y, npcPos.z+0.2)
    
    ESX.Game.Utils.DrawText3D(textLoc, "Press [~g~E~w~] to sell drugs")
    if IsControlJustReleased(0, 153) then
        selling = true
        SetEntityAsMissionEntity(ped)
        TaskStandStill(ped, Config.TransactionTime)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "attempt_sell_drugs",
            duration = Config.TransactionTime,
            label = "Attempting to sell drugs",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@idle_a",
                anim = "idle_a",
            }
        }, function(status)
            if not status then
                TriggerServerEvent("weasel-npc:sellDrug")
            end
            selling = false
            SetPedAsNoLongerNeeded(ped)
        end)
    end
end
