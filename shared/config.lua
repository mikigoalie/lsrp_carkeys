Config = {
    LockingRange = 5.0,
    CycleVehicleClass = 13,
    Keyitem = "carkey",
    Locale = 'en',
    SQL_vehicle = "owned_vehicles",
    KeyPrice = 7500,
    Locales = {
        ['en'] = {
            ['lock_vehicle'] = 'Vozidlo odemknuto',
            ['unlock_vehicle'] = 'Vozidlo zamknuto',
            ['plate'] = 'SPZ:',
            ['code'] = 'Kod',
            ['open_keyshop'] = 'Open keyshop',
            ['shop_title'] = 'Keyshop',
            ['not_your_vehicle'] = 'Toto vozidlo ti nepatří',
            ['bought_key'] = 'Koupil sis nové klíče k vozidlu',
            ['not_enough_money'] = 'Nemáš dostatek peněz',
            ['buy_key'] = 'Do you want to buy a key for your vehicle?',
            ['yes'] = 'Yes',
            ['no'] = 'No'
        },
        ['cs'] = {
            ['lock_vehicle'] = 'Vehicle locked',
            ['unlock_vehicle'] = 'Vehicle unlocked',
            ['plate'] = 'Plate',
            ['code'] = 'Plate2',
            ['open_keyshop'] = 'Open keyshop',
            ['shop_title'] = 'Keyshop',
            ['not_your_vehicle'] = 'This is not your vehicle',
            ['bought_key'] = 'You bought a key for your vehicle',
            ['not_enough_money'] = 'You do not have enough money',
            ['buy_key'] = 'Do you want to buy a key for your vehicle?',
            ['yes'] = 'Yes',
            ['no'] = 'No'
        }
    },
    Notification = function(message)
        ESX.ShowNotification(message)
    end,
    KeyShop = {
        Ped = {
            Position = vector3(-36.9830, -1088.3978, 26.4224)
        }
    }
}

Lang = Config.Locales[Config.Locale]