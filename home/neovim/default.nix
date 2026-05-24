{ pkgs, config, ... }:
let
  username = "alfurqani";
  # TAMPARAN RASIONAL: macOS menggunakan /Users/, bukan /home/
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  configHome = "${homeDirectory}/.config";

  node = with pkgs.nodePackages; [
    typescript-language-server
  ];
  
  php = with pkgs.phpPackages; [
    psalm
    phpstan
  ];

  php82 = with pkgs.php82Packages; [
    composer
  ];

  mix = with pkgs; [
    # Ganti rnix-lsp yang sudah mati dengan nixd (Modern & Akurat)
    nixd 
    # Gunakan Formatter Standar RFC resmi komunitas Nix
    nixfmt-rfc-style 
    
    # Pembersihan duplikasi lua server
    lua-language-server
    stylua
    
    adoptopenjdk-bin
    ripgrep  
    ripgrep-all  
    vgrep  
    gcc
  ];
in
{
  config = {
    # Pastikan dependencies sistem ini terpasang agar bisa dipanggil Neovim
    # home.packages = node ++ php ++ php82 ++ mix;
    home.packages = node ++ php82 ;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = false;
      
      # Inject Treesitter parser untuk Nix secara native via Nixpkgs
      plugins = with pkgs.vimPlugins; [ 
        # --- CORE SYNTAX & LAYOUT ---
        vim-nix
        nvim-treesitter.withAllGrammars # Atau gunakan nvim-treesitter-parsers.nix jika ingin hemat space
        indent-blankline-nvim
        
        # --- TELESCOPE & CMP (AUTOCOMPLETE) ---
        plenary-nvim
        telescope-nvim
        cmp-nvim-lsp
        cmp-path
        cmp-treesitter
        
        # --- THEMES (Pilih yang esensial saja, sisanya hapus jika tidak dipakai) ---
        kanagawa-nvim
        tokyonight-nvim
        everforest
        catppuccin-nvim

        # --- CODE STRUCTURE & EDITING ---
        nvim-autopairs
        nvim-surround
        plenary-nvim
        harpoon
        
        # --- YOUR EXISTING LUA CONFIG BINDINGS ---
        { plugin = indent-blankline-nvim; config = "luafile ${configHome}/nixpkgs/home/neovim/lua/config/indent.lua"; }
        { plugin = nvim-lspconfig; config = "luafile ${configHome}/nixpkgs/home/neovim/lua/config/lsp.lua"; }
        { plugin = formatter-nvim; config = "luafile ${configHome}/nixpkgs/home/neovim/lua/config/formatter-nvim.lua"; }
        { plugin = nvim-autopairs; config = "luafile ${configHome}/nixpkgs/home/neovim/lua/config/autopairs.lua"; }
        { plugin = telescope-nvim; config = "luafile ${configHome}/nixpkgs/home/neovim/lua/config/telescope.lua"; }
      ];

      extraConfig = ''
        luafile ${configHome}/nixpkgs/home/neovim/lua/settings.lua
        luafile ${configHome}/nixpkgs/home/neovim/lua/maps.lua
      '';
    };
  };
}
