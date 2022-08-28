###### LSRP Carkeys by mikigoalie ######
This script allows you to have keys as an item by checking unique code and plate of the car
you are trying to open. Lost your keys or someone stole them? Report it to the police and
head over to locksmith to change locking key so noone will access yoru car even if they have
old keys! :)


### Reqs
- ox_inventory
- ox_lib
- es_extended

## Add the item carkey to ox_inventory/data/items.lua
```lua
['carkey'] = {
		label = 'Carkey',
		weight = 300,
		stack = false
},
```

## Add this to ox_inventory/modules/items/client.lua
```lua
Item('carkey', function(data, slot)
	TriggerEvent('carkeys:client:useKey', slot)
end)
```
 