QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('nMulticharacter:server:GetUserCharacters', function(source, cb)
    local license = QBCore.Functions.GetIdentifier(source, 'license')

    GetUserCharacters(source, function(data)
        cb(data, license)
    end)
end)

function GiveStarterItems(source)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        for _, v in pairs(Config.StarterItems) do
            local info = {}
            if v.item == "id_card" then
                info.citizenid = Player.PlayerData.citizenid
                info.firstname = Player.PlayerData.charinfo.firstname
                info.lastname = Player.PlayerData.charinfo.lastname
                info.birthdate = Player.PlayerData.charinfo.birthdate
                info.gender = Player.PlayerData.charinfo.gender
                info.nationality = Player.PlayerData.charinfo.nationality
            elseif v.item == "driver_license" then
                info.firstname = Player.PlayerData.charinfo.firstname
                info.lastname = Player.PlayerData.charinfo.lastname
                info.birthdate = Player.PlayerData.charinfo.birthdate
                info.type = "Class C Driver License"
            end
            Player.Functions.AddItem(v.item, v.amount, false, info)
        end
    end

-- RegisterCommand('iremVer', function(source, args)
--     GiveStarterItems(source)
-- end)

RegisterNetEvent('nMulticharacter:server:CreateNewCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    if QBCore.Player.Login(src, false, newData) then
        local randbucket = (GetPlayerPed(src) .. math.random(1,999))
        SetPlayerRoutingBucket(src, randbucket)
        local text = (Config.Locale[Config.Lang].loaded_text):format(GetPlayerName(src))
        print(text)
        QBCore.Commands.Refresh(source)
        Wait(500)
        TriggerClientEvent('nMotel:client:createCharacter', src)
        TriggerEvent("em-hud:load-data")
        GiveStarterItems(tonumber(src))
    end
end)

RegisterNetEvent('nMulticharacter:server:LoadUserData', function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        local text = (Config.Locale[Config.Lang].loaded_text):format(GetPlayerName(src))
        print(text)
        SelectCharacter(src, cData)
        TriggerEvent('bad-hud:load-data')
    end
end)

RegisterNetEvent('nMulticharacter:server:SetPlayerBucked', function(buckedId)
    local src = source
    SetPlayerRoutingBucket(src, buckedId)
end)

RegisterNetEvent('nMulticharacter:server:DeleteCharacter', function(citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
    TriggerClientEvent('nMulticharacter:client:UpdateCharacters', src)
    TriggerClientEvent('nMulticharacter:client:SendNotification', src, 'Karakter silindi.' , 'success')
end)

QBCore.Functions.CreateCallback('nMulticharacter:server:GetPlayerSkin', function(source, cb, cid)
    GetPlayerSkin(cid, function(data)
        if data then
            cb(data)
        else
            cb(nil)
        end
    end)
end)