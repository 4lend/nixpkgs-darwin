{ pkgs, ... }:
{
  programs.vifm = {
    enable = true;
    extraConfig = builtins.readFile ./vifmrc;
  };

  xdg.configFile = {
    "vifm/colors/gruvbox.vifm".source = ./colors/gruvbox.vifm;
    # kalau nanti mau nambah tema lain, tinggal tambah di sini:
    # "vifm/colors/dracula.vifm".source = ./colors/dracula.vifm;
  };
}
