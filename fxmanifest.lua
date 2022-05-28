---@author Dylan Malandain.
---@version 1.0
--[[
    File fxmanifest.lua
    Project Personal Menu
    Created at 27/05/2022
    Credit : https://github.com/Marlo93
--]]

fx_version('cerulean')
game('gta5')

client_scripts {
    'libs/RageUI//RMenu.lua',
    'libs/RageUI//menu/RageUI.lua',
    'libs/RageUI//menu/Menu.lua',
    'libs/RageUI//menu/MenuController.lua',
    'libs/RageUI//components/*.lua',
    'libs/RageUI//menu/elements/*.lua',
    'libs/RageUI//menu/items/*.lua',
    'libs/RageUI//menu/panels/*.lua',
    'libs/RageUI/menu/windows/*.lua',
    
    'client/*.lua',
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}
