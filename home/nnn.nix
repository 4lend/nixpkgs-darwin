# home/nnn.nix
{ config, pkgs, lib, ... }:

let
  nnnPackage = pkgs.nnn.override {
    withNerdIcons = true;
  };

  pluginMappings = {
    p = "preview-tui";
    f = "fzcd";
    z = "zoxide";
    t = "treeview";      # 🔥 Plugin tree view, tekan 't' untuk lihat pohon direktori
  };
  nnnPlug = lib.concatStrings (lib.mapAttrsToList (key: name: "${key}:${name}") pluginMappings);
in
{
  home.packages = [ nnnPackage ];

  home.sessionVariables = {
    NNN_BMS = "d:~/Downloads;D:~/Documents;c:~/.config;n:~/.config/nixpkgs;h:~;";
    NNN_OPTS = "HCdU";
    NNN_COLORS = "1234";              # 🔥 4 context dengan warna berbeda
    NNN_FCOLORS = "c1e2272e006033f7c6d6abc4";
    NNN_PLUG = nnnPlug;
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_PREVIEW = 1;
    NNN_ICONLOOKUP = 1;
    EDITOR = "nvim";
  };

  home.file = {
    ".config/nnn/plugins".source = pkgs.fetchFromGitHub {
      owner = "jarun";
      repo = "nnn";
      rev = "v4.7";
      sha256 = "sha256-ttG0aEqMlNyJaMhcVfrxbxlrhr1GSydrV58CYSq4CTM=";
    } + "/plugins";

    ".local/bin/nnn-previewer".source = pkgs.writeShellScript "nnn-previewer" ''
      #!/bin/sh
      file="$1"
      mime=$(file --mime-type -b "$file")
      case "$mime" in
        text/*)
          head -n 50 "$file"
          ;;
        image/*)
          ${pkgs.chafa}/bin/chafa --size=80x20 "$file" 2>/dev/null
          ;;
        *)
          echo "Preview not available"
          ;;
      esac
    '';
  };
}
