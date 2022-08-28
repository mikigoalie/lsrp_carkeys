
local function AddCarkey(source, plate, code, name)
    exports.ox_inventory:AddItem(source, Config.Keyitem, 1, {pl = plate, code = code, description = "Klíče k modelu vozidla: " .. name .. "  \nSPZ: " .. plate})
end
exports('AddCarkey', AddCarkey)

lib.callback.register('carkeys:callback:getPlayerVehicles', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicles = {}
    local result = MySQL.query.await('SELECT * FROM ' .. Config.SQL_vehicle .. ' WHERE owner = ?', { xPlayer.identifier })
    if result then
        for k, v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            vehicles[#vehicles + 1] = {
                plate = vehicle.plate,
                model = vehicle.model,
                code = vehicle.code
            }
        end
        return vehicles
    end
    return false        
end)

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
end

lib.callback.register('carkeys:callback:codeCheck', function(source, c, p)
    local data = MySQL.single.await('SELECT code, plate FROM ' .. Config.SQL_vehicle .. ' WHERE plate = ?', { p })
    print(data.code)
    print(data.plate)
    if data then
        if c == data.code then
            if p == data.plate then
                return true
            else
                return false
            end
        else
            return "klíč"
        end
    end
end)

function RandomVariable(length, add)
	local res = ""
	for i = 1, length do
		res = res .. string.char(math.random(97, 122))
	end
    res = res .. add
	return res
end



RegisterNetEvent('carkeys:server:buyKey', function(plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local predklic = xPlayer.getIdentifier()
    if xPlayer then
        local code = RandomVariable(10, predklic:sub(-5))
        print(Config.SQL_vehicle)
        print(plate)
        MySQL.single('SELECT owner, code, name FROM owned_vehicles WHERE plate = ?', { plate }, function(result)
            if result then
                if result.owner == predklic then
                    print(result.name)
                    if xPlayer.getMoney() >= Config.KeyPrice then
                        MySQL.update('UPDATE ' .. Config.SQL_vehicle .. ' SET code = ? WHERE plate = ?', {code, plate}, function(affectedRows)
                            if affectedRows then
                                xPlayer.removeMoney(Config.KeyPrice)
                                AddCarkey(_source, plate, code, result.name)
                                xPlayer.showNotification(Lang['bought_key'])
                            end
                        end)
                    else
                        xPlayer.showNotification(Lang['not_enough_money'])
                    end
                else
                    xPlayer.triggerEvent("swt_notifications:Icon", "Toto není tvoje vozidlo! Nekraď auta.","top",2500,"negative","white",false,"mdi-car-key")
                end
            else
                xPlayer.showNotification(Lang['not_your_vehicle'])
            end
        end)
    end
end)