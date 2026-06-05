-- ~/.config/nixpkgs/home/neovim/lua/config/barbar-nvim.lua
require('barbar').setup({
  animation = true,
  auto_hide = false,
  tabpages = true,
  icons = { preset = 'slanted' },
  -- ✨ TAMBAHKAN KONFIGURASI INI ✨
  sidebar_filetypes = {
    ["NvimTree"] = { event = "BufWinEnter", text = "EXPLORER" }, 
  },
})
