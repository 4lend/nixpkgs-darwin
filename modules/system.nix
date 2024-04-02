{ pkgs, config, lib, options, ... }:
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
{

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
      echotest = {
        enable = true;
        text = ''
          echo "echo test is working!"
        '';
      };
    };

    defaults = {
      menuExtraClock.Show24Hour = true;  # show 24 hour clock
    };

  };

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
