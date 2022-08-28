fx_version 'cerulean'
game 'gta5'
name "lsrp-carkeys"
description "LSRP Carkey script"
author "mikigoalie#8158"
version "1.0.0"
lua54 'yes'
shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'shared/config.lua'
}

client_scripts {
	'client/function.lua',
	'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

dependencies {
	'ox_lib',
	'es_extended'
}
