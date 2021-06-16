local Location = {}

RegisterNetEvent("dz-spawner:client:Setup")
AddEventHandler("dz-spawner:client:Setup", function()
    SendNUIMessage({ setup = true, locations = Config.Locations })
    Wait(100)
    TriggerScreenblurFadeIn(500)
    SetNuiFocus(true, true)
    SendNUIMessage({ show = true })
end)

RegisterNetEvent("dz-spawner:client:GetData")
AddEventHandler("dz-spawner:client:GetData", function(position)
    Location.x, Location.y, Location.z = position.x, position.y, position.z
end)

----------------------------------- https://dz-security.live ---------------------------------------------

RegisterNUICallback("Preview", function(data)
    if data.location ~= "last" then
        local Position = Config.Locations[data.location].coords
        PreviewSpawn(Position)
    else
        TriggerServerEvent("dz-spawn:server:getdata")
        Wait(250)
        local Position = Location
        PreviewSpawn(Position)
    end
end)

----------------------------------- https://dz-security.live ---------------------------------------------

RegisterNUICallback("Spawn", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({show = false})
    if (data.spawn ~= "last") then
        local Spawn = Config.Locations[data.spawn].coords
        SpawnPlayer(Spawn)
    else
        SpawnPlayer(Location)
    end
end)

----------------------------------- https://dz-security.live ---------------------------------------------

function SpawnPlayer(Location)
    local Position = Location
    local Ped = PlayerPedId()
    DoScreenFadeOut(500)
    SetEntityCoords(Ped, Position.x, Position.y, Position.z)
    SetEntityCoords(Ped, Position.x, Position.y, Position.z)
    FreezeEntityPosition(Ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(GetPlayerPed(-1), true)
    DoScreenFadeIn(250)
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false, false)
end

function PreviewSpawn(Position)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + 1500, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, Position.x, Position.y, Position.z + 75)
    SetCamActiveWithInterp(cam2, cam, 500, true, true)
    if DoesCamExist(cam) then DestroyCam(cam, true) end
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Position.x, Position.y, Position.z + 50, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam, Position.x, Position.y, Position.z + 0)
    SetCamActiveWithInterp(cam, cam2, 1000, true, true)
    SetEntityCoords(GetPlayerPed(-1), Position.x, Position.y, Position.z)
end