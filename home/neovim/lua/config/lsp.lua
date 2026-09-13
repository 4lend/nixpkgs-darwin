-- Setup Mason untuk mengelola instalasi LSP server
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls' }, -- hanya lua_ls
})

-- Definisikan konfigurasi LSP untuk lua_ls
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
}

-- Aktifkan LSP server
vim.lsp.enable({ "lua_ls" })

-- asumsi binary `nil` sudah terpasang lewat Nix
vim.lsp.config.nil_ls = {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", "shell.nix", ".git" },
}
vim.lsp.enable({ "lua_ls", "nil_ls" })
