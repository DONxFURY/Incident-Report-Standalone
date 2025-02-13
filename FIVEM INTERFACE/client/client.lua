-- client.lua
local isUIOpen = false

RegisterCommand("report", function()
    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
        if Config.AllowedJobs[data.job.name] then
            if not isUIOpen then
                SetNuiFocus(true, true)
                SendNUIMessage({type = 'open'})
                isUIOpen = true
            end
        else
            ESX.ShowNotification('~r~You don\'t have permission to use this!')
        end
    end)
end, false)

RegisterNUICallback('submit', function(data, cb)
    SetNuiFocus(false, false)
    isUIOpen = false
    
    TriggerServerEvent('crimeReports:submitReport', {
        title = data.title,
        description = data.description,
        location = data.location
    })
    
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    isUIOpen = false
    cb('ok')
end)