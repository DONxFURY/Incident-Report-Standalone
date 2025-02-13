-- server.lua
ESX = exports['es_extended']:getSharedObject()

local cooldown = {}
local webhookURL = 'YOUR_DISCORD_WEBHOOK_URL_HERE'

RegisterCommand("report", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not Config.AllowedJobs[xPlayer.job.name] then
        TriggerClientEvent('esx:showNotification', source, '~r~You don\'t have permission to use this command!')
        return
    end
    
    if cooldown[source] and os.time() - cooldown[source] < 30 then
        TriggerClientEvent('esx:showNotification', source, '~r~Please wait before submitting another report!')
        return
    end
    
    TriggerClientEvent('crimeReports:openUI', source)
    cooldown[source] = os.time()
end)

RegisterNetEvent('crimeReports:submitReport')
AddEventHandler('crimeReports:submitReport', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    local embed = {
        {
            ["title"] = "New Crime Report",
            ["description"] = data.description,
            ["fields"] = {
                {
                    ["name"] = "Reporting Officer",
                    ["value"] = xPlayer.getName(),
                    ["inline"] = true
                },
                {
                    ["name"] = "Badge Number",
                    ["value"] = xPlayer.get('badge') or 'N/A',
                    ["inline"] = true
                },
                {
                    ["name"] = "Location",
                    ["value"] = data.location,
                    ["inline"] = false
                },
                {
                    ["name"] = "Incident Time",
                    ["value"] = os.date('%Y-%m-%d %H:%M:%S'),
                    ["inline"] = true
                }
            },
            ["color"] = 16711680,
            ["footer"] = {
                ["text"] = "Crime Report System"
            }
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
    
    TriggerClientEvent('esx:showNotification', src, '~g~Report submitted successfully!')
end)