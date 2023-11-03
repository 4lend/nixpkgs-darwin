{ ... }:

let
  # please replace xxx with your username
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

in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${primaryUserInfo.fullname}";
    homeDirectory = primaryUserInfo.homeDirectory;

    enableNixpkgsReleaseCheck = true;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    fish.enable = true;
  };
}
