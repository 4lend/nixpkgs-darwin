{ pkgs, lib, ... }:

let
  gcList = {
    hour = "--delete-older-than 1h";
    day = "--delete-older-than 1d";
    week = "--delete-older-than 1w";
    month = "--delete-older-than 1M";
    year = "--delete-older-than 1M";
  };

in
{

  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  # nix.package = pkgs.nixUnstable;
  programs.nix-index.enable = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    user = "root";
    automatic = lib.mkForce true;
    options = lib.mkForce (gcList.week);
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

}
