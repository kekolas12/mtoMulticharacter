function SendNotification(...)
    TriggerEvent('QBCore:Notify', ...)
end

function SetPlayerClothing(data, ped)
    exports['illenium-appearance']:setPedAppearance(ped, data)
end