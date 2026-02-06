-- Player Options Menu - Client
-- Player health, armor, abilities, and effects using ox_lib menu

local playerOptions = {
    godMode = false,
    invisible = false,
    infiniteStamina = false,
    fastRun = false,
    fastSwim = false,
    superJump = false,
    noRagdoll = false,
    neverWanted = false
}

-- Toggle Functions
local function toggleInfiniteStamina()
    playerOptions.infiniteStamina = not playerOptions.infiniteStamina
    lib.notify({
        title = 'Infinite Stamina',
        description = playerOptions.infiniteStamina and 'Enabled' or 'Disabled',
        type = playerOptions.infiniteStamina and 'success' or 'inform'
    })
end

local function toggleFastRun()
    playerOptions.fastRun = not playerOptions.fastRun
    if playerOptions.fastRun then
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    else
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    end
    lib.notify({
        title = 'Fast Run',
        description = playerOptions.fastRun and 'Enabled' or 'Disabled',
        type = playerOptions.fastRun and 'success' or 'inform'
    })
end

local function toggleFastSwim()
    playerOptions.fastSwim = not playerOptions.fastSwim
    if playerOptions.fastSwim then
        SetSwimMultiplierForPlayer(PlayerId(), 1.49)
    else
        SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    end
    lib.notify({
        title = 'Fast Swim',
        description = playerOptions.fastSwim and 'Enabled' or 'Disabled',
        type = playerOptions.fastSwim and 'success' or 'inform'
    })
end

local function toggleSuperJump()
    playerOptions.superJump = not playerOptions.superJump
    lib.notify({
        title = 'Super Jump',
        description = playerOptions.superJump and 'Enabled' or 'Disabled',
        type = playerOptions.superJump and 'success' or 'inform'
    })
end

local function toggleNoRagdoll()
    playerOptions.noRagdoll = not playerOptions.noRagdoll
    lib.notify({
        title = 'No Ragdoll',
        description = playerOptions.noRagdoll and 'Enabled' or 'Disabled',
        type = playerOptions.noRagdoll and 'success' or 'inform'
    })
end

-- Player Action Functions
local function healPlayer()
    local ped = PlayerPedId()
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    lib.notify({
        title = 'Player Healed',
        description = 'Health restored to maximum',
        type = 'success'
    })
end

local function revivePlayer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    ClearPedTasksImmediately(ped)
    lib.notify({
        title = 'Player Revived',
        description = 'You have been revived',
        type = 'success'
    })
end

local function cleanPlayer()
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    ClearPedWetness(ped)
    ClearPedEnvDirt(ped)
    ResetPedVisibleDamage(ped)
    lib.notify({
        title = 'Player Cleaned',
        description = 'All dirt and blood removed',
        type = 'success'
    })
end

