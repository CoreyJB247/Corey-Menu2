-- Unified Menu System - Client
-- Links all menu systems together using ox_lib menu

-- Function to open scene menu
local function openSceneMenu()
    ExecuteCommand('+scenemenu')
    Wait(50)
    ExecuteCommand('-scenemenu')
end

-- Main Unified Menu
function OpenUnifiedMenu()
    lib.registerMenu({
        id = 'unified_main_menu',
        title = 'Corey Menu',
        position = 'top-right',
        options = {
            {
                label = 'Player Options',
                description = 'Player health, armor, and abilities',
                icon = 'user',
                iconColor = '#2ecc71'
            },
            {
                label = 'Vehicle Options',
                description = 'Vehicle spawner and customization',
                icon = 'car',
                iconColor = '#e74c3c'
            },
            {
                label = 'Misc Options',
                description = 'Noclip, HUD, radar, and coordinates',
                icon = 'sliders',
                iconColor = '#f39c12'
            },
            {
                label = 'Scene Menu',
                description = 'Object spawning, speed zones, and advertisements',
                icon = 'box',
                iconColor = '#3498db'
            }
        }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            ExecuteCommand('playermenu')
        elseif selected == 2 then
            ExecuteCommand('veh')
        elseif selected == 3 then
            ExecuteCommand('misc')
        elseif selected == 4 then
            openSceneMenu()
        end
    end)
    
    lib.showMenu('unified_main_menu')
end

-- Register command to open unified menu
RegisterCommand('menu', function()
    OpenUnifiedMenu()
end, false)

-- Register keybind (M by default)
RegisterKeyMapping('menu', 'Open Main Menu', 'keyboard', 'M')