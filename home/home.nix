{ ... }:

let
  primaryUserInfo = rec {
    username = "4lend";
    fullname = "alfurqani";
    email = "syifa.alfurqoni@gmail.com";
    homeDirectory = "/Users/${fullname}";
    nixConfigDirectory =
      "/Users/alfurqani/.config/nixpkgs/nix-darwin-kickstarter/minimal";
    within = {
      gpg.enable = true;
      pass.enable = true;
    };
  };
  homeManagerStateVersion = "23.11";  # 23.11 / 24.05
  flakePath = builtins.toString ./.;
  localBin = "$HOME/.local/bin";

in
{
  xdg = {
    configFile = {
      "./lf".source = ./configs/lf;
      "./dash".source = ./configs/dash;
      "./vifm".source = ./configs/vifm;
      "./wezterm".source = ./configs/wezterm;
    };
    # dataHome = "$HOME/.local/share";
    dataFile = {
      "lf".source = ./locals/lf;
    };
  };

  home = {
    username = "${primaryUserInfo.fullname}";
    homeDirectory = primaryUserInfo.homeDirectory;
    enableNixpkgsReleaseCheck = true;
    stateVersion = homeManagerStateVersion;
  };

  programs = {
    home-manager.enable = true;
    fish.enable = true;
  };
}
