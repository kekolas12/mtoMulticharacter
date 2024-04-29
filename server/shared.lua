function GetUserCharacters(source, callback)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')

    exports.oxmysql:execute('SELECT * FROM players WHERE license = ?', {
        license
    }, function(result)
        local PlayerCharacters = {}
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            result[i].gang = json.decode(result[i].gang)
            PlayerCharacters[#PlayerCharacters+1] = result[i]
        end
        callback(PlayerCharacters)
    end)
end

function GetPlayerSkin(citizenid, callback)
    local result = MySQL.query.await('SELECT * FROM player_skins WHERE citizenid = ?', {citizenid})
    if result[1] ~= nil then
        callback(json.decode(result[1].data))
    else
        callback(nil)
    end
end

function SelectCharacter(source, data)
    QBCore.Commands.Refresh(source)
    TriggerClientEvent('nSpawn:client:OpenMenu', source, data)
end