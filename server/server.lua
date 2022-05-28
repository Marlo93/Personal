ESX = nil
TriggerEvent(Config.getESX, function(obj) ESX = obj end)

RegisterServerEvent('personal:recruitPlayer')
AddEventHandler('personal:recruitPlayer', function(target, job, grade)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.job.grade_name == 'boss' then
        xTarget.setJob(job, grade)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez recruté ' .. xTarget.name .. '.')
        TriggerClientEvent('esx:showNotification', xTarget.source, 'Vous avez été recruté par ' .. xPlayer.name .. '.')
    end
end)

RegisterServerEvent('personal:promotePlayer')
AddEventHandler('personal:promotePlayer', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if (xTarget.job.grade == tonumber(getMaximumGrade(xPlayer.job.name)) - 1) then
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous devez demander une autorisation au gouvernement.')
    else
        if xPlayer.job.grade_name == 'boss' and xPlayer.job.name == xTarget.job.name then
            xTarget.setJob(xTarget.job.name, tonumber(xTarget.job.grade) + 1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez promu ' .. xTarget.name .. '.')
            TriggerClientEvent('esx:showNotification', xTarget.source, 'Vous avez été promu par ' .. xPlayer.name .. '.')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas la permission de faire cela.')
        end
    end
end)

RegisterServerEvent('personal:demotePlayer')
AddEventHandler('personal:demotePlayer', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if (xTarget.job.grade == 0) then
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous ne pouvez pas rétrograder plus bas.')
    else
        if xPlayer.job.grade_name == 'boss' and xPlayer.job.name == xTarget.job.name then
            xTarget.setJob(xTarget.job.name, tonumber(xTarget.job.grade) - 1)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez rétrogradé ' .. xTarget.name .. '.')
            TriggerClientEvent('esx:showNotification', xTarget.source, 'Vous avez été rétrogradé par ' .. xPlayer.name .. '.')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas la permission de faire cela.')
        end
    end
end)

RegisterServerEvent('personal:removePlayer')
AddEventHandler('personal:removePlayer', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xPlayer.job.grade_name == 'boss' then
        xTarget.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez viré ' .. xTarget.name .. '.')
        TriggerClientEvent('esx:showNotification', xTarget.source, 'Vous avez été viré par ' .. xPlayer.name .. '.')
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas la permission de faire cela.')
    end
end)

ESX.RegisterServerCallback('personal:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    cb(group)
end)

RegisterServerEvent('logsPersonal:takeService')
AddEventHandler('logsPersonal:takeService', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    ServerToDiscord(Config.nameTitle, 'Prise de service d\'administration du joueur : ' ..xPlayer.getName(), 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:leaveService')
AddEventHandler('logsPersonal:leaveService', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    ServerToDiscord(Config.nameTitle, 'Fin de service d\'administration du joueur : ' ..xPlayer.getName(), 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:heal')
AddEventHandler('logsPersonal:heal', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a soigné ' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:deleteVehicle')
AddEventHandler('logsPersonal:deleteVehicle', function(vehicleName)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a supprimé le véhicule ' .. vehicleName ..  '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:teleportToThePlayer')
AddEventHandler('logsPersonal:teleportToThePlayer', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' s\'est téléporté sur le joueur :' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:teleporterSomeone')
AddEventHandler('logsPersonal:teleporterSomeone', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a téléporté ' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:freeze')
AddEventHandler('logsPersonal:freeze', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a freeze le joueur : ' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:unfreeze')
AddEventHandler('logsPersonal:unfreeze', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a unfreeze le joueur : ' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:clearInventory')
AddEventHandler('logsPersonal:clearInventory', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(target)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a vidé l\'inventaire du joueur : ' .. xTarget.getName() .. '.', 2061822, Config.webHook)
end)

RegisterServerEvent('logsPersonal:addVehicle')
AddEventHandler('logsPersonal:addVehicle', function(vehName)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    ServerToDiscord(Config.nameTitle, 'Staff : ' .. xPlayer.getName() .. ' a fait spawn le véhicule '..vehName, 2061822, Config.webHook)
end)

RegisterServerEvent('personal:giveMoneyCash')
AddEventHandler('personal:giveMoneyCash', function(money)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local total = money
    xPlayer.addMoney(total)
    ServerToDiscord(Config.nameTitle, 'Staff : '..xPlayer.getName().. ' s\'est donné '..total..' $ !\nType : Liquide', 2061822, Config.webHook)
end)

RegisterServerEvent('personal:giveMoneyBank')
AddEventHandler('personal:giveMoneyBank', function(money)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local total = money
    xPlayer.addAccountMoney('bank', total)
    ServerToDiscord(Config.nameTitle, 'Staff : '..xPlayer.getName().. ' s\'est donné '..total..' $ !\nType : Banque', 2061822, Config.webHook)
end)

RegisterServerEvent('personal:giveMoneyBlack')
AddEventHandler('personal:giveMoneyBlack', function(money)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local total = money
    xPlayer.addAccountMoney('black_money', total)
    ServerToDiscord(Config.nameTitle, 'Staff : '..xPlayer.getName().. ' s\'est donné '..total..' $ !\nType : Argent sale', 2061822, Config.webHook)
end)

function ServerToDiscord(name, message, color)
    date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
    local discordWebhook = Config.webHook
    local embeds = {
        {
            ['title'] = message,
            ['type'] = 'rich',
            ['color'] = color,
            ['footer'] = {
                ['text'] = 'Heure : ' ..date_local.. '',
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end