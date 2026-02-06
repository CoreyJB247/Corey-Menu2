-- Scene Menu - Client
-- Object spawning and speed zones using ox_lib menu

local speedZoneActive = false
local blip
local speedZone
local speedzones = {}
local GlobalData = ""

-- Speed zone settings
local selectedRadius = 25
local selectedSpeed = 0

------------------------
--[[ Menu Functions ]]--
------------------------

-- Forward declarations
local openSpeedZoneMenu
local openRadiusMenu
local openSpeedMenu

local function openObjectMenu()
    local menuOptions = {}

    for k, v in pairs(Config.Objects) do
        table.insert(menuOptions, {
            label = v.Displayname,
            description = 'Spawn ' .. v.Displayname,
            icon = 'box',
            args = { object = v.Object, displayname = v.Displayname }
        })
    end

    table.insert(menuOptions, {
        label = 'Delete Nearest Object',
        description = 'Remove the closest prop',
        icon = 'trash',
        iconColor = 'red'
    })

    table.insert(menuOptions, {
        label = '← Back',
        description = 'Return to scene menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })

    lib.registerMenu({
        id = 'object_menu',
        title = 'Objects Menu',
        position = 'top-right',
        onClose = function()
            OpenSceneMainMenu()
        end,
        options = menuOptions
    }, function(selected, scrollIndex, args)
        if selected <= #Config.Objects then
            -- Spawn object
            local Player = PlayerPedId()
            local heading = GetEntityHeading(Player)
            local coords = GetEntityCoords(Player, true)
            local objectname = args.object

            RequestModel(objectname)
            while not HasModelLoaded(objectname) do
                Citizen.Wait(1)
            end

            local obj = CreateObject(GetHashKey(objectname), coords.x, coords.y, coords.z, true, false)
            PlaceObjectOnGroundProperly(obj)
            SetEntityHeading(obj, heading)
            FreezeEntityPosition(obj, true)

            lib.notify({
                title = 'Object Spawned',
                description = args.displayname .. ' has been placed',
                type = 'success'
            })

            openObjectMenu()
        elseif selected == #Config.Objects + 1 then
            -- Delete nearest object
            local coords = GetEntityCoords(PlayerPedId(), true)
            local deleted = false

            for k, v in pairs(Config.Objects) do
                local hash = GetHashKey(v.Object)
                if DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 0.9, hash, true) then
                    local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.9, hash, false, false, false)
                    DeleteObject(object)
                    deleted = true
                    break
                end
            end

            if deleted then
                lib.notify({
                    title = 'Scene Menu',
                    description = 'Nearest object removed',
                    type = 'success'
                })
            else
                lib.notify({
                    title = 'Scene Menu',
                    description = 'No objects nearby to delete',
                    type = 'error'
                })
            end

            openObjectMenu()
        else
            -- Back button
            OpenSceneMainMenu()
        end
    end)

    lib.showMenu('object_menu')
end

