ESX = nil
hasDrugs = false
selling = false
robbing = false

sellingCooldown = false
robbingCooldown = false
PlayerLoaded = false
hotspotLocation = nil
blip = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	Citizen.Wait(1000)
	StartResource()
end)

StartResource = function()
	Citizen.CreateThread(function()
		Citizen.Wait(8000)
		PlayerLoaded = true
		StartLoop()
	end)
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value[1] == val then
            return true
        end
    end

    return false
end

StartLoop = function()
	Citizen.CreateThread(function()
		while PlayerLoaded do
			Wait(Config.UpdateTime)
			ESX.PlayerData.inventory = ESX.GetPlayerData().inventory
            hasDrugs = false
            for k, v in pairs(ESX.PlayerData.inventory) do
				if has_value(Config.Drugs, v.name) then
                    hasDrugs = true
                    break
                end
			end
        end
    end)
end

if ESX.IsPlayerLoaded() then StartResource() end


Citizen.CreateThread(function()

    while true do
        Wait(0)
        local isArmed = IsPedArmed(GetPlayerPed(-1), 7) and IsPedArmed(GetPlayerPed(-1), 4)
        if hasDrugs and not selling and not sellingCooldown and not isArmed then
            
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
                            nearPedDrugs(ped, npcPos)
                        end
                    end
                end
            until not success
            EndFindPed(handle)
        end
    end
end)

Citizen.CreateThread(function() -- Creates thread
    
    local lastPed = nil
	while Config.EnableRobNPC do
		Wait(0)
        local isArmed = IsPedArmed(GetPlayerPed(-1), 7) and IsPedArmed(GetPlayerPed(-1), 4)
        if not robbing and isArmed then
            local aiming, ped = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
            if aiming and not IsPedArmed(ped, 7) then
                if not IsPedInAnyVehicle(GetPlayerPed(-1)) and DoesEntityExist(ped) and not IsPedDeadOrDying(ped) and IsPedHuman(ped) and not IsPedAPlayer(ped) then
                    nearPedRob(ped)
                    lastPed = ped
                end
            end
        else
            TaskHandsUp(lastPed, 1000, GetPlayerPed(-1), -1, true)
        end
	end
end)

RegisterNetEvent("weasel-npc:hotspotChange")
AddEventHandler("weasel-npc:hotspotChange", function(i)
    RemoveBlip(blip)
    blip = AddBlipForRadius(Config.DrugHotspots[i].x, Config.DrugHotspots[i].y, Config.DrugHotspots[i].z, Config.DrugHotspotRadius)
    hotspotLocation = Config.DrugHotspots[i]
    SetBlipSprite(blip,148)
    SetBlipColour(blip,2)
    SetBlipAlpha(blip,80)
end)

RegisterNetEvent("weasel-npc:startCooldown")
AddEventHandler("weasel-npc:startCooldown", function(type)
    if type == "drug" then
        sellingCooldown = true
        Citizen.Wait(Config.DrugCooldown * 60000)
        sellingCooldown = false
    else
        robbingCooldown = true
        Citizen.Wait(Config.RobCooldown * 60000)
        robbingCooldown = false
    end
end)

function nearPedRob(ped)
    local npcPos = GetEntityCoords(ped)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
    local dist = #(npcPos - playerPos)
    local textLoc = vector3(npcPos.x, npcPos.y, npcPos.z+0.2)
    if dist < 15 then
        if IsPedInAnyVehicle(ped) then
            TaskLeaveAnyVehicle(ped)
            Citizen.Wait(1000)
            return
        end
        SetEntityAsMissionEntity(ped)
        TaskHandsUp(ped, 1000, GetPlayerPed(-1), -1, true)
        
        if dist < 2 then
            ESX.Game.Utils.DrawText3D(textLoc, "Press [~g~E~w~] to rob")
            if IsControlJustReleased(0, 153) then
                if robbingCooldown then
                    exports['mythic_notify']:SendAlert('error', 'You must wait to rob another local')
                    return
                end
                robbing = true
                TriggerServerEvent("weasel-npc:robNPCStart")
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "rob_npc",
                    duration = Config.RobTime,
                    label = "Robbing Local",
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
                        TriggerServerEvent("weasel-npc:robNPC")
                    end
                    robbing = false
                    SetPedAsNoLongerNeeded(ped)
                end)
            end
        end
    end
end

function nearPedDrugs(ped, npcPos)
    local textLoc = vector3(npcPos.x, npcPos.y, npcPos.z+0.2)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
    ESX.Game.Utils.DrawText3D(textLoc, "Press [~g~E~w~] to sell drugs")
    if IsControlJustReleased(0, 153) then
        if sellingCooldown then
            exports['mythic_notify']:SendAlert('error', 'You must wait to sell more drugs')
            return
        end
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
            if not status and #(playerPos-hotspotLocation) <= Config.DrugHotspotRadius then
                TriggerServerEvent("weasel-npc:sellDrug", true)
            elseif not status then
                TriggerServerEvent("weasel-npc:sellDrug", false)
            end
            selling = false
            SetPedAsNoLongerNeeded(ped)
        end)
    end
end