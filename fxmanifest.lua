fx_version 'cerulean'
game 'gta5'

author 'Nano Development'
description 'Multicharacter system by Nano Development.'
version '1.0.0'

ui_page 'build/index.html'
files {
    'build/*',
	'build/**/*'
}

shared_script 'config.lua'
client_script 'client/*.lua'
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'client/shared.lua',
    'server/shared.lua'
}