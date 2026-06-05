-- ~/.config/nixpkgs/home/neovim/lua/config/tree.lua
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",    -- Biar sidebar-nya di kiri, sesuai keinginan lo
  },
  -- Filter file yang nggak mau lo liat
  filters = {
    dotfiles = false, -- Biar bisa liat file konfigurasi kaya .gitignore
  },
  -- Biar bisa klik2 pake mouse
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
  -- Biar ada ikon-ikon kerennya
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  -- Integrasi sama git
  git = {
    enable = true,
    ignore = true,
  },
})
