{ pkgs, config, ... }:
let
  username = "alfurqani";
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = false;
      withPython3 = true;
      withRuby = true;

      plugins = with pkgs.vimPlugins; [
        telescope-nvim
        plenary-nvim
        nvim-tree-lua
        barbar-nvim
        lualine-nvim
        nvim-autopairs
        # indent-blankline-nvim
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        nvim-lspconfig
        mason-nvim
        mason-lspconfig-nvim
        nvim-web-devicons
        nightfox-nvim
        kanagawa-nvim
      ];

      extraConfig = ''
        luafile ${configHome}/nixpkgs/home/neovim/lua/settings.lua
        luafile ${configHome}/nixpkgs/home/neovim/lua/maps.lua
      '';
    };
  };
}
