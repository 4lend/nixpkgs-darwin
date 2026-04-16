{ pkgs, config, ... }:

let
  packages = with pkgs; [

    # technical
    android-tools
    adbfs-rootless
    pay-respects
    # adb-sync  # Broken

    # terminal
    ghq
    tmuxinator # Manage complex tmux sessions easily
    cmatrix
    tig
    lazygit
    git-crypt
    gitkraken
    cmus
    # smartgithg
    # gh
    # glab
    # # gitlab
    # # gitlab-ee
    # # gitlab-shell
    # # gitlab-pages
    ranger  # findutils  mlocate  
    lf
    # deer
    # # pistol
    eza
    bat
    # terminal-typeracer
    # ttyper
    # internetarchive
    # vim
    # spacevim
    duf
    # neovide
    # z-lua
    # peco
    autojump
    # pazi
    # fasd
    # yank
    # xsel
    # xclip
    # mov-cli
    vifm
    wget
    # pinentry  # GnuPG’s interface to passphrase input | need by gnupg / gpg generate keys
    # bro
    # cheat  # Create and view interactive cheatsheets on the command-line
    # cht-sh  # CLI client for cheat.sh, a community driven cheat sheet
    # navi  # An interactive cheatsheet tool for the command-line and application launchers
    # tealdeer  # A very fast implementation of tldr in Rust
    # wiki-tui  # A simple and easy to use Wikipedia Text User Interface
    # fltrdr  # A TUI text reader for the terminal
    # pssh
    # cowsay
    fontconfig
    google-fonts

    # terminal display system information
    dwt1-shell-color-scripts
    pokemon-colorscripts-mac
    btop
    htop
    neofetch
    bottom
    checkip
    freshfetch
    ipfetch
    pfetch
    hyfetch
    pridefetch

    # nix
    nix
    nix-index
    nix-prefetch
    nix-prefetch-hg
    nix-prefetch-git
    nix-prefetch-github
    nix-prefetch-scripts
    nix-prefetch-docker

    # Downloader
    gdown
    instaloader
    gallery-dl
  ];

  language = (with pkgs; [
    dbus
    yarn
    yarn2nix
    jq
    nodejs
    apacheHttpd
    cachix
    direnv
    nix-direnv
  ]) ++ (with pkgs.nodePackages_latest; [
    pnpm
    npm-check-updates
  ]) ++ (with pkgs.python313Packages; [
    pip
    dbus-python
    urllib3
    selenium
    # selenium-wire
  ]) ++ (with pkgs.luajitPackages; [
    luarocks
  ]) ++ (with pkgs.nodePackages; [
    typescript-language-server
  ]) ++ (with pkgs; [
    # nixfmt-rfc-style
    nixpkgs-fmt
    lua-language-server
    # lua51Packages.lua-lsp
    stylua
    python311Packages.pynvim
    python310Packages.pynvim
    ueberzugpp
    rxvt-unicode
    ripgrep
    ripgrep-all
    vgrep
    gcc
  ]);

in
{
  nixpkgs.config = { 
    allowUnfree = true; 
  };
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"  # etcher
    "python-2.7.18.6"
  ];
  home.packages = packages ++ language;

  # home.packages = packages ++ xfcePkgs ++ gnomeExtension;
  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = pkgs.nur.repos.congee.sncli.pkgs;
  # };
}
