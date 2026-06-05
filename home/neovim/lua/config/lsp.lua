require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls' }, -- hapus nil_ls
})

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})

-- Konfigurasi nil_ls manual, asumsi binary 'nil' sudah ada di PATH
lspconfig.nil_ls.setup({})
