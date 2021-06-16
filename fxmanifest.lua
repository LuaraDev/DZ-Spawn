fx_version 'cerulean'
games { 'gta5' }
author 'dz-security.live'

client_script 'client/cl_main.lua'
client_script 'config.lua'
server_script 'server/sv_main.lua'
server_script 'config.lua'
server_script '@mysql-async/lib/MySQL.lua'

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}