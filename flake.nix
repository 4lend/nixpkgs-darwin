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
      "https://cache.nixos.org"
      "https://cache.komunix.org"
      # "https://cachix.org"
      # "https://mirrors.ustc.edu.cn/nix-channels/store"  # china mirror
      # "https://mirrors.tuna.tsinghua.edu.cn"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    # Home manager
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
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
        linux64 = "x86_64-linux";
        linuxArm = "aarch64-linux";
        mac64 = "x86_64-darwin";
        macArm = "aarch64-darwin";
      };

      primaryUserInfo = rec {
        username = "4lend";
        fullname = "alfurqani";
        email = "syifa.alfurqoni@gmail.com";
        nixConfigDirectory =
          "/Users/alfurqani/.config";
        within = {
          gpg.enable = true;
          pass.enable = true;
        };
      };

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
          ./home/kitty.nix
          ./home/mpv.nix
          ./home/neovim
          ./home/packages.nix
          ./home/ranger.nix
          ./home/shells.nix
          ./home/tmux.nix
          ./home/yt-dlp.nix
        ];
      };

      shellConfig = import ./home/shells.nix;
      fishConfig = shellConfig.fishConfig;
      shellAliases = shellConfig.shellAliases;

      flakePath = builtins.toString ./.;

    in
    {
      darwinConfigurations = rec {
        ${primaryUserInfo.fullname} = lib.darwinSystem {
          system = system.mac64;
          modules = randomModules ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs;
              # home-manager.extraSpecialArgs = { inherit fishConfig shellAliases; };
              home-manager.users.${primaryUserInfo.fullname} = homeManagerModules;
            }
          ];
          # activationScript = ''
          #   sudo dscl . -create /Users/$USER UserShell /etc/profiles/per-user/alfurqani/bin/fish
          #   echo "Default shell changed to /etc/profiles/per-user/alfurqani/bin/fish
          # '';
        };
        # TODO also change this line to "aarch64-darwin" if you are using Apple Silicon
        formatter.x86_64-darwin =
          nixpkgs.legacyPackages.x86_64-darwin.alejandra;
        # darwinModules = {
        #   system = import ./system/darwin-configuration.nix;
        # };
      };

    };
}
