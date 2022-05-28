---@author Dylan Malandain.
---@version 1.0
--[[
    File client/function.lua
    Project Personal Menu
    Created at 27/05/2022
    Credit : https://github.com/Marlo93
--]]

Keys.Register('F5', 'F5', 'Ouvrir le menu personnel.', function()
    openPersonal()
end)

function CheckQuantity(number)
    number = tonumber(number)
    if type(number) == 'number' then
        number = ESX.Math.Round(number)
        if number > 0 then
            return true, number
        end
    end
    return false, number
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function giveMoneyWallet(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

RegisterNetEvent('marlo:tshirt')
AddEventHandler('marlo:tshirt', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.torso_1 ~= skinb.torso_1 then
                vethaut = true
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = skina.torso_1, ['torso_2'] = skina.torso_2, ['tshirt_1'] = skina.tshirt_1, ['tshirt_2'] = skina.tshirt_2, ['arms'] = skina.arms})
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
                vethaut = false
            end
        end)
    end)
end)

RegisterNetEvent('marlo:pants')
AddEventHandler('marlo:pants', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtrousers', 'try_trousers_neutral_c'

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())

            if skina.pants_1 ~= skinb.pants_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = skina.pants_1, ['pants_2'] = skina.pants_2})
                vetbas = true
            else
                vetbas = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 15, ['pants_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['pants_1'] = 61, ['pants_2'] = 1})
                end
            end
        end)
    end)
end)

RegisterNetEvent('marlo:shoes')
AddEventHandler('marlo:shoes', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingshoes', 'try_shoes_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.shoes_1 ~= skinb.shoes_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = skina.shoes_1, ['shoes_2'] = skina.shoes_2})
                vetch = true
            else
                vetch = false
                if skina.sex == 1 then
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 35, ['shoes_2'] = 0})
                else
                    TriggerEvent('skinchanger:loadClothes', skinb, {['shoes_1'] = 34, ['shoes_2'] = 0})
                end
            end
        end)
    end)
end)

RegisterNetEvent('marlo:sac')
AddEventHandler('marlo:sac', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bags_1 ~= skinb.bags_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = skina.bags_1, ['bags_2'] = skina.bags_2})
                vetsac = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bags_1'] = 0, ['bags_2'] = 0})
                vetsac = false
            end
        end)
    end)
end)

RegisterNetEvent('marlo:gpb')
AddEventHandler('marlo:gpb', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingtie', 'try_tie_neutral_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.bproof_1 ~= skinb.bproof_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = skina.bproof_1, ['bproof_2'] = skina.bproof_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['bproof_1'] = 0, ['bproof_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end)

RegisterNetEvent('marlo:mask')
AddEventHandler('marlo:mask', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'missfbi4', 'takeoff_mask'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.mask_1 ~= skinb.mask_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = skina.mask_1, ['mask_2'] = skina.mask_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['mask_1'] = 0, ['mask_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end)

RegisterNetEvent('marlo:hat')
AddEventHandler('marlo:hat', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'missfbi4', 'takeoff_mask'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.helmet_1 ~= skinb.helmet_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = skina.helmet_1, ['mask_2'] = skina.helmet_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['helmet_1'] = -1, ['helmet_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end)

RegisterNetEvent('marlo:glasses')
AddEventHandler('marlo:glasses', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skina)
        TriggerEvent('skinchanger:getSkin', function(skinb)
            local lib, anim = 'clothingspecs', 'try_glasses_positive_a'
            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            end)
            Citizen.Wait(1000)
            ClearPedTasks(PlayerPedId())
            if skina.glasses_1 ~= skinb.glasses_1 then
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = skina.glasses_1, ['glasses_2'] = skina.glasses_2})
                vetgilet = true
            else
                TriggerEvent('skinchanger:loadClothes', skinb, {['glasses_1'] = 0, ['glasses_2'] = 0})
                vetgilet = false
            end
        end)
    end)
end)

function giveTypeMoney(value)
    if value == 1 then
        local amount = KeyboardInput('Que voulez-vous faire ?', nil, 8)
        if amount ~= nil then
            amount = tonumber(amount)
            if type (amount) == 'number' then
                TriggerServerEvent('personal:giveMoneyCash', amount)
                ESX.ShowNotification('Give de '..amount.. '~g~ $~s~~n~ Type : ~g~Liquide~s~')
            end
        end
    elseif value == 2 then
        local amount = KeyboardInput('Que voulez-vous faire ?', nil, 8)
        if amount ~= nil then
            amount = tonumber(amount)
            if type (amount) == 'number' then
                TriggerServerEvent('personal:giveMoneyBank', amount)
                ESX.ShowNotification('Give de '..amount.. '~b~ $~s~~n~ Type : ~b~Banque~s~')
            end
        end
    elseif value == 3 then
        local amount = KeyboardInput('Que voulez-vous faire ?', nil, 8)
        if amount ~= nil then
            amount = tonumber(amount)
            if type (amount) == 'number' then
                TriggerServerEvent('personal:giveMoneyBlack', amount)
                ESX.ShowNotification('Give de '..amount.. '~r~ $~s~~n~ Type : ~r~Sale~s~')
            end
        end
    end
end
