{ pkgs, nixpkgs-unstable, ... }:
{
  home.packages = [
    (nixpkgs-unstable.legacyPackages.${pkgs.system}.vifm)
  ];
}
