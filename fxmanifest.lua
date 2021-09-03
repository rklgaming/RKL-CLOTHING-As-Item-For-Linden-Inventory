fx_version 'adamant'

game 'gta5'

description 'Rkl Clothing'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
     'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
    'client/main.lua'
}

dependencies {
    'es_extended',
    'esx_skin',
    'esx_datastore'
}
