fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'jaksam1074'

version '3.21'

shared_scripts {
    '@qb-core/import.lua',
    'sh_config.lua',
    'shared/shared.lua',
    'locales/*.lua'
}

client_scripts {
    'cl_config.lua',
    'client/actions/*.lua',
    'client/markers/*.lua',
    'client/main.lua',
    'client/nui_callbacks.lua'
}

server_scripts {
    'sv_config.lua',
    'server/functions.lua',
    'server/actions.lua',
    'server/markers/*.lua',
    'server/qb_callbacks.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/images/*'
}