-- Armor Options Menu
local function openArmorMenu()
    lib.registerMenu({
        id = 'armor_options_menu',
        title = 'Armor Options',
        position = 'top-right',
        onClose = function()
            OpenPlayerOptionsMenu()
        end,
        options = {
            {
                label = 'No Armor (0%)',
                description = 'Remove all armor',
                icon = 'xmark',
                iconColor = '#e74c3c'
            },
            {
                label = 'Light Armor (25%)',
                description = 'Basic protection',
                icon = 'vest',
                iconColor = '#95a5a6'
            },
            {
                label = 'Standard Armor (50%)',
                description = 'Standard police vest',
                icon = 'vest',
                iconColor = '#3498db'
            },
            {
                label = 'Heavy Armor (75%)',
                description = 'Military grade protection',
                icon = 'vest-patches',
                iconColor = '#f39c12'
            },
            {
                label = 'Super Heavy Armor (100%)',
                description = 'Maximum protection',
                icon = 'vest-patches',
                iconColor = '#27ae60'
            },
            {
                label = 'Custom Armor',
                description = 'Enter a custom armor value',
                icon = 'keyboard',
                iconColor = '#9b59b6'
            },
            {
                label = '← Back',
                description = 'Return to player options',
                icon = 'arrow-left',
                iconColor = '#95a5a6'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            SetPedArmour(PlayerPedId(), 0)
            lib.notify({
                title = 'Armor Removed',
                description = 'No Armor equipped (0%)',
                type = 'success'
            })
            openArmorMenu()
        elseif selected == 2 then
            SetPedArmour(PlayerPedId(), 25)
            lib.notify({
                title = 'Armor Added',
                description = 'Light Armor equipped (25%)',
                type = 'success'
            })
            openArmorMenu()
        elseif selected == 3 then
            SetPedArmour(PlayerPedId(), 50)
            lib.notify({
                title = 'Armor Added',
                description = 'Standard Armor equipped (50%)',
                type = 'success'
            })
            openArmorMenu()
        elseif selected == 4 then
            SetPedArmour(PlayerPedId(), 75)
            lib.notify({
                title = 'Armor Added',
                description = 'Heavy Armor equipped (75%)',
                type = 'success'
            })
            openArmorMenu()
        elseif selected == 5 then
            SetPedArmour(PlayerPedId(), 100)
            lib.notify({
                title = 'Armor Added',
                description = 'Super Heavy Armor equipped (100%)',
                type = 'success'
            })
            openArmorMenu()
        elseif selected == 6 then
            local input = lib.inputDialog('Custom Armor', {
                {
                    type = 'number',
                    label = 'Armor Amount',
                    description = 'Enter armor value (0-100)',
                    required = true,
                    min = 0,
                    max = 100
                }
            })
            
            if input then
                SetPedArmour(PlayerPedId(), input[1])
                lib.notify({
                    title = 'Armor Added',
                    description = 'Custom Armor equipped (' .. input[1] .. '%)',
                    type = 'success'
                })
            end
            openArmorMenu()
        elseif selected == 7 then
            OpenPlayerOptionsMenu()
        end
    end)
    
    lib.showMenu('armor_options_menu')
end

-- Main Player Options Menu
function OpenPlayerOptionsMenu()
    lib.registerMenu({
        id = 'player_options_menu',
        title = 'Player Options',
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
                label = 'Heal Player',
                description = 'Restore health to maximum',
                icon = 'heart',
                iconColor = '#ff6b6b'
            },
            {
                label = 'Give Armor',
                description = 'Open armor selection menu',
                icon = 'shield',
                iconColor = '#6c5ce7'
            },
            {
                label = 'Revive Player',
                description = 'Revive if dead',
                icon = 'heart-pulse',
                iconColor = '#4ecdc4'
            },
            {
                label = 'Clean Player',
                description = 'Remove blood and dirt',
                icon = 'spray-can',
                iconColor = '#95e1d3'
            },
            {
                label = 'Fast Run',
                description = 'Status: ' .. (playerOptions.fastRun and 'Enabled' or 'Disabled'),
                icon = 'person-running',
                iconColor = playerOptions.fastRun and '#00ff00' or '#ff0000'
            },
            {
                label = 'Fast Swim',
                description = 'Status: ' .. (playerOptions.fastSwim and 'Enabled' or 'Disabled'),
                icon = 'person-swimming',
                iconColor = playerOptions.fastSwim and '#00ff00' or '#ff0000'
            },
            {
                label = 'Infinite Stamina',
                description = 'Status: ' .. (playerOptions.infiniteStamina and 'Enabled' or 'Disabled'),
                icon = 'lungs',
                iconColor = playerOptions.infiniteStamina and '#00ff00' or '#ff0000'
            },
            {
                label = 'Super Jump',
                description = 'Status: ' .. (playerOptions.superJump and 'Enabled' or 'Disabled'),
                icon = 'up-long',
                iconColor = playerOptions.superJump and '#00ff00' or '#ff0000'
            },
            {
                label = 'No Ragdoll',
                description = 'Status: ' .. (playerOptions.noRagdoll and 'Enabled' or 'Disabled'),
                icon = 'person',
                iconColor = playerOptions.noRagdoll and '#00ff00' or '#ff0000'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            lib.showMenu('unified_main_menu')
        elseif selected == 2 then
            healPlayer()
            OpenPlayerOptionsMenu()
        elseif selected == 3 then
            openArmorMenu()
        elseif selected == 4 then
            revivePlayer()
            OpenPlayerOptionsMenu()
        elseif selected == 5 then
            cleanPlayer()
            OpenPlayerOptionsMenu()
        elseif selected == 6 then
            toggleFastRun()
            OpenPlayerOptionsMenu()
        elseif selected == 7 then
            toggleFastSwim()
            OpenPlayerOptionsMenu()
        elseif selected == 8 then
            toggleInfiniteStamina()
            OpenPlayerOptionsMenu()
        elseif selected == 9 then
            toggleSuperJump()
            OpenPlayerOptionsMenu()
        elseif selected == 10 then
            toggleNoRagdoll()
            OpenPlayerOptionsMenu()
        end
    end)

    lib.showMenu('player_options_menu')
end

-- Command to open menu
RegisterCommand('playermenu', function()
    OpenPlayerOptionsMenu()
end, false)

-- Threads for continuous effects
CreateThread(function()
    while true do
        Wait(0)
        
        local ped = PlayerPedId()
        
        -- Infinite Stamina
        if playerOptions.infiniteStamina then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        
        -- Super Jump
        if playerOptions.superJump then
            SetSuperJumpThisFrame(PlayerId())
        end
        
        -- No Ragdoll
        if playerOptions.noRagdoll then
            SetPedCanRagdoll(ped, false)
        end
        
        -- Never Wanted
        if playerOptions.neverWanted then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)