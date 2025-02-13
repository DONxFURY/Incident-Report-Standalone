fx_version 'cerulean'
game 'gta5'

author 'DONxFURY'
description 'Crime Report System'
version '1.0.0'

shared_script 'config.lua'
client_script 'client/client.lua'
server_script 'server/server.lua-- config.lua
Config = {}

-- Role Configuration (ESX Job Names)
Config.AllowedJobs = {
    ['police'] = {              -- Job name in database
        label = 'LSPD',          -- Display name (unused in code but good for reference)
        min_grade = 2,          -- Minimum grade required (0 = all ranks)
        use_badge = true         -- Require badge number to submit reports
    },
    ['sheriff'] = {
        label = 'Sheriff Office',
        min_grade = 1,
        use_badge = true
    },
    ['fib'] = {
        label = 'Federal Bureau',
        min_grade = 3,
        use_badge = true
    },
    ['admin'] = {
        label = 'Staff Team',
        min_grade = 0,
        use_badge = false
    }
}

-- Command Configuration
Config.Command = {
    name = 'report',            -- Command name
    keybind = 'F5',             -- Suggested keybind (client-side implementation needed)
    cooldown = 30               -- Seconds between report submissions
}

-- Webhook Configuration
Config.Webhook = {
    enabled = true,
    url = 'YOUR_DISCORD_WEBHOOK_URL_HERE',
    color = 16711680,           -- Embed color (Red)
    footer = 'LSPD Report System v1.0'
}

-- UI Configuration
Config.UI = {
    auto_close = true,          -- Close UI after submission
    animation_speed = 0.3       -- Animation duration in seconds
}

-- Validation Rules
Config.Validation = {
    min_title_length = 5,
    max_title_length = 60,
    min_description_length = 20,
    max_description_length = 1000
}'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css'
}

dependency 'es_extended'