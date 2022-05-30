---@author Dylan Malandain.
---@version 1.0
--[[
    File client/client.lua
    Project Personal Menu
    Created at 27/05/2022
    Credit : https://github.com/Marlo93
--]]

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.getESX, function(obj) ESX = obj end)
        Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    personal.weaponData = ESX.GetWeaponList()
    for i = 1, #personal.weaponData, 1 do
        if personal.weaponData[i].name == 'WEAPON_UNARMED' then
            personal.weaponData[i] = nil
        else
            personal.weaponData[i].hash = GetHashKey(personal.weaponData[i].name)
        end
    end

    ESX.TriggerServerCallback('personal:getUsergroup', function(group)
        playergroup = group
    end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	  ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

personal = {
    itemSelected = {},
    weaponData = {},
    Ped = PlayerPedId(),
    serversIdSession = {},

    gestionCar = {
        select = {
            hood = false,
            trunk = false,
            frontLeft = false,
            frontRight = false,
            backLeft = false,
            backRight = false,
        },
        index = 1,
    },
}

local indexNameMoney = {'Liquide', 'Banque', 'Sale'}
local indexMoney = 1

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(personal.serversIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(personal.serversIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

Menu = {}
Menu.Toggle = false
function Menu:Create()
    Menu.Toggle = true
main = RageUI.CreateMenu(Config.nameServer, 'Que voulez-vous faire ?', 50, 200)
aboutMe = RageUI.CreateSubMenu(main, Config.nameServer, 'Que voulez-vous faire ?')
inventory = RageUI.CreateSubMenu(aboutMe, 'Inventaire', 'Que voulez-vous faire ?')
weapon = RageUI.CreateSubMenu(main, 'Gestion d\'armes', 'Que voulez-vous faire ?')
insideWeapon = RageUI.CreateSubMenu(weapon, 'Gestion d\'armes', 'Que voulez-vous faire ?')
insideInventory = RageUI.CreateSubMenu(inventory, 'Inventaire', 'Que voulez-vous faire ?')
wallet = RageUI.CreateSubMenu(aboutMe, 'Portefeuille', 'Que voulez-vous faire ?')
identity = RageUI.CreateSubMenu(aboutMe, 'Informations', 'Que voulez-vous faire ?')
clothes = RageUI.CreateSubMenu(main, 'Vêtements', 'Que voulez-vous faire ?')
accessories = RageUI.CreateSubMenu(clothes, 'Accessoires', 'Que voulez-vous faire ?')
settings = RageUI.CreateSubMenu(main, 'Paramètres', 'Que voulez-vous faire ?')
gestionCar = RageUI.CreateSubMenu(main, 'Gestion véhicule', 'Que voulez-vous faire ?')
getInformationCar = RageUI.CreateSubMenu(gestionCar, 'Informations', 'Que voulez-vous faire ?')
secondGestionCar = RageUI.CreateSubMenu(gestionCar, 'Gestion véhicule', 'Que voulez-vous faire ?')
entreprise = RageUI.CreateSubMenu(main, 'Entreprise', 'Que voulez-vous faire ?')
organisation = RageUI.CreateSubMenu(main, 'Organisation', 'Que voulez-vous faire ?')
administration = RageUI.CreateSubMenu(main, 'Administration', 'Que voulez-vous faire ?')
gestionPlayer = RageUI.CreateSubMenu(administration, 'Gestion', 'Que voulez-vous faire ?')
utilitary = RageUI.CreateSubMenu(administration, 'Utilitaires', 'Que voulez-vous faire ?')
copyPositionforUtilitary = RageUI.CreateSubMenu(utilitary, 'Utilitaires', 'Que voulez-vous faire ?')
gestionCarAdministration = RageUI.CreateSubMenu(administration, 'Gestion', 'Que voulez-vous faire ?')
managePlayer = RageUI.CreateSubMenu(gestionPlayer, 'Gestion', 'Que voulez-vous faire ?')
main:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
aboutMe:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
inventory:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
weapon:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
insideWeapon:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
insideInventory:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
wallet:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
identity:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
clothes:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
accessories:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
settings:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
gestionCar:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
getInformationCar:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
secondGestionCar:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
entreprise:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
organisation:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
administration:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
gestionPlayer:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
utilitary:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
copyPositionforUtilitary:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
gestionCarAdministration:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
managePlayer:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
main.Closed = function()
    Menu.Toggle = false
    end
end

function openPersonal()
    Menu:Create()
    RageUI.Visible(main, true)
    while true do
        Citizen.Wait(2.0)
        if Menu.Toggle then

                RageUI.IsVisible(main, function()

                    RageUI.Button('Me concernant', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, aboutMe)

                    if Config.haveNotweaponItem then
                    RageUI.Button('Armements', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, weapon)
                end

                    RageUI.Button('Vêtements', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, clothes)

                    RageUI.Button('Paramètres', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, settings)

                    if IsPedInAnyVehicle(PlayerPedId(), -1) then
                        RageUI.Button('Gestion véhicule', nil , {RightLabel = '→'}, true , {
                            onSelected = function()                     
                            end
                        }, gestionCar)
                    else
                        RageUI.Button('Gestion véhicule', nil , {RightLabel = '→'}, false , {
                            onSelected = function()                     
                            end
                        })
                    end

                    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
                        RageUI.Button('Gestion entreprise', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, entreprise)
                    else
                        RageUI.Button('Gestion entreprise', nil, {RightLabel = '→'}, false, {
                            onSelected = function()
                            end
                        })
                    end

                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                        RageUI.Button('Gestion organisation', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, organisation)
                    else
                        RageUI.Button('Gestion organisation', nil, {RightLabel = '→'}, false, {
                            onSelected = function()
                            end
                        })
                    end

                    if playergroup == 'superadmin' or playergroup == 'admin' or playergroup == 'mod' then
                        RageUI.Button('Administration', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, administration)
                    end
                end)

                RageUI.IsVisible(aboutMe, function()

                    RageUI.Button('Inventaire', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, inventory)

                    RageUI.Button('Portefeuille', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, wallet)

                    RageUI.Button('Mes papiers', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, identity)

                end)

                RageUI.IsVisible(inventory, function()

                    ESX.PlayerData = ESX.GetPlayerData()
                    local countInventory = 0;
                    for i = 1, #ESX.PlayerData.inventory do
                        if ESX.PlayerData.inventory[i].count > 0 then
                            countInventory = countInventory + ESX.PlayerData.inventory[i].count
                            RageUI.Button(ESX.PlayerData.inventory[i].label, nil, {RightLabel = '('..ESX.PlayerData.inventory[i].count..')'}, true, {
                                onSelected = function()
                                    personal.itemSelected = ESX.PlayerData.inventory[i]
                                end
                            }, insideInventory)

                        end
                    end
                    if countInventory == 0 then
                        RageUI.GoBack()
                        ESX.ShowNotification('~b~Vous ne pouvez plus accéder à votre inventaire, car il est vide !~s~')
                    end
                end)

                RageUI.IsVisible(weapon, function()

                    ESX.PlayerData = ESX.GetPlayerData()
                    for i = 1, #personal.weaponData, 1 do
                        if HasPedGotWeapon(PlayerPedId(), personal.weaponData[i].hash, false) then
                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), personal.weaponData[i].hash)

                            RageUI.Button(personal.weaponData[i].label, nil, {RightLabel = '('..ammo..')'}, true, {
                                onSelected = function()
                                    personal.itemSelected = personal.weaponData[i]
                                end
                            }, insideWeapon)
                        end
                    end
                end)

                RageUI.IsVisible(insideWeapon, function()

                    if HasPedGotWeapon(PlayerPedId(), personal.itemSelected.hash, false) then
                        RageUI.Button('Donner son arme', nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
                            onSelected = function()
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    local playerPed = PlayerPedId()
                                    local coords = GetEntityCoords(playerPed)
                                    local x,y,z = table.unpack(coords)
                                    
                                    if IsPedOnFoot(closestPed) then
                                        local ammo = GetAmmoInPedWeapon(PlayerPedId(), personal.itemSelected.hash)
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_weapon', personal.itemSelected.name, ammo)
                                    else
                                        ESX.ShowNotification('~r~Vous ne pouvez pas donner d\'armes en étant dans un véhicule !~s~')
                                    end
                                else
                                    ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                                end
                            end
                        })

                    end

            RageUI.Button('Donner des munitions', nil, {RightBadge = RageUI.BadgeStyle.Ammo}, true, {
                onSelected = function()
                    local post, quantity = KeyboardInput('Que voulez-vous faire ?', nil, 5)
                    if post then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            local closestPed = GetPlayerPed(closestPlayer)
                            local playerPed = PlayerPedId()
                            local coords = GetEntityCoords(playerPed)
                            local x,y,z = table.unpack(coords)
                            DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)

                            if IsPedOnFoot(closestPed) then
                                local ammo = GetAmmoInPedWeapon(personal.Ped, personal.itemSelected.hash)
                                if ammo > 0 then
                                    if quantity <= ammo and quantity >= 0 then
                                        local finalAmmo = math.floor(ammo - quantity)
                                        SetPedAmmo(personal.Ped, personal.itemSelected.hash, finalAmmo)
                                        TriggerServerEvent('personal:weaponAddammoToPed', GetPlayerServerId(closestPlayer), personal.itemSelected.name, quantity)
                                        ESX.ShowNotification('Vous avez donné des munitions !')
                                    else
                                        ESX.ShowNotification('~r~Vous n\'avez pas assez de munitions !~s~')
                                    end
                                else
                                    ESX.ShowNotification('~r~Vous n\'avez pas de munitions !~s~')
                                end
                            else
                                ESX.ShowNotification('~r~Vous ne pouvez pas donner des munitions en étant dans un véhicule !~s~')
                            end
                            else
                                 ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                            else
                                ESX.ShowNotification('~r~Nombre de munitions invalide !~s~')
                            end
                        end
                    })

                end)

                RageUI.IsVisible(wallet, function()

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'money' then
                            RageUI.Button(ESX.PlayerData.accounts[i].label, nil, {RightLabel = ''..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).. '~g~ $~s~'}, true, {
                                onSelected = function()
                                    local money, quantity = CheckQuantity(giveMoneyWallet('Que voulez-vous faire ?', nil, nil, 9))
                                    if money then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if not IsPedSittingInAnyVehicle(closestPed) then
                                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_money', ESX.PlayerData.money, quantity)
                                            else
                                                ESX.ShowNotification('~r~Vous ne pouvez pas donner de l\'argent en étant dans un véhicule !~s~')
                                            end
                                        else
                                            ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                                        end
                                    else
                                        ESX.ShowNotification('~r~Montant invalide !~s~')
                                    end
                                end
                            })
                        end

		if Config.showBankWallet then
                        if ESX.PlayerData.accounts[i].name == 'bank' then
                            RageUI.Button(ESX.PlayerData.accounts[i].label, nil, {RightLabel = ''..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).. '~b~ $~s~'}, true, {
                                onSelected = function()
                                end
                            })
                   	end	
	            end
								
                        if ESX.PlayerData.accounts[i].name == 'black_money' then
                            RageUI.Button(ESX.PlayerData.accounts[i].label, nil, {RightLabel = ''..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).. '~c~ $~s~'}, true, {
                                onSelected = function()
                                    local black, quantity = CheckQuantity(giveMoneyWallet('Que voulez-vous faire ?', nil, nil, 9))
                                    if black then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if not IsPedSittingInAnyVehicle(closestPed) then
                                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                            else
                                                ESX.ShowNotification('~r~Vous ne pouvez pas donner de l\'argent en étant dans un véhicule !~s~')
                                            end
                                        else
                                            ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                                        end
                                    else
                                        ESX.ShowNotification('~r~Montant invalide !~s~')
                                    end
                                end
                            })
                        end
                    end

                    RageUI.Line()

                    RageUI.Button('Métier', nil, {RightLabel = ESX.PlayerData.job.label.. ' - ' ..ESX.PlayerData.job.grade_label}, true, {
                        onSelected = function()
                        end
                    })

                    RageUI.Button('Groupe', nil, {RightLabel = ESX.PlayerData.job2.label.. ' - ' ..ESX.PlayerData.job2.grade_label}, true, {
                        onSelected = function()
                        end
                    })
                end)

                RageUI.IsVisible(identity, function()

                    RageUI.Button('Regarder sa carte d\'identité', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                        end
                    })

                    RageUI.Button('Montrer sa carte d\'identité', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                TriggerServerEvent('jsfour-idcar:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                        end
                    })

                    RageUI.Line()

                    RageUI.Button('Regarder son permis de conduire', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                        end
                    })

                    RageUI.Button('Montrer son permis de conduire', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end 
                        end
                    })

                    RageUI.Line()

                    RageUI.Button('Regarder son permis de port d\'arme', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                        end
                    })

                    RageUI.Button('Montrer son permis de port d\'arme', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                        end
                    })
                
                end)

                RageUI.IsVisible(clothes, function()

                    RageUI.Button('Enlever t-shirt', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:tshirt')
                        end
                    })

                    RageUI.Button('Enlever pantalon', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:pants')
                        end
                    })

                    RageUI.Button('Enlever chaussures', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:shoes')
                        end
                    })

                    RageUI.Button('Accessoires', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, accessories) 
                
                end)

                RageUI.IsVisible(accessories, function()

                    RageUI.Button('Enlever sac', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:sac')
                        end
                    })

                    RageUI.Button('Enlever masque', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:mask')
                        end
                    })

                    RageUI.Button('Enlever chapeau', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:hat')
                        end
                    })

                    RageUI.Button('Enlever lunettes', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:glasses')
                        end
                    })

                    RageUI.Button('Enlever gilet', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                        onSelected = function()
                            TriggerEvent('marlo:gpb')
                        end
                    })
                
                end)

                RageUI.IsVisible(settings, function()

                    RageUI.Checkbox('Activer GPS 3D', nil, minimap, {}, {
                        onChecked = function()
                            minimap = true
                            DisplayRadar(false)
                        end,
                        onUnChecked = function()
                            minimap = false
                            DisplayRadar(true)
                        end
                    })

                    RageUI.Checkbox('Mode cinématique', nil, cinematic, {}, {
                        onChecked = function()
                            cinematic = true
                            SendNUIMessage({openCinema = true})
                            TriggerEvent('esx_status:setDisplay', 0.0)
                            DisplayRadar(false)
                        end,
                        onUnChecked = function()
                            cinematic = false
                            SendNUIMessage({openCinema = false})
                            TriggerEvent('esx_status:setDisplay', 1.0)
                            DisplayRadar(true)
                        end
                    })

                end)

                RageUI.IsVisible(gestionCar, function()

                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                    RageUI.Button('Informations sur votre véhicule', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, getInformationCar)

                    RageUI.Line()

                    RageUI.Checkbox('Activer le moteur', nil, engine, {}, {
                        onChecked = function()
                            engine = true
                            if GetIsVehicleEngineRunning(vehicle) then
                                SetVehicleEngineOn(vehicle, false, false, true)
                                SetVehicleUndriveable(vehicle, true)
                            end
                        end,
                        onUnChecked = function()
                            engine = false
                            if not GetIsVehicleEngineRunning(vehicle) then
                                SetVehicleEngineOn(vehicle, true, false, true)
                                SetVehicleUndriveable(vehicle, false)
                            end
                        end
                    })

                    RageUI.Button('Gestion des portes', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                        end
                    }, secondGestionCar)
                
                end)

                RageUI.IsVisible(getInformationCar, function()

                    local playerPed = PlayerPedId()
                    local getPedinCar = GetVehiclePedIsUsing(playerPed)
                    local nameCar = GetDisplayNameFromVehicleModel(GetEntityModel(getPedinCar))
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local engine = GetVehicleEngineHealth(vehicle)/10
                    local secondEngine = math.floor(engine)

                    if nameCar == 'CARNOTFOUND' then
                        RageUI.CloseAll()
                    else
                        RageUI.Button('Nom du véhicule', nil, {RightLabel = nameCar}, true, {
                            onSelected = function()
                            end
                        })
                    end

                    RageUI.Button('Plaque du véhicule', nil, {RightLabel = GetVehicleNumberPlateText(getPedinCar)}, true, {
                        onSelected = function()
                        end
                    })

                    RageUI.Button('État du moteur', nil, {RightLabel = secondEngine..' %'}, true, {
                        onSelected = function()
                        end
                    })

                end)

                RageUI.IsVisible(secondGestionCar, function()

                    RageUI.Checkbox('Capot', nil, capot, {}, {
                        onChecked = function()
                            capot = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.hood then
                                personal.gestionCar.select.hood = true
                                SetVehicleDoorOpen(vehicle, 4, false, false)
                            end
                        end,
                        onUnChecked = function()
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            capot = false
                            if personal.gestionCar.select.hood then
                                personal.gestionCar.select.hood = false
                                SetVehicleDoorShut(vehicle, 4, false, false)
                            end
                        end
                    })

                    RageUI.Checkbox('Coffre', nil, trunk, {}, {
                        onChecked = function()
                            trunk = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.trunk then
                                personal.gestionCar.select.trunk = true
                                SetVehicleDoorOpen(vehicle, 5, false, false)
                            end
                        end,
                        onUnChecked = function()
                            trunk = false
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if personal.gestionCar.select.trunk then
                                personal.gestionCar.select.trunk = false
                                SetVehicleDoorShut(vehicle, 5, false, false)
                            end
                        end
                    })

                    RageUI.Checkbox('Porte avant gauche', nil, doorFrontLeft, {}, {
                        onChecked = function()
                            doorFrontLeft = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.doorFrontLeft then
                                personal.gestionCar.select.doorFrontLeft = true
                                SetVehicleDoorOpen(vehicle, 0, false, false)
                            end
                        end,
                        onUnChecked = function()
                            doorFrontLeft = false
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if personal.gestionCar.select.doorFrontLeft then
                                personal.gestionCar.select.doorFrontLeft = false
                                SetVehicleDoorShut(vehicle, 0, false, false)
                            end
                        end
                    })

                    RageUI.Checkbox('Porte avant droite', nil, doorFrontRight, {}, {
                        onChecked = function()
                            doorFrontRight = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.doorFrontRight then
                                personal.gestionCar.select.doorFrontRight = true
                                SetVehicleDoorOpen(vehicle, 1, false, false)
                            end
                        end,
                        onUnChecked = function()
                            doorFrontRight = false
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if personal.gestionCar.select.doorFrontRight then
                                personal.gestionCar.select.doorFrontRight = false
                                SetVehicleDoorShut(vehicle, 1, false, false)
                            end
                        end
                    })

                    RageUI.Checkbox('Porte arrière gauche', nil, doorBackLeft, {}, {
                        onChecked = function()
                            doorBackLeft = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.doorBackLeft then
                                personal.gestionCar.select.doorBackLeft = true
                                SetVehicleDoorOpen(vehicle, 2, false, false)
                            end
                        end,
                        onUnChecked = function()
                            doorBackLeft = false
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if personal.gestionCar.select.doorBackLeft then
                                personal.gestionCar.select.doorBackLeft = false
                                SetVehicleDoorShut(vehicle, 2, false, false)
                            end
                        end
                    })

                    RageUI.Checkbox('Porte arrière droite', nil, doorBackRight, {}, {
                        onChecked = function()
                            doorBackRight = true
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not personal.gestionCar.select.doorBackRight then
                                personal.gestionCar.select.doorBackRight = true
                                SetVehicleDoorOpen(vehicle, 3, false, false)
                            end
                        end,
                        onUnChecked = function()
                            doorBackRight = false
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if personal.gestionCar.select.doorBackRight then
                                personal.gestionCar.select.doorBackRight = false
                                SetVehicleDoorShut(vehicle, 3, false, false)
                            end
                        end
                    })
                
                end)

                RageUI.IsVisible(entreprise, function()

                    RageUI.Button('Recruter une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:recruitPlayer', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
                            end
                        end
                    })

                    RageUI.Button('Promouvoir une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:promotePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })

                    RageUI.Button('Destituer une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:demotePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })

                    RageUI.Button('Virer une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:removePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })

                end)

                RageUI.IsVisible(organisation, function()

                    RageUI.Button('Recruter une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:recruitPlayer', GetPlayerServerId(closestPlayer), ESX.PlayerData.job2.name, 0)
                            end
                        end
                    })

                    RageUI.Button('Promouvoir une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:promotePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })

                    RageUI.Button('Destituer une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:demotePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })

                    RageUI.Button('Virer une personne', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            else
                                TriggerServerEvent('personal:removePlayer', GetPlayerServerId(closestPlayer))
                            end
                        end
                    })
                
                end)

                RageUI.IsVisible(insideInventory, function()

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    RageUI.Button('Utiliser', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            if personal.itemSelected.usable then
                                TriggerServerEvent('esx:useItem', personal.itemSelected.name)
                            end
                        end
                    })

                    RageUI.Button('Donner', nil, {RightLabel = '→'}, closestPlayer ~= -1 and closestDistance <= 3, {
                        onHovered = function()
                            if closestPlayer ~= -1 and closestDistance <= 3 then
                                PlayerMarker(closestPlayer)
                            end
                        end,
                        onSelected = function()
                            local sonner, quantity =  CheckQuantity(KeyboardInput('Que voulez-vous faire ?', nil, nil, 100))
                            if sonner then
                                local closestPed = GetPlayerPed(closestPlayer)
                                if IsPedOnFoot(closestPed) then
                                    if quantity > personal.itemSelected.count then
                                        ESX.ShowNotification('~r~Nombre d\'items invalide !~s~')
                                    else
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', personal.itemSelected.name, quantity)
                                    end
                                    --ESX.ShowNotification('Vous avez donné '..quantity.. ' '..personal.itemSelected.label) -- Désactiver, car la notification est déjà notifié dans le locale de l'es_extended.
                                else
                                    ESX.ShowNotification('~r~Vous ne pouvez pas donner d\'objets dans un véhicule !~s~')
                                end
                            end
                        end
                    }) 

                    RageUI.Button('Jeter', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            if personal.itemSelected.canRemove then
                                local post, quantity = CheckQuantity(KeyboardInput('Que voulez-vous faire ?', nil, nil, 100))
                                if post then
                                    if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_standard', personal.itemSelected.name, quantity)
                                        --ESX.ShowNotification('Vous avez jeté '..quantity.. ' '..personal.itemSelected.label) -- Désactiver car la notification est déjà notifié dans le locale de l'es_extended.
                                    end
                                end
                            else
                                ESX.ShowNotification('~r~Vous ne pouvez pas jeter cet objet !~s~')
                            end
                        end
                    })

                end)

                RageUI.IsVisible(administration, function()

                    RageUI.Checkbox('Prendre son service', nil, service, {}, {
                        onChecked = function()
                            service = true
                            TriggerServerEvent('logsPersonal:takeService')
                        end,
                        onUnChecked = function()
                            service = false
                            TriggerServerEvent('logsPersonal:leaveService')
                        end
                    })

                    if service then

                        RageUI.Button('Gestion des joueurs', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, gestionPlayer)

                        RageUI.Button('Gestion des véhicules', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, gestionCarAdministration)

                        RageUI.Button('Utilitaires', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, utilitary)

                    end
                end)

                RageUI.IsVisible(gestionPlayer, function()

                    players = {}

                    for _,player in ipairs (GetActivePlayers()) do
                        local ped = GetPlayerPed(player)
                        table.insert(players, player)
                    end

                    if service then

                        RageUI.Separator('Nombre de joueurs en ligne : ' ..#players)

                        for k,v in ipairs (personal.serversIdSession) do
                            if GetPlayerName(GetPlayerFromServerId(v)) == '**Invalid**' then table.remove(personal.serversIdSession, k) end
                            RageUI.Button('['..v..'] ' ..GetPlayerName(GetPlayerFromServerId(v)), nil, {RightLabel = '→'}, true, {
                                onSelected = function()
                                    idSelected = v
                                end
                            }, managePlayer)

                        end
                    end
                end)

                RageUI.IsVisible(gestionCarAdministration, function()

                    if service then

                        RageUI.Button('Supprimer un véhicule', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                local playerPed = PlayerPedId()
                                local getPedinCar = GetVehiclePedIsUsing(playerPed)
                                local nameCar = GetDisplayNameFromVehicleModel(GetEntityModel(getPedinCar))
                                 ExecuteCommand('dv')
                                 TriggerServerEvent('logsPersonal:deleteVehicle', GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
                            end
                        })

                        RageUI.Button('Faire apparaître un véhicule', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                local getPlayerPed = GetPlayerPed()
                                local carName = KeyboardInput('Que voulez-vous faire ?', nil, 100)
                                if carName and IsModelValid(carName) and IsModelAVehicle(carName) then
                                    RequestModel(carName)
                                    while not HasModelLoaded(carName) do
                                        Citizen.Wait(0)
                                    end
                                    local createVehicle = CreateVehicle(GetHashKey(carName), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), createVehicle, -1)
                                    TriggerServerEvent('logsPersonal:addVehicle', GetDisplayNameFromVehicleModel(GetEntityModel(createVehicle)))
                                    Citizen.Wait(50)
                                else
                                    ESX.ShowNotification('~r~Véhicule invalide !~s~')
                                end
                            end
                        })

                        RageUI.Button('Réparer', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                local GetPed = GetVehiclePedIsIn(PlayerPedId(), false)
                                SetVehicleFixed(GetPed)
                                SetVehicleDirtLevel(GetPed, 0.0)
                            end
                        })

                        RageUI.Button('Changer la plaque', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                if IsPedSittingInAnyVehicle(PlayerPedId()) then
                                    local plateVehicle = KeyboardInput('Que voulez-vous faire ?', nil, 8)
                                    SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false) , plateVehicle)
                                    ESX.ShowNotification('Vous avez changé la plaque du véhicule en '..plateVehicle.. '.')
                                else
                                    ESX.ShowNotification('~r~Vous devez être dans un véhicule !~s~')
                                end
                            end
                        })

                    end
                end)

                RageUI.IsVisible(managePlayer, function()

                    if service then

                        RageUI.Separator('Joueur sélectionné : '..GetPlayerName(GetPlayerFromServerId(idSelected)))

                        RageUI.Button('Soigner '..GetPlayerName(GetPlayerFromServerId(idSelected)), nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                if idSelected then
                                    ExecuteCommand('heal '..idSelected)
                                    ESX.ShowNotification(GetPlayerName(GetPlayerFromServerId(idSelected))..' a bien été soigné.')
                                    TriggerServerEvent('logsPersonal:heal', idSelected)
                                end
                            end
                        })

                        RageUI.Button('Vous téléporter à '..GetPlayerName(GetPlayerFromServerId(idSelected)), nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                ExecuteCommand('goto '..idSelected)
                                ESX.ShowNotification('Vous avez été téléporté sur '..GetPlayerName(GetPlayerFromServerId(idSelected)).. ' !')
                                TriggerServerEvent('logsPersonal:teleportToThePlayer', idSelected)
                            end
                        })

                        RageUI.Button('Téléporter '..GetPlayerName(GetPlayerFromServerId(idSelected)).. ' à vous', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                ExecuteCommand('bring '..idSelected)
                                ESX.ShowNotification(GetPlayerName(GetPlayerFromServerId(idSelected))..' a bien été téléporté à vous !')
                                TriggerServerEvent('logsPersonal:teleporterSomeone', idSelected)
                            end
                        })

                        RageUI.Checkbox('Freeze / Unfreeze', nil, localForFreeze, {}, {
                            onChecked = function()
                                localForFreeze = true
                                ExecuteCommand('freeze '..idSelected)
                                ESX.ShowNotification(GetPlayerName(GetPlayerFromServerId(idSelected))..' a bien été freeze !')
                                TriggerServerEvent('logsPersonal:freeze', idSelected)
                            end,
                            onUnChecked = function()
                                localForFreeze = false
                                ExecuteCommand('unfreeze '..idSelected)
                                ESX.ShowNotification(GetPlayerName(GetPlayerFromServerId(idSelected))..' a bien été unfreeze !')
                                TriggerServerEvent('logsPersonal:unfreeze', idSelected)
                            end
                        })

                        RageUI.Button('Vider l\'inventaire', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                ExecuteCommand('clearinventory '..idSelected)
                                ESX.ShowNotification('L\'inventaire de '..GetPlayerName(GetPlayerFromServerId(idSelected))..' a bien été éffacé !')
                                TriggerServerEvent('logsPersonal:clearInventory', idSelected)
                            end
                        })

                    end
                end)

                RageUI.IsVisible(utilitary, function()

                    if service then

                        RageUI.List('S\'octroyer de l\'argent', indexNameMoney, indexMoney, nil, {}, true, {
                            onSelected = function()
                                giveTypeMoney(indexMoney)
                            end,
                            onListChange = function(Index)
                                indexMoney = Index
                            end
                        })

                        RageUI.Button('Positions', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, copyPositionforUtilitary)

                        RageUI.Checkbox('Noclip', nil, crossthemap, {}, {
                            onChecked = function()
                                crossthemap = true
                                mNoClip()
                            end,
                            onUnChecked = function()
                                crossthemap = false
                                mNoClip()
                            end
                        })

                        RageUI.Button('Téléporter sur son marqueur', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                                ExecuteCommand('tpm')
                            end
                        })

                    end
                end)

                RageUI.IsVisible(copyPositionforUtilitary, function()

                    local coords = GetEntityCoords(PlayerPedId())
                    local x, y, z = table.unpack(coords)
                    local heading = GetEntityHeading(PlayerPedId())

                    RageUI.Button('X - Y - Z', 'Outil de développement, mais peut-être utilisé par l\'administration, cela printera votre position dans l\'F8', {RightLabel = '→'}, true, {
                        onSelected = function()
                            print('{x = '..x..', y = '..y..', z = '..z..'}')
                        end
                    })

                    RageUI.Button('Vector3', 'Outil de développement, mais peut-être utilisé par l\'administration, cela printera votre position dans l\'F8', {RightLabel = '→'}, true, {
                        onSelected = function()
                            print('vector3('..x..', '..y..', '..z..')')
                        end
                    })

                    RageUI.Button('Heading', 'Outil de développement, mais peut-être utilisé par l\'administration, cela printera votre position dans l\'F8', {RightLabel = '→'}, true, {
                        onSelected = function()
                            print(heading)
                        end
                    })
                
                end)

            else
                RageUI.Visible(main, false)
                RageUI.Visible(aboutMe, false)
                RageUI.Visible(inventory, false)
                RageUI.Visible(weapon, false)
                RageUI.Visible(insideWeapon, false)
                RageUI.Visible(insideInventory, false)
                RageUI.Visible(wallet, false)
                RageUI.Visible(identity, false)
                RageUI.Visible(clothes, false)
                RageUI.Visible(accessories, false)
                RageUI.Visible(settings, false)
                RageUI.Visible(gestionCar, false)
                RageUI.Visible(getInformationCar, false)
                RageUI.Visible(secondGestionCar, false)
                RageUI.Visible(entreprise, false)
                RageUI.Visible(organisation, false)
                RageUI.Visible(administration, false)
                RageUI.Visible(gestionPlayer, false)
                RageUI.Visible(utilitary, false)
                RageUI.Visible(copyPositionforUtilitary, false)
                RageUI.Visible(gestionCarAdministration, false)
                RageUI.Visible(managePlayer, false)
                if not RageUI.Visible(main) and not RageUI.Visible(aboutMe) and not RageUI.Visible(inventory) and not RageUI.Visible(weapon) and not RageUI.Visible(insideWeapon) and not RageUI.Visible(insideInventory) and not RageUI.Visible(wallet) and not RageUI.Visible(identity) and not RageUI.Visible(clothes) and not RageUI.Visible(accessories) and not RageUI.Visible(settings) and not RageUI.Visible(gestionCar) and not RageUI.Visible(getInformationCar) and not RageUI.Visible(secondGestionCar) and not RageUI.Visible(entreprise) and not RageUI.Visible(organisation) and not RageUI.Visible(administration) and not RageUI.Visible(gestionPlayer) and not RageUI.Visible(utilitary) and not RageUI.Visible(copyPositionforUtilitary) and not RageUI.Visible(gestionCarAdministration) and not RageUI.Visible(managePlayer) then
                    main = RMenu:DeleteType('main', true)
                end
                return false
            end
        end
    end

