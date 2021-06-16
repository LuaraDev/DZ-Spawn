-- https://dz-security.live

RegisterServerEvent('dz-spawn:server:getdata')
AddEventHandler('dz-spawn:server:getdata', function()
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @id', {
        ['@id'] = GetPlayerIdentifiers(src)[1]
    }, function(data)
        local global = json.decode(data[1]['position'])
        local position = {}
        position['x'] = global.x
        position['y'] = global.y
        position['z'] = global.z
        TriggerClientEvent("dz-spawner:client:GetData", src, position)
    end)
end)