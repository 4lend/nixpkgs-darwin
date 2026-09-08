{ pkgs, config, lib, options, ... }:
# All the configuration options are documented here:
# https://daiderd.com/nix-darwin/manual/index.html#sec-options
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      
      victor-mono
      comic-mono
      comic-neue
      comic-relief
      noto-fonts
      noto-fonts-color-emoji
      ibm-plex
      smiley-sans
      lxgw-wenkai
      comfortaa
      lexend
      overpass
      google-fonts
    ];
  };

  system = {
    # activationScripts are executed every time you boot the system
    stateVersion = 5;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  # This is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
