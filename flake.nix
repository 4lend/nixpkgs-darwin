{
  description = "ALiSO Minimal Nix";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://cache.nixos.org" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
    homebrew = { url = "github:Homebrew/brew"; flake = false; };
    comma = { url = "github:Shopify/comma"; flake = false; };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager, ... }@inputs:
    let
      system = {
        linux64 = "x86_64-linux";
        linuxArm = "aarch64-linux";
        mac64 = "x86_64-darwin";
        macArm = "aarch64-darwin";
      };

      primaryUserInfo = rec {
        username = "4lend";
        fullname = "alfurqani";
        email = "syifa.alfurqoni@gmail.com";
        nixConfigDirectory = "/Users/alfurqani/.config";
        within = { gpg.enable = true; pass.enable = true; };
      };

      shellConfig = import ./home/shells.nix;
      fishConfig = shellConfig.fishConfig;
      shellAliases = shellConfig.shellAliases;

      lib = darwin.lib;

      systemModules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/homebrew.nix
        ./modules/host-users.nix
      ];

      homeManagerModules = {
        imports = [
          ./home/home.nix
          ./home/home-manager-cli.nix
          ./home/vifm
          ./home/nnn.nix
          ./home/lf
          ./home/alacritty.nix
          ./home/aria2.nix
          ./home/fzf.nix
          ./home/git.nix
          ./home/kitty.nix
          ./home/mpv
          ./home/neovim
          ./home/packages.nix
          ./home/shells.nix
          ./home/tmux.nix
          ./home/yt-dlp.nix
          ./home/ranger.nix
          ./home/yazi.nix
        ];
      };

    in
    {
      darwinConfigurations.${primaryUserInfo.fullname} = lib.darwinSystem {
        system = system.mac64;
        modules = systemModules ++ [
          home-manager.darwinModules.home-manager
          {
            system.primaryUser = "alfurqani";
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs;
            home-manager.users.${primaryUserInfo.fullname} = homeManagerModules;
          }
        ];
      };

      homeConfigurations.${primaryUserInfo.fullname} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system.mac64};
        modules = [
          homeManagerModules
          {
            home = {
              username = primaryUserInfo.fullname;
              homeDirectory = "/Users/alfurqani";
              stateVersion = "24.11";
            };
          }
        ];
        extraSpecialArgs = inputs;
      };

      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    };
}
