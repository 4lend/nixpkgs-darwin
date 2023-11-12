{
  description = "Minimal Nix for macOS configuration";

  ##################################################################################################################
  # 
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  # 
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      # Replace official cache with a mirror located in China
      #
      # Feel free to remove this line if you are not in China
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utilities
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";

    # Homebrew
    homebrew = {
      url = "github:Homebrew/brew";
      flake = false;
    };

    # Other sources
    comma = {
      url = "github:Shopify/comma";
      flake = false;
    };
  };

  # The `outputs` function will return all the build results of the flake. 
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      system = {
        x86_64-linux = "x86_64-linux";
        x86_64-darwin = "x86_64-darwin";
        aarch64-darwin = "aarch64-darwin";
        aarch64-linux = "aarch64-linux";
      };

      primaryUserInfo = rec {
        username = "4lend";
        fullname = "alfurqani";
        email = "syifa.alfurqoni@gmail.com";
        nixConfigDirectory =
          "/Users/alfurqani/.config/nixpkgs/nix-darwin-kickstarter/minimal";
        within = {
          gpg.enable = true;
          pass.enable = true;
        };
      };

      homeManagerStateVersion = "23.05";
      lib = darwin.lib;

      randomModules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/homebrew.nix
        ./modules/host-users.nix
      ];

      homeManagerModules = {
        imports = [
          ./home/home.nix
          ./home/alacritty.nix
          ./home/aria2.nix
          ./home/fzf.nix
          ./home/git.nix
          ./home/helix.nix
          ./home/kitty.nix
          ./home/packages.nix
          ./home/shells.nix
          ./home/tmux.nix
          # ./home/neovim.nix
        ];
      };

    in
    {

      darwinConfigurations = rec {
        ${primaryUserInfo.fullname} = lib.darwinSystem {
          system = system.x86_64-darwin;
          modules = randomModules ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs;
              home-manager.users.${primaryUserInfo.fullname} = homeManagerModules;
            }
          ];
        };
        # nix code formatter
        # TODO also change this line to "aarch64-darwin" if you are using Apple Silicon
        formatter.x86_64-darwin =
          nixpkgs.legacyPackages.x86_64-darwin.alejandra;

        # darwinModules = {
        #   system = import ./system/darwin-configuration.nix;
        # };
      };

    };
}
