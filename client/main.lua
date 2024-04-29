QBCore = exports['qb-core']:GetCoreObject()
local ScriptPed = nil
local ScriptCam = nil
local coords = Config.SpawnLocations[math.random(1, #Config.SpawnLocations)]

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
			TriggerEvent('nMulticharacter:client:OpenMulticharacter')
            TriggerEvent("em-hud:load-data")
			return
		end
	end
end)

RegisterNetEvent('nMulticharacter:client:OpenMulticharacter', function()
    sendNuiMessage('ShowLoadingScreen')
    SetNuiFocus(false, false)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

    local ped = PlayerPedId()
    
    Wait(3000)
    TriggerServerEvent('nMulticharacter:server:SetPlayerBucked', math.random(1, 9999999))
    SetEntityCoords(PlayerPedId(), coords.x+5.0, coords.y + 5.0, coords.z)
    FreezeEntityPosition(ped, true)
    Wait(3000)

    if DoesCamExist(ScriptCam) then
        RenderScriptCams(false, true, 1000, true)
        DestroyCam(ScriptCam)
    else
        SetEntityHeading(ped, 5.0)
        ScriptCam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x+Config.CamPosition.x, coords.y+Config.CamPosition.y, coords.z+Config.CamPosition.z, 1.76, 0.0, 178.5, 25.0, true, 0)
        RenderScriptCams(true, true, 0, true)
    end

    QBCore.Functions.TriggerCallback('nMulticharacter:server:GetUserCharacters', function(result, license)
        SpawnCharacter(result[1])
        Wait(1000)
        maxChar = Config.CharacterSlot
            
        if Config.CustomCharacterSlot[license] then
            maxChar = Config.CustomCharacterSlot[license]
        end

        sendNuiMessage('OpenMulticharacter', {
            characters = result,
            canDelete = Config.CanDelete,
            maxCharacterAmount = maxChar,
            
            lang = Config.Locale[Config.Lang].ui
        })
        SetNuiFocus(true, true)
    end)
end)

RegisterNUICallback('CreateNewCharacter', function(data)
    TriggerServerEvent('nMulticharacter:server:CreateNewCharacter', data)
end)

RegisterNUICallback('CloseMulticharacter', function()
    Wait(500)
    TriggerServerEvent('nMulticharacter:server:SetPlayerBucked', 0)
    SetNuiFocus(false)
    DeleteEntity(ScriptPed)
    if DoesCamExist(ScriptCam) then
        RenderScriptCams(false, true, 1000, true)
        DestroyCam(ScriptCam)
    end
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNUICallback('SelectCharacter', function(data)
    TriggerServerEvent('nMulticharacter:server:LoadUserData', data)
end)

RegisterNUICallback('DeleteCharacter', function(data)
    TriggerServerEvent('nMulticharacter:server:DeleteCharacter', data.citizenid)
end)

RegisterNetEvent('nMulticharacter:client:UpdateCharacters', function()
    QBCore.Functions.TriggerCallback('nMulticharacter:server:GetUserCharacters', function(result)
        sendNuiMessage('UpdateCharacters', {
            characters = result
        })
    end)
end)

RegisterNUICallback('ChangeSelectedCharacter', function(CharacterData)
    SpawnCharacter(CharacterData)
end)

function SpawnCharacter(CharacterData)
    if DoesEntityExist(OldScriptPed) then
        DeleteEntity(OldScriptPed)
    end
    if DoesEntityExist(ScriptPed) then
        OldScriptPed = ScriptPed
        SetEntityAsMissionEntity(OldScriptPed, true, true)
        TaskGoStraightToCoord(OldScriptPed, coords.x+1.5, coords.y, coords.z, 1.0, 1.0, 10.0, 0)
    end

    if CharacterData ~= nil then
        QBCore.Functions.TriggerCallback('nMulticharacter:server:GetPlayerSkin', function(skinData)
            if not skinData then
                return false
            end
            local model = joaat(skinData.model)
            if model ~= nil then
                CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    ScriptPed = CreatePed(2, model, coords.x-3.0, coords.y, coords.z -1.0, 10.0, false, true)
                    SetPedComponentVariation(ScriptPed, 0, 0, 0, 2)
                    FreezeEntityPosition(ScriptPed, false)
                    SetEntityInvincible(ScriptPed, true)
                    PlaceObjectOnGroundProperly(ScriptPed)
                    SetBlockingOfNonTemporaryEvents(ScriptPed, true)
                    exports['illenium-appearance']:setPedAppearance(ScriptPed, skinData)
                    -- TriggerEvent('qb-clothing:client:loadPlayerClothing', data, ScriptPed)
                    TaskGoStraightToCoord(ScriptPed, coords.x, coords.y, coords.z, 1.0, 1.0, 10.0, 0)
                end)
            else
                CreateThread(function()
                    local randommodels = {
                        'mp_m_freemode_01',
                        'mp_f_freemode_01',
                    }
                    model = joaat(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    ScriptPed = CreatePed(2, model, coords.x-3.0, coords.y, coords.z -1.0, 10.0, false, true)
                    SetPedComponentVariation(ScriptPed, 0, 0, 0, 2)
                    FreezeEntityPosition(ScriptPed, false)
                    SetEntityInvincible(ScriptPed, true)
                    PlaceObjectOnGroundProperly(ScriptPed)
                    SetBlockingOfNonTemporaryEvents(ScriptPed, true)
                    TaskGoStraightToCoord(ScriptPed, coords.x, coords.y, coords.z, 1.0, 1.0, 10.0, 0)
                end)
            end
        end, CharacterData.citizenid)
    else
        CreateThread(function()
            local randommodels = {
                'mp_m_freemode_01',
                'mp_f_freemode_01',
            }
            local model = joaat(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            ScriptPed = CreatePed(2, model, coords.x-3.0, coords.y, coords.z -1.0, 10.0, false, true)
            SetPedComponentVariation(ScriptPed, 0, 0, 0, 2)
            FreezeEntityPosition(ScriptPed, false)
            SetEntityInvincible(ScriptPed, true)
            PlaceObjectOnGroundProperly(ScriptPed)
            SetBlockingOfNonTemporaryEvents(ScriptPed, true)
            TaskGoStraightToCoord(ScriptPed, coords.x, coords.y, coords.z, 1.0, 1.0, 10.0, 0)
            TriggerEvent('bad-hud:load-data')
        end)
    end
end

RegisterNetEvent('nMulticharacter:client:SendNotification', function(...)
    SendNotification(...)
end)