Keys.Register('F5', 'F5', 'Ouvrir le menu personnel.', function()
    Menu.Toggle = not Menu.Toggle
    if Menu.Toggle then 
    openPersonal()
else
    main = RMenu:DeleteType('main', true) 
    end
end)

local noclip = false
local noclip_speed = 1.0

function mNoClip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then -- activé
    SetEntityInvincible(ped, true)
	SetEntityVisible(ped, false, false)
	invisible = true
	ESX.ShowNotification('~g~Noclip activé !~s~ ')
  else -- désactivé
    SetEntityInvincible(ped, false)
	SetEntityVisible(ped, true, false)
	invisible = false
	ESX.ShowNotification('~r~Noclip désactivé !~s~')
  end
end

function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
  end
  
  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
  
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
  
    local len = math.sqrt(x*x+y*y+z*z)
if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
end
  
    return x,y,z
end
  
function isNoclip()
    return noclip
end
  
  Citizen.CreateThread(function()
      while true do
        local Timer = 500
        if noclip then
          local ped = PlayerPedId()
          local x,y,z = getPosition()
          local dx,dy,dz = getCamDirection()
          local speed = noclip_speed
    
          -- reset du velocity
          SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
          Timer = 0  
          -- aller vers le haut
          if IsControlPressed(0,32) then -- MOVE UP
            x = x+speed*dx
            y = y+speed*dy
            z = z+speed*dz
          end
    
          -- aller vers le bas
          if IsControlPressed(0,269) then -- MOVE DOWN
            x = x-speed*dx
            y = y-speed*dy
            z = z-speed*dz
          end
    
          SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
        end
        Citizen.Wait(Timer)
    end
end)
