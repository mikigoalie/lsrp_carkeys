CreateThread(function()
    while GetResourceState('ox_inventory') ~= 'started' do
        Wait(100)
    end
    local Inventory = exports.ox_inventory
    --Inventory:displayMetadata('plate', Lang['plate'])
end)

CreateThread(function()
    while true do
        local sleep = 1000
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
        if(GetDistanceBetweenCoords(coords, Config.KeyShop.Ped.Position.x,Config.KeyShop.Ped.Position.y,Config.KeyShop.Ped.Position.z, true) < 20.0) then
            sleep = 0
            DrawEmoji3D(Config.KeyShop.Ped.Position.x,Config.KeyShop.Ped.Position.y,Config.KeyShop.Ped.Position.z, "🔑")
            if (GetDistanceBetweenCoords(coords, Config.KeyShop.Ped.Position.x,Config.KeyShop.Ped.Position.y,Config.KeyShop.Ped.Position.z, true) < 8.0) then
                if IsControlJustReleased(0, 38) then
                    if IsPedInAnyVehicle(ped, false) then
                        local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, false))
                        TriggerServerEvent('carkeys:server:buyKey', plate)
                    else
                        sleep = 1000
                        TriggerEvent("swt_notifications:Icon","Aby sis vyměnil zámek, musíš sedět ve vozidle..","top",2500,"negative","white",false,"mdi-car-key")
                    end
                end
            end
        else
            sleep = 2000
        end
        Citizen.Wait(sleep)
    end
end)

function DrawEmoji3D(x, y, z, text)
	SetTextScale(0.6, 0.6)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(20, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end


CreateThread(function()
    local blip = AddBlipForCoord(Config.KeyShop.Ped.Position)
    SetBlipSprite(blip, 811)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang['shop_title'])
    EndTextCommandSetBlipName(blip)
end)

AddEventHandler('carkeys:client:useKey', function(data)
    local plate = data.metadata.pl
    local code = data.metadata.code
    local ped = PlayerPedId()
    while #plate < 8 do
        plate = plate .. ' '
    end
    local vehCode = lib.callback.await('carkeys:callback:codeCheck', false, code, plate)
    local vehicle = GetVehicleInDistanceByPlate(plate, Config.LockingRange)
    if vehCode == true then
        if vehicle then
            ToggleVehicleLock(vehicle)
        else
            TriggerEvent("swt_notifications:Icon","Nemáš poblíž žádné vozidlo, od kterého by jsi měl klíče","top",2500,"negative","white",false,"mdi-car-key")
        end
    elseif vehCode == "klíč" then
        TriggerEvent("swt_notifications:Icon","Zámek na tomto vozidle byl vyměněný, tento klíč vozidlo neotevře.","top",2500,"negative","white",false,"mdi-car-key")
    else
        TriggerEvent("swt_notifications:Icon","Nastala chyba, kontaktuj adminy","top",2500,"negative","white",false,"mdi-car-key")
    end
end)

AddEventHandler('carkeys:client:buyKey', function(data)
    TriggerServerEvent('carkeys:server:buyKey', data.plate)
end)