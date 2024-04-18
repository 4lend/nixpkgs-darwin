{ pkgs, config, lib, options, ... }:
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "CodeNewRoman" "SpaceMono" "ComicShannsMono" "ProFont" "FiraCode" ]; })
      nerd-font-patcher
      victor-mono
      comic-mono
      comic-neue
      comic-relief
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      vistafonts
      helvetica-neue-lt-std
      victor-mono
      ibm-plex
      smiley-sans # A condensed and oblique Chinese typeface seeking a visual balance between the humanist and the geometric
      lxgw-wenkai # An open-source Chinese font derived from Fontworks' Klee One
      lexend # A variable font family designed to aid in reading proficiency
      comfortaa
      lexend
      overpass
    ];
  };

  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts = {
      postUserActivation.text = ''
        # activateSettings -u will reload the settings from the database and apply them to the current session,
        # so we do not need to logout and login again to make the changes take effect.
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
      fishAsDefaultShell = {
        enable = true;
        text = ''
          sudo dscl . -create /Users/$USER UserShell /etc/profiles/per-user/alfurqani/bin/fish
          echo "Default shell changed to /etc/profiles/per-user/alfurqani/bin/fish
        '';
      };
      setFishAsDefaultShell = ''
        echo "Setting Fish as the default shell..."
        USER_SHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')

        if [ "$USER_SHELL" != "/etc/profiles/per-user/alfurqani/bin/fish" ]; then
          sudo dscl . -create /Users/$USER UserShell /etc/profiles/per-user/alfurqani/bin/fish
          echo "Default shell changed to /etc/profiles/per-user/alfurqani/bin/fish"
        else
          echo "Fish is already set as the default shell."
        fi
      '';
      echotest = {
        enable = true;
        text = ''
          echo "echo test is working!"
          NEK IKI DI PRINT BRARTI IKI ISO!!
        '';
      };
    };

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock
    };

  };

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