openSpeedZoneMenu = function()
    lib.registerMenu({
        id = 'speedzone_menu',
        title = 'Speed Zone',
        position = 'top-right',
        onClose = function()
            OpenSceneMainMenu()
        end,
        options = {
            {
                label = 'Speed Zone Radius',
                description = 'Current: ' .. selectedRadius .. 'm',
                icon = 'arrows-left-right',
                iconColor = '#3498db'
            },
            {
                label = 'Speed Zone Limit',
                description = 'Current: ' .. selectedSpeed .. ' mph',
                icon = 'gauge',
                iconColor = '#e74c3c'
            },
            {
                label = 'Create Speed Zone',
                description = 'Place zone with current settings',
                icon = 'circle-plus',
                iconColor = '#2ecc71'
            },
            {
                label = 'Delete Speed Zone',
                description = 'Remove nearest speed zone',
                icon = 'circle-xmark',
                iconColor = '#e74c3c'
            },
            {
                label = '← Back',
                description = 'Return to scene menu',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            openRadiusMenu()
        elseif selected == 2 then
            openSpeedMenu()
        elseif selected == 3 then
            -- Create Speed Zone
            speedZoneActive = true
            local coords = GetEntityCoords(PlayerPedId())

            local streetName, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            streetName = GetStreetNameFromHashKey(streetName)

            local message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. selectedSpeed .. "mph ^7due to an incident."
            TriggerServerEvent('ZoneActivated', message, selectedSpeed + 0.0, selectedRadius + 0.0, coords.x, coords.y, coords.z)

            lib.notify({
                title = 'Speed Zone Created',
                description = 'Speed limit: ' .. selectedSpeed .. 'mph, Radius: ' .. selectedRadius .. 'm',
                type = 'success'
            })

            openSpeedZoneMenu()
        elseif selected == 4 then
            -- Delete Speed Zone
            TriggerServerEvent('Disable')
            lib.notify({
                title = 'Scene Menu',
                description = 'Speed Zones Disabled',
                type = 'success'
            })
            openSpeedZoneMenu()
        else
            -- Back button
            OpenSceneMainMenu()
        end
    end)

    lib.showMenu('speedzone_menu')
end

openRadiusMenu = function()
    local menuOptions = {}

    for _, v in pairs(Config.SpeedZone.Radius) do
        local isSelected = tonumber(v) == selectedRadius
        table.insert(menuOptions, {
            label = v .. 'm',
            description = isSelected and 'Currently selected' or 'Select this radius',
            icon = isSelected and 'check-circle' or 'circle',
            iconColor = isSelected and '#2ecc71' or nil,
            args = { radius = tonumber(v) }
        })
    end

    table.insert(menuOptions, {
        label = '← Back',
        description = 'Return to speed zone menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })

    lib.registerMenu({
        id = 'radius_menu',
        title = 'Select Radius',
        position = 'top-right',
        onClose = function()
            openSpeedZoneMenu()
        end,
        options = menuOptions
    }, function(selected, scrollIndex, args)
        if selected <= #Config.SpeedZone.Radius then
            selectedRadius = args.radius
            lib.notify({
                title = 'Radius Set',
                description = 'Radius set to ' .. args.radius .. 'm',
                type = 'success'
            })
            openSpeedZoneMenu()
        else
            -- Back button
            openSpeedZoneMenu()
        end
    end)

    lib.showMenu('radius_menu')
end

openSpeedMenu = function()
    local menuOptions = {}

    for _, v in pairs(Config.SpeedZone.Speed) do
        local isSelected = tonumber(v) == selectedSpeed
        table.insert(menuOptions, {
            label = v .. ' mph',
            description = isSelected and 'Currently selected' or 'Select this speed',
            icon = isSelected and 'check-circle' or 'circle',
            iconColor = isSelected and '#2ecc71' or nil,
            args = { speed = tonumber(v) }
        })
    end

    table.insert(menuOptions, {
        label = '← Back',
        description = 'Return to speed zone menu',
        icon = 'arrow-left',
        iconColor = '#95a5a6'
    })

    lib.registerMenu({
        id = 'speed_menu',
        title = 'Select Speed Limit',
        position = 'top-right',
        onClose = function()
            openSpeedZoneMenu()
        end,
        options = menuOptions
    }, function(selected, scrollIndex, args)
        if selected <= #Config.SpeedZone.Speed then
            selectedSpeed = args.speed
            lib.notify({
                title = 'Speed Limit Set',
                description = 'Speed limit set to ' .. args.speed .. ' mph',
                type = 'success'
            })
            openSpeedZoneMenu()
        else
            -- Back button
            openSpeedZoneMenu()
        end
    end)

    lib.showMenu('speed_menu')
end

function OpenSceneMainMenu()
    lib.registerMenu({
        id = 'scene_main_menu',
        title = 'Scene Menu',
        position = 'top-right',
        onClose = function()
            lib.showMenu('unified_main_menu')
        end,
        options = {
            {
                label = '← Back to Main Menu',
                description = 'Return to unified menu',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            },
            {
                label = 'Object Menu',
                description = 'Spawn and manage objects',
                icon = 'box'
            },
            {
                label = 'Speed Zone',
                description = 'Create and manage speed zones',
                icon = 'gauge',
                iconColor = '#eff158ff'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            lib.showMenu('unified_main_menu')
        elseif selected == 2 then
            openObjectMenu()
        elseif selected == 3 then
            openSpeedZoneMenu()
        end
    end)

    lib.showMenu('scene_main_menu')
end

------------------------
--[[ Menu Activation ]]--
------------------------

local function checkPermission()
    if Config.UsageMode == "Ped" then
        local pmodel = GetEntityModel(PlayerPedId())
        if inArrayPed(pmodel, Config.WhitelistedPeds) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not in the correct ped to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "IP" then
        TriggerServerEvent("GetData", "IP")
        Wait(100)
        if inArray(GlobalData, Config.WhitelistedIPs) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not whitelisted to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "Steam" then
        TriggerServerEvent("GetData", "Steam")
        Wait(100)
        if inArraySteam(GlobalData, Config.WhitelistedSteam) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not whitelisted to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "Everyone" then
        return true
    end
    return false
end

if Config.ActivationMode == "Key" then
    RegisterCommand('+scenemenu', function()
        if checkPermission() then
            OpenSceneMainMenu()
        end
    end)

    RegisterCommand('-scenemenu', function() end)

    RegisterKeyMapping('+scenemenu', 'Open Scene Menu', 'keyboard', Config.ActivationKey)
elseif Config.ActivationMode == "Command" then
    RegisterCommand(Config.ActivationCommand, function()
        if checkPermission() then
            OpenSceneMainMenu()
        end
    end, false)
end

------------------------
--[[ Network Events ]]--
------------------------

RegisterNetEvent('ReturnData')
AddEventHandler('ReturnData', function(data)
    GlobalData = data
end)

RegisterNetEvent('Zone')
AddEventHandler('Zone', function(speed, radius, x, y, z)
    blip = AddBlipForRadius(x, y, z, radius)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 80)
    SetBlipSprite(blip, 9)
    speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)

    table.insert(speedzones, { x, y, z, speedZone, blip })
end)

RegisterNetEvent('RemoveBlip')
AddEventHandler('RemoveBlip', function()
    if speedzones == nil or #speedzones == 0 then
        return
    end

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed, true)
    local closestSpeedZone = 0
    local closestDistance = 1000

    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - coords)
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end

    if closestSpeedZone > 0 then
        RemoveSpeedZone(speedzones[closestSpeedZone][4])
        RemoveBlip(speedzones[closestSpeedZone][5])
        table.remove(speedzones, closestSpeedZone)
    end
end)

--------------------------
--[[ Useful Functions ]]--
--------------------------

function inArrayPed(value, array)
    for _, v in pairs(array) do
        if GetHashKey(v) == value then
            return true
        end
    end
    return false
end

function inArray(value, array)
    for _, v in pairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function inArraySteam(value, array)
    for _, v in pairs(array) do
        v = getSteamId(v)
        if v == value then
            return true
        end
    end
    return false
end

function isNativeSteamId(steamId)
    if string.sub(steamId, 0, 6) == "steam:" then
        return true
    end
    return false
end

function getSteamId(steamId)
    if not isNativeSteamId(steamId) then
        steamId = "steam:" .. string.format("%x", tonumber(steamId))
    else
        steamId = string.lower(steamId)
    end
    return steamId
end